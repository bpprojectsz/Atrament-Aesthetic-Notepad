import 'dart:convert';

import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:atrament/widgets/handwriting_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

HandwritingStroke _stroke(
  List<Offset> points, {
  double width = 4,
  bool highlighter = false,
}) => HandwritingStroke(
  penStyleId: 'fountain_pen',
  points: points,
  color: 0xFF000000,
  strokeWidth: width,
  isHighlighter: highlighter,
);

Future<void> _pumpCanvas(
  WidgetTester tester,
  HandwritingCanvasController controller, {
  double width = 400,
  double height = 600,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: width,
          height: height,
          child: HandwritingCanvas(controller: controller),
        ),
      ),
    ),
  );
}

Offset _origin(WidgetTester tester) =>
    tester.getTopLeft(find.byType(HandwritingCanvas));

void main() {
  group('controller: erasing', () {
    test('hits a stroke between two far-apart sample points', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(0, 0), Offset(200, 0)]));

      c.eraseAt(const Offset(100, 5)); // midway along the segment

      expect(c.strokes, isEmpty,
          reason: 'a fast stroke has few points; the line between them counts');
    });

    test('misses a stroke that is clearly away from the touch', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(0, 0), Offset(200, 0)]));

      c.eraseAt(const Offset(100, 60));

      expect(c.strokes, hasLength(1));
    });

    test('a single-point dot can be erased', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(50, 50)]));

      c.eraseAt(const Offset(54, 50));
      expect(c.strokes, isEmpty);
    });

    test('a tap removes only the topmost of overlapping strokes', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(0, 0), Offset(100, 0)]))
        ..addStroke(_stroke(const [Offset(0, 2), Offset(100, 2)]));

      c.eraseAt(const Offset(50, 1));

      expect(c.strokes, hasLength(1));
      expect(c.strokes.single.points.first, const Offset(0, 0));
    });

    test('a swipe erases strokes it passes over, even between touch events', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(100, 0), Offset(100, 200)]))
        ..addStroke(_stroke(const [Offset(100, 400), Offset(100, 600)]));

      // Two samples far apart, as from a fast swipe.
      c.eraseAlong(const Offset(0, 100), const Offset(200, 100));

      expect(c.strokes, hasLength(1));
      expect(c.strokes.single.points.first, const Offset(100, 400));
    });

    test('erasing clears the redo history', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(0, 0), Offset(10, 0)]))
        ..undo();
      expect(c.canRedo, isTrue);
      c.addStroke(_stroke(const [Offset(0, 0), Offset(100, 0)]));
      c.eraseAt(const Offset(50, 0));
      expect(c.canRedo, isFalse);
    });
  });

  group('controller: fitting saved ink to the screen', () {
    test('the first layout only records the width', () {
      final c = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(10, 10), Offset(20, 20)]));

      expect(c.adaptToWidth(400), isFalse);

      expect(c.canvasWidth, 400);
      expect(c.strokes.single.points, const [Offset(10, 10), Offset(20, 20)]);
    });

    test('a different width scales the ink in proportion and keeps pen width', () {
      final c = HandwritingCanvasController()
        ..canvasWidth = 200
        ..addStroke(_stroke(const [Offset(10, 20), Offset(30, 40)], width: 6));

      expect(c.adaptToWidth(400), isTrue);

      expect(c.canvasWidth, 400);
      expect(c.strokes.single.points, const [Offset(20, 40), Offset(60, 80)]);
      expect(c.strokes.single.strokeWidth, 6);
    });

    test('scales back when the width returns (rotate and rotate back)', () {
      final c = HandwritingCanvasController()
        ..canvasWidth = 400
        ..addStroke(_stroke(const [Offset(100, 100), Offset(200, 200)]));

      c.adaptToWidth(800);
      c.adaptToWidth(400);

      expect(c.strokes.single.points,
          const [Offset(100, 100), Offset(200, 200)]);
    });

    test('is silent: opening a note on another screen is not an edit', () {
      var notified = 0;
      final c = HandwritingCanvasController()
        ..canvasWidth = 200
        ..addStroke(_stroke(const [Offset(10, 10), Offset(20, 20)]));
      c.addListener(() => notified++);

      c.adaptToWidth(400);

      expect(notified, 0);
    });

    test('ignores sub-pixel differences and bad widths', () {
      final c = HandwritingCanvasController()
        ..canvasWidth = 400
        ..addStroke(_stroke(const [Offset(10, 10), Offset(20, 20)]));

      expect(c.adaptToWidth(400.4), isFalse);
      expect(c.adaptToWidth(0), isFalse);
      expect(c.adaptToWidth(double.infinity), isFalse);
      expect(c.adaptToWidth(double.nan), isFalse);

      expect(c.canvasWidth, 400);
      expect(c.strokes.single.points, const [Offset(10, 10), Offset(20, 20)]);
    });

    test('strokes waiting in redo are scaled too', () {
      final c = HandwritingCanvasController()
        ..canvasWidth = 200
        ..addStroke(_stroke(const [Offset(10, 10), Offset(20, 20)]))
        ..undo();

      c.adaptToWidth(400);
      c.redo();

      expect(c.strokes.single.points, const [Offset(20, 20), Offset(40, 40)]);
    });
  });

  group('saved content format', () {
    test('round-trips strokes and the canvas width', () {
      final original = HandwritingCanvasController()
        ..canvasWidth = 411.5
        ..addStroke(_stroke(const [Offset(1, 2), Offset(3, 4)], width: 5));

      final restored = HandwritingCanvasController.fromWrappedContent(
        original.toWrappedContent(),
      );

      expect(restored.canvasWidth, 411.5);
      expect(restored.strokes.single.points, const [Offset(1, 2), Offset(3, 4)]);
      expect(restored.strokes.single.strokeWidth, 5);
    });

    test('notes saved before the width was recorded still load', () {
      const old =
          '{"type":"handwriting","strokes":[{"penStyleId":"fountain_pen","points":[[1,2],[3,4]]}]}';

      final restored = HandwritingCanvasController.fromWrappedContent(old);

      expect(restored.canvasWidth, isNull);
      expect(restored.strokes, hasLength(1));
    });

    test('the width is left out until it is known', () {
      final decoded =
          jsonDecode(HandwritingCanvasController().toWrappedContent())
              as Map<String, dynamic>;

      expect(decoded['type'], 'handwriting');
      expect(decoded.containsKey('canvasWidth'), isFalse);
      expect(decoded['strokes'], isEmpty);
    });

    test('malformed content throws, so the editor can fall back safely', () {
      expect(
        () => HandwritingCanvasController.fromWrappedContent(
          '{"type":"handwriting","strokes":"not-a-list"}',
        ),
        throwsA(anything),
      );
    });
  });

  group('canvas: touch handling', () {
    testWidgets('a stroke starts exactly where the finger lands', (tester) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);
      final down = _origin(tester) + const Offset(50, 50);

      final gesture = await tester.startGesture(down);
      for (var i = 0; i < 5; i++) {
        await gesture.moveBy(const Offset(3, 0));
      }
      await gesture.up();

      expect(controller.strokes, hasLength(1));
      expect(controller.strokes.single.points.first, const Offset(50, 50),
          reason: 'no part of the start may be lost to touch slop');
      expect(controller.strokes.single.points.last, const Offset(65, 50));
    });

    testWidgets('a short mark is kept', (tester) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);

      final gesture = await tester.startGesture(
        _origin(tester) + const Offset(100, 100),
      );
      await gesture.moveBy(const Offset(4, 3));
      await gesture.up();

      expect(controller.strokes, hasLength(1));
      expect(controller.strokes.single.points.length, 2);
    });

    testWidgets('a tap draws a dot', (tester) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);

      await tester.tapAt(_origin(tester) + const Offset(80, 80));
      await tester.pump();

      expect(controller.strokes, hasLength(1));
      expect(controller.strokes.single.points, const [Offset(80, 80)]);
      expect(
        tester.renderObject(
          find.descendant(
            of: find.byType(HandwritingCanvas),
            matching: find.byType(CustomPaint),
          ),
        ),
        paints..circle(
          x: 80,
          y: 80,
          radius: controller.strokes.single.strokeWidth / 2,
        ),
      );
    });

    testWidgets('only the first finger draws; a second touch is ignored', (
      tester,
    ) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);
      final origin = _origin(tester);

      final first = await tester.startGesture(origin + const Offset(50, 50));
      final palm = await tester.startGesture(
        origin + const Offset(300, 300),
        pointer: 7,
      );
      await palm.moveBy(const Offset(20, 20));
      await first.moveBy(const Offset(10, 0));
      await palm.up();
      await first.up();

      expect(controller.strokes, hasLength(1));
      expect(controller.strokes.single.points,
          const [Offset(50, 50), Offset(60, 50)]);
    });

    testWidgets('a touch cancelled by the system leaves no stray stroke', (
      tester,
    ) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);

      final gesture = await tester.startGesture(
        _origin(tester) + const Offset(50, 50),
      );
      await gesture.moveBy(const Offset(10, 0));
      await gesture.cancel();

      expect(controller.strokes, isEmpty);
    });

    testWidgets('drawing again after a cancel works', (tester) async {
      final controller = HandwritingCanvasController();
      await _pumpCanvas(tester, controller);
      final origin = _origin(tester);

      final cancelled = await tester.startGesture(origin + const Offset(10, 10));
      await cancelled.cancel();
      final good = await tester.startGesture(origin + const Offset(60, 60));
      await good.moveBy(const Offset(10, 0));
      await good.up();

      expect(controller.strokes, hasLength(1));
    });

    testWidgets('swiping with the eraser removes the stroke it crosses', (
      tester,
    ) async {
      final controller = HandwritingCanvasController()
        ..addStroke(_stroke(const [Offset(100, 0), Offset(100, 300)]))
        ..setErasing(true);
      await _pumpCanvas(tester, controller);
      final origin = _origin(tester);

      final gesture = await tester.startGesture(origin + const Offset(20, 150));
      await gesture.moveTo(origin + const Offset(180, 150)); // one big jump
      await gesture.up();

      expect(controller.strokes, isEmpty);
    });
  });

  group('canvas: fitting to the screen', () {
    testWidgets('saved ink is scaled when the canvas is a different width', (
      tester,
    ) async {
      final controller = HandwritingCanvasController()
        ..canvasWidth = 200
        ..addStroke(_stroke(const [Offset(100, 100), Offset(150, 150)]));

      await _pumpCanvas(tester, controller, width: 400);

      expect(controller.canvasWidth, 400);
      expect(controller.strokes.single.points,
          const [Offset(200, 200), Offset(300, 300)]);

      await _pumpCanvas(tester, controller, width: 200);

      expect(controller.canvasWidth, 200);
      expect(controller.strokes.single.points,
          const [Offset(100, 100), Offset(150, 150)]);
    });

    testWidgets('a new note records the width of the first canvas', (tester) async {
      final controller = HandwritingCanvasController();

      await _pumpCanvas(tester, controller, width: 360);

      expect(controller.canvasWidth, 360);
    });
  });

  group('editor: ink is saved with its canvas width', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      AppLock.instance = AppLock();
    });

    testWidgets(
      'opening on a different width rescales silently; leaving saves the new '
      'width and the scaled ink',
      (tester) async {
        final saved = <NoteModel>[];
        final now = DateTime(2026, 1, 1);
        final stored = jsonEncode({
          'type': 'handwriting',
          'canvasWidth': 400.0,
          'strokes': [
            _stroke(const [Offset(100, 100), Offset(150, 150)]).toJson(),
          ],
        });
        final note = NoteModel(
          id: 'n',
          title: 'Ink',
          content: stored,
          paperStyle: 'cream',
          createdAt: now,
          modifiedAt: now,
        );

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => NoteEditorScreen(
                        note: note,
                        noteProvider: _CapturingProvider(saved),
                        verseProvider: VerseProvider(),
                      ),
                    ),
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('open'));
        for (var i = 0; i < 25; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
        final width = tester.getSize(find.byType(HandwritingCanvas)).width;
        expect(width, isNot(400), reason: 'the test screen is not 400px wide');

        // Rescaling on open is not an edit: autosave must not fire.
        for (var i = 0; i < 60; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
        expect(saved, isEmpty);

        final navigator = tester.state<NavigatorState>(
          find.byType(Navigator).first,
        );
        await navigator.maybePop();
        for (var i = 0; i < 40; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(saved, hasLength(1));
        final wrapper = jsonDecode(saved.single.content) as Map<String, dynamic>;
        expect((wrapper['canvasWidth'] as num).toDouble(), width);
        final factor = width / 400;
        final points =
            ((wrapper['strokes'] as List).single as Map)['points'] as List;
        expect((points.first[0] as num).toDouble(), closeTo(100 * factor, 0.001));
        expect((points.first[1] as num).toDouble(), closeTo(100 * factor, 0.001));
        expect((points.last[0] as num).toDouble(), closeTo(150 * factor, 0.001));
      },
    );
  });
}

class _CapturingProvider extends NoteProvider {
  _CapturingProvider(this.saved);
  final List<NoteModel> saved;

  @override
  Future<bool> saveNote(
    NoteModel note, {
    required String plainTextContent,
    bool countsAsUserSave = true,
  }) async {
    saved.add(note);
    return true;
  }
}
