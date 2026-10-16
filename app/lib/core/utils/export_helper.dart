import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' show Offset;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// One handwriting stroke, in the canvas's own coordinates. Mirrors what is
/// stored in a handwriting note but is independent of the widget layer.
class ExportInkStroke {
  const ExportInkStroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.isHighlighter,
  });

  final List<Offset> points;
  final int color;
  final double strokeWidth;
  final bool isHighlighter;
}

/// Reads the ink out of a stored note's content.
class ExportInk {
  const ExportInk._();

  /// The strokes of a handwriting note, or null when [content] is not a
  /// handwriting note (typed notes store a Quill delta list instead).
  /// A handwriting note whose strokes can't be read yields an empty list
  /// rather than failing the export.
  static List<ExportInkStroke>? fromNoteContent(String content) {
    final Object? decoded;
    try {
      decoded = jsonDecode(content);
    } catch (_) {
      return null;
    }
    if (decoded is! Map<String, dynamic> || decoded['type'] != 'handwriting') {
      return null;
    }

    final strokes = <ExportInkStroke>[];
    final raw = decoded['strokes'];
    if (raw is! List) return strokes;
    for (final entry in raw) {
      try {
        final map = entry as Map<String, dynamic>;
        final points = (map['points'] as List)
            .map((p) {
              final pair = p as List;
              return Offset(
                (pair[0] as num).toDouble(),
                (pair[1] as num).toDouble(),
              );
            })
            .toList();
        strokes.add(
          ExportInkStroke(
            points: points,
            color: (map['color'] as num).toInt(),
            strokeWidth: (map['strokeWidth'] as num).toDouble(),
            isHighlighter: map['isHighlighter'] as bool? ?? false,
          ),
        );
      } catch (_) {
        // Skip a damaged stroke; keep the rest of the drawing.
      }
    }
    return strokes;
  }
}

/// Plain-text representation of a note, decoupled from `NoteModel` so this
/// helper stays a pure, model-agnostic utility (models live in
/// `core/models` and depend on nothing in `core/utils`, not the reverse).
class ExportableNote {
  const ExportableNote({
    required this.title,
    required this.plainTextContent,
    required this.createdAtLabel,
    this.verseReferenceLabel,
    this.ink,
  });

  final String title;
  final String plainTextContent;

  /// Pre-formatted date string (already localized by the caller via
  /// `DateFormatter`) — this helper does no date formatting itself.
  final String createdAtLabel;

  /// Optional "Book 1:1" style reference shown as a footer when the note
  /// has an associated verse.
  final String? verseReferenceLabel;

  /// The drawing, for a handwriting note; null for a typed note. (A
  /// handwriting note with nothing drawn has an empty list.)
  final List<ExportInkStroke>? ink;

  bool get hasInk => ink != null;

  /// True when the standard PDF fonts cannot draw everything in this note —
  /// any ink, or any letters outside Western European languages (Chinese,
  /// Japanese, Korean, Arabic, Hebrew, Hindi, Cyrillic, Greek, Vietnamese,
  /// Polish, ...). Such notes are exported as page images so every
  /// character is drawn with the phone's own fonts.
  bool get needsImageRendering =>
      hasInk ||
      !ExportHelper.canRenderAsPdfText(title) ||
      !ExportHelper.canRenderAsPdfText(plainTextContent) ||
      !ExportHelper.canRenderAsPdfText(createdAtLabel) ||
      (verseReferenceLabel != null &&
          !ExportHelper.canRenderAsPdfText(verseReferenceLabel!));
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
  ///
  /// Uses `pw.MultiPage`, not `pw.Page` — `pw.Page` renders exactly one
  /// fixed page and does not auto-paginate; any note long enough to
  /// overflow a single page would be silently clipped instead of
  /// flowing onto page 2. `MultiPage`'s `build` callback returns a flat
  /// list of widgets (not one widget tree), and lets that top-level list
  /// span multiple pages automatically.
  static pw.Document buildPdfDocument(ExportableNote note) {
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(ExportLayout.pdfPageMarginPt),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (context) => [
          pw.Text(
            note.title,
            style: const pw.TextStyle(
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
          pw.Paragraph(
            text: note.plainTextContent,
            style: const pw.TextStyle(
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
              style: const pw.TextStyle(
                fontSize: ExportLayout.pdfFooterFontSizePt,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ],
      ),
    );

    return document;
  }

  /// Characters the built-in PDF fonts can draw: printable ASCII, Latin-1,
  /// and the extra punctuation of Windows-1252 (curly quotes, dashes,
  /// ellipsis, euro, ...), plus line breaks and tabs.
  static const Set<int> _cp1252Extras = {
    0x20AC, 0x201A, 0x0192, 0x201E, 0x2026, 0x2020, 0x2021, 0x02C6, 0x2030,
    0x0160, 0x2039, 0x0152, 0x017D, 0x2018, 0x2019, 0x201C, 0x201D, 0x2022,
    0x2013, 0x2014, 0x02DC, 0x2122, 0x0161, 0x203A, 0x0153, 0x017E, 0x0178,
  };

  static bool canRenderAsPdfText(String text) {
    for (final rune in text.runes) {
      final ok =
          rune == 0x09 ||
          rune == 0x0A ||
          rune == 0x0D ||
          (rune >= 0x20 && rune <= 0x7E) ||
          (rune >= 0xA0 && rune <= 0xFF) ||
          _cp1252Extras.contains(rune);
      if (!ok) return false;
    }
    return true;
  }

  /// Most characters kept from a title, and the most UTF-8 bytes they may
  /// take (file systems limit a name to ~255 bytes, and CJK/emoji characters
  /// take 3–4 bytes each).
  static const int maxFileNameStemRunes = 60;
  static const int maxFileNameStemBytes = 150;

  /// Sanitizes a note title into a filesystem-safe filename stem (no
  /// extension). Letters and digits from every script are kept (so Arabic,
  /// Chinese, Hindi... titles stay readable and distinct); anything else is
  /// dropped and spaces become underscores. The result is length-limited and
  /// falls back to a generic name if nothing usable remains.
  static String safeFileNameStem(String title) {
    final sanitized = title
        .trim()
        .replaceAll(RegExp(r'[^\p{L}\p{N}\p{M}\s_-]', unicode: true), '')
        .replaceAll(RegExp(r'\s+'), '_');

    final kept = <int>[];
    var bytes = 0;
    for (final rune in sanitized.runes) {
      final size = utf8.encode(String.fromCharCode(rune)).length;
      if (kept.length >= maxFileNameStemRunes ||
          bytes + size > maxFileNameStemBytes) {
        break;
      }
      kept.add(rune);
      bytes += size;
    }

    final stem = String.fromCharCodes(kept).replaceAll(RegExp(r'^[_-]+|[_-]+$'), '');
    return stem.isEmpty ? 'atrament_note' : stem;
  }
}
