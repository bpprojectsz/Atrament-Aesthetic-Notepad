import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../utils/error_handler.dart';
import '../utils/export_helper.dart';

/// Outcome of an export attempt, surfaced by the caller as an explicit
/// success/error message (Section 15: "every save/delete/share shows
/// explicit success/error feedback").
class ExportResult {
  const ExportResult.success(this.filePath) : errorMessage = null;
  const ExportResult.failure(this.errorMessage) : filePath = null;

  final String? filePath;
  final String? errorMessage;

  bool get succeeded => filePath != null;
}

/// Writes exported note content to a temporary file via `path_provider`.
/// Handing the resulting file off to the system share sheet is the
/// responsibility of `platform/share_service.dart` — this service only
/// produces bytes and writes them to disk; it never touches `share_plus`
/// directly, keeping the core/platform boundary intact (Section 4).
class ExportService {
  const ExportService();

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
      final path = p.join(dir.path, '$fileNameStem.$extension');
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
      return const ExportResult.failure(
        'Could not create the export file. Please try again.',
      );
    }
  }

  /// Exports [note] as a plain-text `.txt` file.
  Future<ExportResult> exportAsTxt(ExportableNote note) async {
    final bytes = ExportHelper.buildTxtBytes(note);
    final stem = ExportHelper.safeFileNameStem(note.title);
    return _writeBytes(bytes, stem, 'txt');
  }

  /// Exports [note] as a formatted `.pdf` file.
  Future<ExportResult> exportAsPdf(ExportableNote note) async {
    try {
      final document = ExportHelper.buildPdfDocument(note);
      final bytes = await document.save();
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
      return const ExportResult.failure(
        'Could not generate the PDF. Please try again.',
      );
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
