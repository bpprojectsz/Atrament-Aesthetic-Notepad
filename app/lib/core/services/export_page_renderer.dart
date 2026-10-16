import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:intl/intl.dart' show Bidi;

import '../utils/export_helper.dart';

/// One rendered page: raw RGBA pixels.
class RenderedPage {
  const RenderedPage({
    required this.rgba,
    required this.width,
    required this.height,
  });

  final Uint8List rgba;
  final int width;
  final int height;
}

/// Draws a note onto A4-proportioned page images using Flutter's own text
/// layout and the phone's fonts. The built-in PDF fonts can only draw
/// Western European text; this path draws any script (CJK, Arabic, Hebrew,
/// Hindi, Cyrillic, ...), right-to-left text in the right direction, and
/// handwriting.
class ExportPageRenderer {
  const ExportPageRenderer({this.scale = 1.5});

  /// Pixels per PDF point. 1.5 keeps text crisp on screen and in print
  /// while keeping the files small.
  final double scale;

  /// A4 in PDF points (what `PdfPageFormat.a4` uses).
  static const double pageWidthPt = 595.275590551181;
  static const double pageHeightPt = 841.8897637795275;

  static const double _titleGapPt = 4;
  static const double _headerGapPt = 16;
  static const double _footerGapPt = 24;
  static const double _maxInkEnlargement = 1.5;

  TextDirection _directionOf(String text) =>
      Bidi.detectRtlDirectionality(text) ? TextDirection.rtl : TextDirection.ltr;

  TextPainter _painter(String text, TextStyle style, double width) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: _directionOf(text),
      textAlign: TextAlign.start,
    )..layout(minWidth: width, maxWidth: width);
  }

  Future<List<RenderedPage>> renderPages(ExportableNote note) async {
    const margin = ExportLayout.pdfPageMarginPt;
    const contentWidth = pageWidthPt - 2 * margin;
    const contentHeight = pageHeightPt - 2 * margin;

    final title = _painter(
      note.title,
      const TextStyle(
        color: Color(0xFF000000),
        fontSize: ExportLayout.pdfTitleFontSizePt,
        fontWeight: FontWeight.bold,
      ),
      contentWidth,
    );
    final date = _painter(
      note.createdAtLabel,
      const TextStyle(
        color: Color(0xFF757575),
        fontSize: ExportLayout.pdfFooterFontSizePt,
      ),
      contentWidth,
    );
    final headerHeight =
        title.height + _titleGapPt + date.height + _headerGapPt;

    final bodyText = note.plainTextContent.trimRight();
    final body = (note.hasInk || bodyText.isEmpty)
        ? null
        : _painter(
            bodyText,
            const TextStyle(
              color: Color(0xFF000000),
              fontSize: ExportLayout.pdfBodyFontSizePt,
              height: ExportLayout.pdfLineSpacing,
            ),
            contentWidth,
          );

    final verse = note.verseReferenceLabel == null
        ? null
        : _painter(
            '— ${note.verseReferenceLabel}',
            const TextStyle(
              color: Color(0xFF757575),
              fontSize: ExportLayout.pdfFooterFontSizePt,
              fontStyle: FontStyle.italic,
            ),
            contentWidth,
          );

    // Where each page's slice of the body starts (a line boundary).
    final breaks = <double>[0];
    var lastBodyBottom = 0.0;
    if (body != null) {
      var pageStart = 0.0;
      var available = contentHeight - headerHeight;
      for (final line in body.computeLineMetrics()) {
        final top = line.baseline - line.ascent;
        final bottom = line.baseline + line.descent;
        if (bottom - pageStart > available && top > pageStart) {
          breaks.add(top);
          pageStart = top;
          available = contentHeight;
        }
        lastBodyBottom = bottom;
      }
    }

    // The verse reference follows the text; if the last page has no room
    // for it, it gets a page of its own. (On a drawing page it sits at the
    // bottom, under the ink.)
    var pageCount = breaks.length;
    var verseOnOwnPage = false;
    if (verse != null && !note.hasInk) {
      final usedOnLast =
          (pageCount == 1 ? headerHeight : 0.0) +
          (body == null ? 0.0 : lastBodyBottom - breaks.last);
      if (usedOnLast + _footerGapPt + verse.height > contentHeight) {
        verseOnOwnPage = true;
        pageCount++;
      }
    }

    final pages = <RenderedPage>[];
    for (var index = 0; index < pageCount; index++) {
      final isFirst = index == 0;
      final isLast = index == pageCount - 1;
      final bodyIndex = verseOnOwnPage && isLast ? -1 : index;

      pages.add(
        await _renderPage((canvas) {
          var y = 0.0;
          if (isFirst) {
            title.paint(canvas, Offset.zero);
            date.paint(canvas, Offset(0, title.height + _titleGapPt));
            y = headerHeight;
          }

          final verseSpace =
              verse == null ? 0.0 : verse.height + _footerGapPt;

          if (note.hasInk && isFirst) {
            _drawInk(
              canvas,
              note.ink!,
              ui.Rect.fromLTWH(
                0,
                y,
                contentWidth,
                contentHeight - y - verseSpace,
              ),
            );
          }

          if (body != null && bodyIndex >= 0) {
            final start = breaks[bodyIndex];
            final end = bodyIndex + 1 < breaks.length
                ? breaks[bodyIndex + 1]
                : body.height;
            canvas.save();
            canvas.clipRect(ui.Rect.fromLTWH(0, y, contentWidth, end - start));
            canvas.translate(0, y - start);
            body.paint(canvas, Offset.zero);
            canvas.restore();
            y += end - start;
          }

          if (verse != null && isLast) {
            final double verseY;
            if (verseOnOwnPage) {
              verseY = 0;
            } else if (note.hasInk) {
              verseY = contentHeight - verse.height;
            } else {
              verseY = y + _footerGapPt;
            }
            verse.paint(canvas, Offset(0, verseY));
          }
        }),
      );
    }
    return pages;
  }

  Future<RenderedPage> _renderPage(void Function(Canvas canvas) draw) async {
    final width = (pageWidthPt * scale).round();
    final height = (pageHeightPt * scale).round();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    );
    // Fill whole pixels. (Filling in point units leaves the last row and
    // column of pixels only partly covered: a faint line along the edges.)
    canvas.drawRect(
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      Paint()..color = const Color(0xFFFFFFFF),
    );
    canvas.scale(scale);
    canvas.translate(
      ExportLayout.pdfPageMarginPt,
      ExportLayout.pdfPageMarginPt,
    );
    draw(canvas);

    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    picture.dispose();
    return RenderedPage(
      rgba: data!.buffer.asUint8List(),
      width: width,
      height: height,
    );
  }

  /// Draws the whole drawing, scaled down (or modestly up) to fit [area].
  void _drawInk(Canvas canvas, List<ExportInkStroke> strokes, ui.Rect area) {
    if (strokes.isEmpty) return;

    ui.Rect? bounds;
    var widest = 0.0;
    for (final stroke in strokes) {
      widest = math.max(widest, stroke.strokeWidth);
      for (final point in stroke.points) {
        final r = ui.Rect.fromLTWH(point.dx, point.dy, 0, 0);
        bounds = bounds == null ? r : bounds.expandToInclude(r);
      }
    }
    if (bounds == null) return;
    bounds = bounds.inflate(widest / 2);

    final fit = math.min(
      area.width / math.max(bounds.width, 1),
      area.height / math.max(bounds.height, 1),
    );
    final factor = math.min(fit, _maxInkEnlargement);

    canvas.save();
    canvas.clipRect(area);
    canvas.translate(
      area.left + (area.width - bounds.width * factor) / 2,
      area.top,
    );
    canvas.scale(factor);
    canvas.translate(-bounds.left, -bounds.top);
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }
    canvas.restore();
  }

  void _drawStroke(Canvas canvas, ExportInkStroke stroke) {
    if (stroke.points.isEmpty) return;
    final blend =
        stroke.isHighlighter ? BlendMode.multiply : BlendMode.srcOver;

    if (stroke.points.length == 1) {
      final fill = Paint()
        ..color = Color(stroke.color)
        ..style = PaintingStyle.fill
        ..blendMode = blend;
      final center = stroke.points.first;
      if (stroke.isHighlighter) {
        canvas.drawRect(
          ui.Rect.fromCenter(
            center: center,
            width: stroke.strokeWidth,
            height: stroke.strokeWidth,
          ),
          fill,
        );
      } else {
        canvas.drawCircle(center, stroke.strokeWidth / 2, fill);
      }
      return;
    }

    final paint = Paint()
      ..color = Color(stroke.color)
      ..strokeWidth = stroke.strokeWidth
      ..strokeCap = stroke.isHighlighter ? StrokeCap.square : StrokeCap.round
      ..style = PaintingStyle.stroke
      ..blendMode = blend;
    final path = ui.Path()
      ..moveTo(stroke.points.first.dx, stroke.points.first.dy);
    for (final point in stroke.points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, paint);
  }
}
