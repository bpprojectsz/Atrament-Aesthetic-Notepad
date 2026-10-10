import 'dart:async';
import 'dart:convert';

import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records every save instead of touching SQLite, and lets a test hold the
/// first save open (via [gate]) or make saves fail (via [succeed]).
class _FakeNoteProvider extends NoteProvider {
  final List<NoteModel> saved = [];
  final List<bool> countedAsUserSave = [];
  bool succeed = true;
  Completer<bool>? gate;

  @override
  Future<bool> saveNote(
    NoteModel note, {
    required String plainTextContent,
    bool countsAsUserSave = true,
  }) async {
    saved.add(note);
    countedAsUserSave.add(countsAsUserSave);
    final held = gate;
    if (held != null && saved.length == 1) return held.future;
    return succeed;
  }
}

const String _typedContent = r'[{"insert":"Hello world\n"}]';

NoteModel _note({String content = _typedContent, String title = 'My note'}) {
  final now = DateTime(2026, 1, 15);
  return NoteModel(
    id: 'note_1',
    title: title,
    content: content,
    notebookId: 'nb_1',
    paperStyle: 'cream',
    createdAt: now,
    modifiedAt: now,
  );
}

Future<void> _pumpFor(WidgetTester tester, Duration total) async {
  const step = Duration(milliseconds: 50);
  var elapsed = Duration.zero;
  while (elapsed < total) {
    await tester.pump(step);
    elapsed += step;
  }
}

Future<NavigatorState> _openEditor(
  WidgetTester tester,
  NoteModel note,
  _FakeNoteProvider provider, {
  bool isNewNote = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              key: const Key('open'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => NoteEditorScreen(
                    note: note,
                    noteProvider: provider,
                    verseProvider: VerseProvider(),
                    isNewNote: isNewNote,
                  ),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.byKey(const Key('open')));
  await _pumpFor(tester, const Duration(milliseconds: 600));
  expect(find.byType(NoteEditorScreen), findsOneWidget);
  return tester.state<NavigatorState>(find.byType(Navigator).first);
}

Future<void> _pressBack(WidgetTester tester, NavigatorState nav) async {
  unawaited(nav.maybePop());
  // Android's page transition takes ~800ms; wait it out so a popped route
  // is really gone from the tree.
  await _pumpFor(tester, const Duration(milliseconds: 1200));
}

Future<void> _closeAll(WidgetTester tester) async {
  // Disposes the editor so no autosave timer outlives the test.
  await tester.pumpWidget(const SizedBox.shrink());
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('opening and closing an unchanged note writes nothing', (
    tester,
  ) async {
    final provider = _FakeNoteProvider();
    final nav = await _openEditor(tester, _note(), provider);

    await _pressBack(tester, nav);

    expect(provider.saved, isEmpty);
    expect(find.byType(NoteEditorScreen), findsNothing);
    await _closeAll(tester);
  });

  testWidgets(
    'toggling handwriting mode on a typed note never replaces the text',
    (tester) async {
      final provider = _FakeNoteProvider();
      final nav = await _openEditor(tester, _note(), provider);

      // Switch to handwriting (typed mode shows the "draw" icon) and leave
      // the canvas empty, as after an accidental tap.
      await tester.tap(find.byIcon(Icons.draw));
      await _pumpFor(tester, const Duration(milliseconds: 300));

      await _pressBack(tester, nav);

      // Nothing changed, so nothing is written — in particular, no empty
      // handwriting page over the typed text.
      expect(provider.saved, isEmpty);
      await _closeAll(tester);
    },
  );

  testWidgets(
    'a real edit made while in handwriting mode still saves the typed text',
    (tester) async {
      final provider = _FakeNoteProvider();
      final nav = await _openEditor(tester, _note(), provider);

      await tester.tap(find.byIcon(Icons.draw));
      await _pumpFor(tester, const Duration(milliseconds: 300));
      await tester.enterText(find.byType(TextField).first, 'Renamed');
      await _pressBack(tester, nav);

      expect(provider.saved, hasLength(1));
      final saved = provider.saved.single;
      expect(saved.title, 'Renamed');
      final decoded = jsonDecode(saved.content);
      expect(decoded, isA<List<dynamic>>(), reason: 'must stay typed content');
      expect(saved.content, contains('Hello world'));
      await _closeAll(tester);
    },
  );

  testWidgets('autosave fires 2s after the last change and is not a user save', (
    tester,
  ) async {
    final provider = _FakeNoteProvider();
    await _openEditor(tester, _note(), provider);

    await tester.enterText(find.byType(TextField).first, 'Edited title');
    await _pumpFor(tester, const Duration(milliseconds: 1500));
    expect(provider.saved, isEmpty, reason: 'not yet — still inside the delay');

    await _pumpFor(tester, const Duration(milliseconds: 800));
    expect(provider.saved, hasLength(1));
    expect(provider.saved.single.title, 'Edited title');
    expect(provider.countedAsUserSave.single, isFalse,
        reason: 'autosave must not advance ad/review counters');
    await _closeAll(tester);
  });

  testWidgets('the final save on exit counts as a user save', (tester) async {
    final provider = _FakeNoteProvider();
    final nav = await _openEditor(tester, _note(), provider);

    await tester.enterText(find.byType(TextField).first, 'Edited');
    await _pressBack(tester, nav);

    expect(provider.saved, hasLength(1));
    expect(provider.countedAsUserSave.single, isTrue);
    await _closeAll(tester);
  });

  testWidgets('a failed save keeps the editor open once, then lets the user leave', (
    tester,
  ) async {
    final provider = _FakeNoteProvider()..succeed = false;
    final nav = await _openEditor(tester, _note(), provider);

    await tester.enterText(find.byType(TextField).first, 'Unsaved edit');
    await _pressBack(tester, nav);

    expect(find.byType(NoteEditorScreen), findsOneWidget,
        reason: 'first failure must not silently discard the note');
    expect(find.text("Couldn't save. Please try again."), findsOneWidget);

    await _pressBack(tester, nav);
    expect(find.byType(NoteEditorScreen), findsNothing,
        reason: 'second back press must never trap the user');
    expect(provider.saved.length, greaterThanOrEqualTo(2),
        reason: 'the second press retried the save');
    await _closeAll(tester);
  });

  testWidgets('a retry after a failed save succeeds and leaves normally', (
    tester,
  ) async {
    final provider = _FakeNoteProvider()..succeed = false;
    final nav = await _openEditor(tester, _note(), provider);

    await tester.enterText(find.byType(TextField).first, 'Will retry');
    await _pressBack(tester, nav);
    expect(find.byType(NoteEditorScreen), findsOneWidget);

    provider.succeed = true;
    await _pressBack(tester, nav);

    expect(find.byType(NoteEditorScreen), findsNothing);
    await _closeAll(tester);
  });

  testWidgets('overlapping saves are serialized and the later one is fresh', (
    tester,
  ) async {
    final provider = _FakeNoteProvider()..gate = Completer<bool>();
    final nav = await _openEditor(tester, _note(), provider);

    await tester.enterText(find.byType(TextField).first, 'First');
    await _pumpFor(tester, const Duration(milliseconds: 2200));
    expect(provider.saved, hasLength(1), reason: 'autosave started and is held');

    // User keeps typing and leaves while that save is still in flight.
    await tester.enterText(find.byType(TextField).first, 'Second');
    unawaited(nav.maybePop());
    await _pumpFor(tester, const Duration(milliseconds: 300));
    expect(provider.saved, hasLength(1),
        reason: 'the exit save must wait for the one in flight');
    expect(find.byType(NoteEditorScreen), findsOneWidget);

    provider.gate!.complete(true);
    await _pumpFor(tester, const Duration(milliseconds: 1500));

    expect(provider.saved, hasLength(2));
    expect(provider.saved.last.title, 'Second',
        reason: 'must write the latest text, not be skipped');
    expect(find.byType(NoteEditorScreen), findsNothing);
    await _closeAll(tester);
  });

  testWidgets('an untouched new note is never written', (tester) async {
    final provider = _FakeNoteProvider();
    final nav = await _openEditor(
      tester,
      _note(content: r'[{"insert":"\n"}]', title: ''),
      provider,
      isNewNote: true,
    );

    await _pressBack(tester, nav);

    expect(provider.saved, isEmpty);
    await _closeAll(tester);
  });

  testWidgets('a new note emptied after its first autosave is saved empty', (
    tester,
  ) async {
    final provider = _FakeNoteProvider();
    await _openEditor(
      tester,
      _note(content: r'[{"insert":"\n"}]', title: ''),
      provider,
      isNewNote: true,
    );

    await tester.enterText(find.byType(TextField).first, 'Draft');
    await _pumpFor(tester, const Duration(milliseconds: 2200));
    expect(provider.saved.single.title, 'Draft');

    await tester.enterText(find.byType(TextField).first, '');
    await _pumpFor(tester, const Duration(milliseconds: 2200));

    expect(provider.saved, hasLength(2),
        reason: 'the earlier autosave must not linger on disk');
    expect(provider.saved.last.title, '');
    await _closeAll(tester);
  });

  testWidgets('corrupted handwriting content opens without crashing and is kept', (
    tester,
  ) async {
    final provider = _FakeNoteProvider();
    final nav = await _openEditor(
      tester,
      _note(content: '{"type":"handwriting","strokes":"not-a-list"}'),
      provider,
    );

    expect(tester.takeException(), isNull);
    await _pressBack(tester, nav);

    expect(provider.saved, isEmpty,
        reason: 'original content stays on disk until the user edits');
    await _closeAll(tester);
  });

  testWidgets('unparsable typed content opens blank and is not overwritten', (
    tester,
  ) async {
    final provider = _FakeNoteProvider();
    final nav = await _openEditor(
      tester,
      _note(content: 'this is not json'),
      provider,
    );

    expect(tester.takeException(), isNull);
    await _pressBack(tester, nav);

    expect(provider.saved, isEmpty);
    await _closeAll(tester);
  });
}
