import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/models/pen_style_model.dart';

/// A single freehand stroke: the pen used and its sequence of points, in
/// the canvas's local coordinate space.
class HandwritingStroke {
  const HandwritingStroke({required this.penStyleId, required this.points});

  final String penStyleId;
  final List<Offset> points;

  Map<String, dynamic> toJson() {
    return {
      'penStyleId': penStyleId,
      'points': points.map((p) => [p.dx, p.dy]).toList(),
    };
  }

  factory HandwritingStroke.fromJson(Map<String, dynamic> json) {
    final rawPoints = json['points'] as List<dynamic>;
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

  void setErasing(bool erasing) {
    _erasing = erasing;
    notifyListeners();
  }

  void addStroke(HandwritingStroke stroke) {
    _strokes.add(stroke);
    _redoStack.clear();
    notifyListeners();
  }

  /// Removes the topmost stroke intersecting [point], used when
  /// [isErasing] is active. A stroke is considered hit if any of its
  /// points lies within [radius] of [point].
  void eraseAt(Offset point, {double radius = 12}) {
    for (var i = _strokes.length - 1; i >= 0; i--) {
      final hit = _strokes[i].points.any(
        (p) => (p - point).distance <= radius,
      );
      if (hit) {
        _strokes.removeAt(i);
        _redoStack.clear();
        notifyListeners();
        return;
      }
    }
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

  factory HandwritingCanvasController.fromJsonString(String raw) {
    if (raw.trim().isEmpty) return HandwritingCanvasController();
    final decoded = jsonDecode(raw) as List<dynamic>;
    final strokes = decoded
        .map((e) => HandwritingStroke.fromJson(e as Map<String, dynamic>))
        .toList();
    return HandwritingCanvasController(initialStrokes: strokes);
  }
}

/// Freehand ink canvas. Pointer events append points to an in-progress
/// stroke; on release the stroke is committed via [controller.addStroke].
class HandwritingCanvas extends StatefulWidget {
  const HandwritingCanvas({super.key, required this.controller});

  final HandwritingCanvasController controller;

  @override
  State<HandwritingCanvas> createState() => _HandwritingCanvasState();
}

class _HandwritingCanvasState extends State<HandwritingCanvas> {
  List<Offset> _currentPoints = [];

  void _onPanStart(DragStartDetails details) {
    if (widget.controller.isErasing) {
      widget.controller.eraseAt(details.localPosition);
      return;
    }
    setState(() => _currentPoints = [details.localPosition]);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (widget.controller.isErasing) {
      widget.controller.eraseAt(details.localPosition);
      return;
    }
    setState(() => _currentPoints = [..._currentPoints, details.localPosition]);
  }

  void _onPanEnd(DragEndDetails details) {
    if (widget.controller.isErasing || _currentPoints.isEmpty) {
      setState(() => _currentPoints = []);
      return;
    }
    widget.controller.addStroke(
      HandwritingStroke(
        penStyleId: widget.controller.activePen.id,
        points: _currentPoints,
      ),
    );
    setState(() => _currentPoints = []);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _HandwritingPainter(
              strokes: widget.controller.strokes,
              inProgress: _currentPoints,
              inProgressPen: widget.controller.activePen,
            ),
            size: Size.infinite,
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
    required this.inProgressPen,
  });

  final List<HandwritingStroke> strokes;
  final List<Offset> inProgress;
  final PenStyleModel inProgressPen;

  void _paintStroke(Canvas canvas, List<Offset> points, PenStyleModel pen) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = Color(pen.color)
      ..strokeWidth = pen.strokeWidth
      ..strokeCap = pen.isHighlighter ? StrokeCap.square : StrokeCap.round
      ..style = PaintingStyle.stroke
      ..blendMode = pen.isHighlighter ? BlendMode.multiply : BlendMode.srcOver;

    final path = ui.Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _paintStroke(canvas, stroke.points, PenStyleCatalog.byId(stroke.penStyleId));
    }
    _paintStroke(canvas, inProgress, inProgressPen);
  }

  @override
  bool shouldRepaint(covariant _HandwritingPainter oldDelegate) {
    return oldDelegate.strokes.length != strokes.length ||
        oldDelegate.inProgress != inProgress;
  }
}
