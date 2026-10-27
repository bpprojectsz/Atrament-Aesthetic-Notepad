import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/models/pen_style_model.dart';

/// A single freehand stroke: its points, and the exact visual appearance
/// it was drawn with (color, width, highlighter flag) — captured at draw
/// time rather than stored as a live reference to [PenStyleCatalog].
///
/// This matters: strokes are re-rendered from this data on every repaint
/// (e.g. while drawing a *later* stroke). If a stroke only stored
/// `penStyleId` and re-resolved its appearance from the catalog each
/// time, then adjusting the stroke-width slider for the active pen would
/// make every *already-drawn* stroke using that same pen ID silently
/// snap to the new width too — a real mark on paper doesn't change
/// thickness after the fact just because you adjust the pen you're
/// currently holding.
class HandwritingStroke {
  const HandwritingStroke({
    required this.penStyleId,
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.isHighlighter,
  });

  final String penStyleId;
  final List<Offset> points;
  final int color;
  final double strokeWidth;
  final bool isHighlighter;

  Map<String, dynamic> toJson() {
    return {
      'penStyleId': penStyleId,
      'points': points.map((p) => [p.dx, p.dy]).toList(),
      'color': color,
      'strokeWidth': strokeWidth,
      'isHighlighter': isHighlighter,
    };
  }

  factory HandwritingStroke.fromJson(Map<String, dynamic> json) {
    final rawPoints = json['points'] as List<dynamic>;
    // Falls back to the catalog default appearance for strokes saved
    // before this fix, which only ever recorded a penStyleId.
    final fallbackPen = PenStyleCatalog.byId(json['penStyleId'] as String);
    return HandwritingStroke(
      penStyleId: json['penStyleId'] as String,
      points: rawPoints
          .map(
            (p) => Offset(
              (p[0] as num).toDouble(),
              (p[1] as num).toDouble(),
            ),
          )
          .toList(),
      color: json['color'] as int? ?? fallbackPen.color,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ??
          fallbackPen.strokeWidth,
      isHighlighter:
          json['isHighlighter'] as bool? ?? fallbackPen.isHighlighter,
    );
  }
}

/// Controller exposing the stroke history, current pen selection, and
/// undo/redo — held by the parent screen so it can also drive
/// `pen_toolbar.dart` and persist strokes into `NoteModel.content`.
class HandwritingCanvasController extends ChangeNotifier {
  HandwritingCanvasController({List<HandwritingStroke>? initialStrokes})
    : _strokes = List.of(initialStrokes ?? const []);

  final List<HandwritingStroke> _strokes;
  final List<HandwritingStroke> _redoStack = [];

  PenStyleModel _activePen = PenStyleCatalog.byId('fountain_pen');
  bool _erasing = false;

  /// Width (logical pixels) of the canvas the stroke coordinates are
  /// relative to. Saved with the note so the ink can be scaled to fit when
  /// the note is opened at a different width (another phone, rotation).
  /// Null until the canvas has been laid out once (or for notes saved
  /// before this was recorded).
  double? canvasWidth;

  List<HandwritingStroke> get strokes => List.unmodifiable(_strokes);
  PenStyleModel get activePen => _activePen;
  bool get isErasing => _erasing;
  bool get canUndo => _strokes.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void setActivePen(PenStyleModel pen) {
    _activePen = pen;
    _erasing = false;
    notifyListeners();
  }

  /// Adjusts the stroke width of whichever pen is currently active — used
  /// by the toolbar's width slider. Only affects the in-progress stroke
  /// and strokes drawn after this call; strokes already committed via
  /// [addStroke] keep the width they were actually drawn with (see
  /// [HandwritingStroke]'s doc comment for why that matters).
  void setActivePenStrokeWidth(double width) {
    _activePen = _activePen.copyWith(strokeWidth: width);
    notifyListeners();
  }

  void setErasing(bool erasing) {
    _erasing = erasing;
    notifyListeners();
  }

  void addStroke(HandwritingStroke stroke) {
    _strokes.add(stroke);
    _redoStack.clear();
    notifyListeners();
  }

  /// Removes the topmost stroke touched by [point], used when [isErasing] is
  /// active. A stroke is hit if [point] is within [radius] (plus half the
  /// stroke's own thickness) of any *segment* of the stroke — not just its
  /// sampled points, which are far apart for fast strokes.
  void eraseAt(Offset point, {double radius = 12}) {
    if (_eraseTopmostAt(point, radius)) {
      _redoStack.clear();
      notifyListeners();
    }
  }

  /// Erases along the straight path from [from] to [to], so a quick swipe
  /// can't skip over strokes between two touch events.
  void eraseAlong(Offset from, Offset to, {double radius = 12}) {
    final length = (to - from).distance;
    final steps = (length / (radius / 2)).ceil().clamp(1, 200);
    var erasedAny = false;
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final point = Offset.lerp(from, to, t)!;
      // Keep erasing at this spot until nothing else lies under it.
      while (_eraseTopmostAt(point, radius)) {
        erasedAny = true;
      }
    }
    if (erasedAny) {
      _redoStack.clear();
      notifyListeners();
    }
  }

  bool _eraseTopmostAt(Offset point, double radius) {
    for (var i = _strokes.length - 1; i >= 0; i--) {
      final stroke = _strokes[i];
      final reach = radius + stroke.strokeWidth / 2;
      if (_distanceToStroke(point, stroke.points) <= reach) {
        _strokes.removeAt(i);
        return true;
      }
    }
    return false;
  }

  /// Rescales every stroke so ink drawn at [canvasWidth] fits a canvas now
  /// [width] wide, keeping proportions (x and y scale together) and each
  /// stroke's pen width. Silent on purpose: opening a note on a different
  /// screen is not an edit. Returns whether anything was rescaled.
  bool adaptToWidth(double width) {
    if (!width.isFinite || width <= 0) return false;
    final saved = canvasWidth;
    if (saved == null || saved <= 0) {
      canvasWidth = width;
      return false;
    }
    if ((saved - width).abs() < 1) return false;

    final factor = width / saved;
    HandwritingStroke scaled(HandwritingStroke s) => HandwritingStroke(
      penStyleId: s.penStyleId,
      points: s.points.map((p) => p * factor).toList(),
      color: s.color,
      strokeWidth: s.strokeWidth,
      isHighlighter: s.isHighlighter,
    );
    for (var i = 0; i < _strokes.length; i++) {
      _strokes[i] = scaled(_strokes[i]);
    }
    for (var i = 0; i < _redoStack.length; i++) {
      _redoStack[i] = scaled(_redoStack[i]);
    }
    canvasWidth = width;
    return true;
  }

  void undo() {
    if (_strokes.isEmpty) return;
    _redoStack.add(_strokes.removeLast());
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    _strokes.add(_redoStack.removeLast());
    notifyListeners();
  }

  void clear() {
    _strokes.clear();
    _redoStack.clear();
    notifyListeners();
  }

  /// Serializes all strokes to a JSON string for storage in
  /// `NoteModel.content` when the note's paper mode is handwriting.
  String toJsonString() {
    return jsonEncode(_strokes.map((s) => s.toJson()).toList());
  }

  /// The note-content form of this ink: the stroke list plus the canvas
  /// width it was drawn at. (Plain [toJsonString] stays strokes-only.)
  String toWrappedContent() {
    return jsonEncode({
      'type': 'handwriting',
      if (canvasWidth != null) 'canvasWidth': canvasWidth,
      'strokes': _strokes.map((s) => s.toJson()).toList(),
    });
  }

  /// Reads [toWrappedContent]'s output. Throws on malformed data (callers
  /// decide how to recover). Notes saved before the canvas width was
  /// recorded simply have none.
  factory HandwritingCanvasController.fromWrappedContent(String raw) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final rawStrokes = decoded['strokes'] as List<dynamic>? ?? const [];
    final strokes = rawStrokes
        .map((e) => HandwritingStroke.fromJson(e as Map<String, dynamic>))
        .toList();
    final width = (decoded['canvasWidth'] as num?)?.toDouble();
    return HandwritingCanvasController(initialStrokes: strokes)
      ..canvasWidth = width;
  }

  factory HandwritingCanvasController.fromJsonString(String raw) {
    if (raw.trim().isEmpty) return HandwritingCanvasController();
    final decoded = jsonDecode(raw) as List<dynamic>;
    final strokes = decoded
        .map((e) => HandwritingStroke.fromJson(e as Map<String, dynamic>))
        .toList();
    return HandwritingCanvasController(initialStrokes: strokes);
  }
}

/// Distance from [p] to the segment a-b.
double _distanceToSegment(Offset p, Offset a, Offset b) {
  final ab = b - a;
  final lengthSquared = ab.dx * ab.dx + ab.dy * ab.dy;
  if (lengthSquared == 0) return (p - a).distance;
  final t = (((p - a).dx * ab.dx + (p - a).dy * ab.dy) / lengthSquared)
      .clamp(0.0, 1.0);
  return (p - (a + ab * t)).distance;
}

double _distanceToStroke(Offset p, List<Offset> points) {
  if (points.isEmpty) return double.infinity;
  if (points.length == 1) return (p - points.first).distance;
  var best = double.infinity;
  for (var i = 0; i < points.length - 1; i++) {
    final d = _distanceToSegment(p, points[i], points[i + 1]);
    if (d < best) best = d;
  }
  return best;
}

/// Freehand ink canvas. Raw pointer events (not a drag gesture) so a stroke
/// starts exactly where the finger lands — a drag recogniser only fires after
/// the finger has already moved ~18–36px, which cut the start off every
/// stroke and swallowed taps and short marks. Only the first finger on the
/// screen draws; extra touches (a resting palm) are ignored.
class HandwritingCanvas extends StatefulWidget {
  const HandwritingCanvas({super.key, required this.controller});

  final HandwritingCanvasController controller;

  @override
  State<HandwritingCanvas> createState() => _HandwritingCanvasState();
}

class _HandwritingCanvasState extends State<HandwritingCanvas> {
  final List<Offset> _currentPoints = [];
  int? _activePointer;
  Offset? _lastErasePoint;

  void _onPointerDown(PointerDownEvent event) {
    if (_activePointer != null) return;
    _activePointer = event.pointer;
    final point = event.localPosition;
    if (widget.controller.isErasing) {
      _lastErasePoint = point;
      widget.controller.eraseAt(point);
      return;
    }
    setState(() {
      _currentPoints
        ..clear()
        ..add(point);
    });
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (event.pointer != _activePointer) return;
    final point = event.localPosition;
    if (widget.controller.isErasing) {
      final from = _lastErasePoint ?? point;
      widget.controller.eraseAlong(from, point);
      _lastErasePoint = point;
      return;
    }
    if (_currentPoints.isNotEmpty && _currentPoints.last == point) return;
    setState(() => _currentPoints.add(point));
  }

  void _onPointerUp(PointerUpEvent event) {
    if (event.pointer != _activePointer) return;
    _activePointer = null;
    _lastErasePoint = null;
    if (widget.controller.isErasing || _currentPoints.isEmpty) {
      setState(_currentPoints.clear);
      return;
    }
    final pen = widget.controller.activePen;
    // A tap (a single point) is a dot, e.g. the dot of an "i" or a full stop.
    widget.controller.addStroke(
      HandwritingStroke(
        penStyleId: pen.id,
        points: List.of(_currentPoints),
        color: pen.color,
        strokeWidth: pen.strokeWidth,
        isHighlighter: pen.isHighlighter,
      ),
    );
    setState(_currentPoints.clear);
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (event.pointer != _activePointer) return;
    // The system took the touch away (e.g. a system gesture): drop the
    // half-drawn stroke rather than committing a fragment.
    _activePointer = null;
    _lastErasePoint = null;
    setState(_currentPoints.clear);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Fit saved ink to this screen's width before painting it.
          widget.controller.adaptToWidth(constraints.maxWidth);
          return AnimatedBuilder(
            animation: widget.controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _HandwritingPainter(
                  strokes: widget.controller.strokes,
                  inProgress: _currentPoints,
                  inProgressLength: _currentPoints.length,
                  inProgressPen: widget.controller.activePen,
                  canvasWidth: widget.controller.canvasWidth,
                ),
                size: Size.infinite,
              );
            },
          );
        },
      ),
    );
  }
}

class _HandwritingPainter extends CustomPainter {
  _HandwritingPainter({
    required this.strokes,
    required this.inProgress,
    required this.inProgressLength,
    required this.inProgressPen,
    required this.canvasWidth,
  });

  final List<HandwritingStroke> strokes;
  final List<Offset> inProgress;

  /// The in-progress list is mutated in place, so its length at build time
  /// is recorded to tell whether it changed since the last paint.
  final int inProgressLength;
  final PenStyleModel inProgressPen;
  final double? canvasWidth;

  void _paintStroke(
    Canvas canvas,
    List<Offset> points, {
    required int color,
    required double strokeWidth,
    required bool isHighlighter,
  }) {
    if (points.isEmpty) return;

    final blend = isHighlighter ? BlendMode.multiply : BlendMode.srcOver;

    if (points.length == 1) {
      // A tap: draw a dot the size of the pen tip.
      final fill = Paint()
        ..color = Color(color)
        ..style = PaintingStyle.fill
        ..blendMode = blend;
      final center = points.first;
      if (isHighlighter) {
        canvas.drawRect(
          Rect.fromCenter(center: center, width: strokeWidth, height: strokeWidth),
          fill,
        );
      } else {
        canvas.drawCircle(center, strokeWidth / 2, fill);
      }
      return;
    }

    final paint = Paint()
      ..color = Color(color)
      ..strokeWidth = strokeWidth
      ..strokeCap = isHighlighter ? StrokeCap.square : StrokeCap.round
      ..style = PaintingStyle.stroke
      ..blendMode = blend;

    final path = ui.Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _paintStroke(
        canvas,
        stroke.points,
        color: stroke.color,
        strokeWidth: stroke.strokeWidth,
        isHighlighter: stroke.isHighlighter,
      );
    }
    _paintStroke(
      canvas,
      inProgress,
      color: inProgressPen.color,
      strokeWidth: inProgressPen.strokeWidth,
      isHighlighter: inProgressPen.isHighlighter,
    );
  }

  @override
  bool shouldRepaint(covariant _HandwritingPainter oldDelegate) {
    return oldDelegate.strokes.length != strokes.length ||
        oldDelegate.inProgressLength != inProgressLength ||
        oldDelegate.canvasWidth != canvasWidth;
  }
}
