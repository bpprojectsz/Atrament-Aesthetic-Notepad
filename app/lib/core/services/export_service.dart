import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/error_handler.dart';
import '../utils/export_helper.dart';
import 'export_page_renderer.dart';

/// Outcome of an export attempt, surfaced by the caller as an explicit
/// success/error message (Section 15: "every save/delete/share shows
/// explicit success/error feedback").
class ExportResult {
  const ExportResult.success(this.filePath) : errorMessage = null;
  const ExportResult.failure() : filePath = null;

  final String? filePath;

  bool get succeeded => filePath != null;
}

/// Writes exported note content to a temporary file via `path_provider`.
/// Handing the resulting file off to the system share sheet is the
/// responsibility of `platform/share_service.dart` — this service only
/// produces bytes and writes them to disk; it never touches `share_plus`
/// directly, keeping the core/platform boundary intact (Section 4).
class ExportService {
  /// [clock] is only for tests; it stamps the file names.
  const ExportService({this.clock});

  final DateTime Function()? clock;

  /// `20261015_143007` — always ASCII digits, whatever the app language.
  String _timestamp() {
    final t = (clock ?? DateTime.now)();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${t.year.toString().padLeft(4, '0')}${two(t.month)}${two(t.day)}'
        '_${two(t.hour)}${two(t.minute)}${two(t.second)}';
  }

  Future<Directory> _exportDirectory() async {
    final dir = await getTemporaryDirectory();
    final exportsDir = Directory(p.join(dir.path, 'exports'));
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }
    return exportsDir;
  }

  Future<ExportResult> _writeBytes(
    Uint8List bytes,
    String fileNameStem,
    String extension,
  ) async {
    try {
      final dir = await _exportDirectory();
      // Title + timestamp, so two notes with the same (or entirely
      // non-Latin) title never overwrite each other's file, and a repeat
      // export in the same second gets a "-2" instead of replacing the first.
      final base = '${fileNameStem}_${_timestamp()}';
      var path = p.join(dir.path, '$base.$extension');
      var counter = 2;
      while (await File(path).exists()) {
        path = p.join(dir.path, '$base-$counter.$extension');
        counter++;
      }
      final file = File(path);
      await file.writeAsBytes(bytes, flush: true);
      return ExportResult.success(path);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to write export file',
        context: 'export_service.writeBytes.$extension',
        severity: ErrorSeverity.warning,
      );
      return const ExportResult.failure();
    }
  }

  /// Exports [note] as a plain-text `.txt` file.
  Future<ExportResult> exportAsTxt(ExportableNote note) async {
    final bytes = ExportHelper.buildTxtBytes(note);
    final stem = ExportHelper.safeFileNameStem(note.title);
    return _writeBytes(bytes, stem, 'txt');
  }

  /// Handwriting, and text in scripts the standard PDF fonts cannot draw,
  /// is exported as page images drawn with the phone's own fonts; everything
  /// else is a normal text PDF (smaller, with selectable text).
  Future<Uint8List> _buildPdfBytes(ExportableNote note) async {
    if (!note.needsImageRendering) {
      return ExportHelper.buildPdfDocument(note).save();
    }
    final pages = await const ExportPageRenderer().renderPages(note);
    final document = pw.Document();
    for (final page in pages) {
      final image = pw.RawImage(
        bytes: page.rgba,
        width: page.width,
        height: page.height,
      );
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (_) => pw.Image(
            image,
            width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.height,
            fit: pw.BoxFit.fill,
          ),
        ),
      );
    }
    return document.save();
  }

  /// Exports [note] as a formatted `.pdf` file.
  Future<ExportResult> exportAsPdf(ExportableNote note) async {
    try {
      final bytes = await _buildPdfBytes(note);
      final stem = ExportHelper.safeFileNameStem(note.title);
      return await _writeBytes(bytes, stem, 'pdf');
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to render PDF',
        context: 'export_service.exportAsPdf',
        severity: ErrorSeverity.warning,
      );
      return const ExportResult.failure();
    }
  }

  /// Writes an already-rendered PNG share-card image (captured by the
  /// screen via `RepaintBoundary`/`screenshot`) to a temporary file.
  /// Image composition itself happens in the widget layer, since it
  /// depends on live render objects this service has no access to.
  Future<ExportResult> exportAsImage(
    Uint8List pngBytes,
    String noteTitle,
  ) async {
    final stem = ExportHelper.safeFileNameStem(noteTitle);
    return _writeBytes(pngBytes, stem, 'png');
  }

  /// Deletes previously written export files older than [maxAge] to avoid
  /// unbounded growth of the temporary exports directory over app
  /// lifetime. Safe to call opportunistically (e.g. on app start); failures
  /// are logged as warnings and never surfaced to the user.
  Future<void> pruneOldExports({
    Duration maxAge = const Duration(days: 1),
  }) async {
    try {
      final dir = await _exportDirectory();
      final now = DateTime.now();
      await for (final entity in dir.list()) {
        if (entity is! File) continue;
        final stat = await entity.stat();
        if (now.difference(stat.modified) > maxAge) {
          await entity.delete();
        }
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to prune old export files',
        context: 'export_service.pruneOldExports',
        severity: ErrorSeverity.warning,
      );
    }
  }
}
