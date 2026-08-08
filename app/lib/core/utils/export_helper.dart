import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Plain-text representation of a note, decoupled from `NoteModel` so this
/// helper stays a pure, model-agnostic utility (models live in
/// `core/models` and depend on nothing in `core/utils`, not the reverse).
class ExportableNote {
  const ExportableNote({
    required this.title,
    required this.plainTextContent,
    required this.createdAtLabel,
    this.verseReferenceLabel,
  });

  final String title;
  final String plainTextContent;

  /// Pre-formatted date string (already localized by the caller via
  /// `DateFormatter`) — this helper does no date formatting itself.
  final String createdAtLabel;

  /// Optional "Book 1:1" style reference shown as a footer when the note
  /// has an associated verse.
  final String? verseReferenceLabel;
}

/// Layout constants for PDF/image export, kept as tokens rather than magic
/// numbers scattered across `export_service.dart`.
class ExportLayout {
  const ExportLayout._();

  static const double pdfPageMarginPt = 48;
  static const double pdfTitleFontSizePt = 20;
  static const double pdfBodyFontSizePt = 12;
  static const double pdfFooterFontSizePt = 9;
  static const double pdfLineSpacing = 1.5;

  /// Target size for the "share card" PNG export (2x for retina sharpness).
  static const double shareCardWidthPx = 1080;
  static const double shareCardHeightPx = 1350;
}

class ExportHelper {
  const ExportHelper._();

  /// Encodes a note as UTF-8 plain text, including a light-touch header and
  /// optional verse footer. Returned as bytes ready for `path_provider` +
  /// file write.
  static Uint8List buildTxtBytes(ExportableNote note) {
    final buffer = StringBuffer()
      ..writeln(note.title)
      ..writeln(note.createdAtLabel)
      ..writeln('')
      ..writeln(note.plainTextContent);

    if (note.verseReferenceLabel != null) {
      buffer
        ..writeln('')
        ..writeln('— ${note.verseReferenceLabel}');
    }

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }

  /// Builds a single-note PDF document. Rendering (`document.save()`) is
  /// left to the caller (`export_service.dart`) so this helper stays
  /// synchronous and easily unit-testable.
  static pw.Document buildPdfDocument(ExportableNote note) {
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(ExportLayout.pdfPageMarginPt),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                note.title,
                style: pw.TextStyle(
                  fontSize: ExportLayout.pdfTitleFontSizePt,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                note.createdAtLabel,
                style: const pw.TextStyle(
                  fontSize: ExportLayout.pdfFooterFontSizePt,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                note.plainTextContent,
                style: pw.TextStyle(
                  fontSize: ExportLayout.pdfBodyFontSizePt,
                  lineSpacing:
                      ExportLayout.pdfBodyFontSizePt *
                      (ExportLayout.pdfLineSpacing - 1),
                ),
              ),
              if (note.verseReferenceLabel != null) ...[
                pw.SizedBox(height: 24),
                pw.Text(
                  '— ${note.verseReferenceLabel}',
                  style: pw.TextStyle(
                    fontSize: ExportLayout.pdfFooterFontSizePt,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.grey600,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );

    return document;
  }

  /// Sanitizes a note title into a filesystem-safe filename stem (no
  /// extension). Falls back to a generic name if the title is empty or
  /// entirely made of unsafe characters.
  static String safeFileNameStem(String title) {
    final trimmed = title.trim();
    final sanitized = trimmed
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
    return sanitized.isEmpty ? 'atrament_note' : sanitized;
  }
}
