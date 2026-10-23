import 'package:atrament/core/models/notebook_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:atrament/screens/notebook_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';

final _l10n = lookupAppLocalizations(const Locale('en'));

final _notebook = NotebookModel(
  id: 'nb1',
  name: 'Journal',
  coverColor: 0xFF8B6914,
  paperStyleDefault: 'blank',
  sortOrder: 0,
  createdAt: DateTime(2026),
  modifiedAt: DateTime(2026),
);

Future<void> _pump(WidgetTester tester, [int ms = 600]) async {
  var elapsed = 0;
  while (elapsed < ms) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += 50;
  }
}

Future<ControlledStorage> _open(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  AppLock.instance = AppLock();

  final storage = ControlledStorage()
    ..notebookNotes['nb1'] = [
      testNote('a', 'Note A', notebookId: 'nb1'),
      testNote('b', 'Note B', notebookId: 'nb1'),
    ];
  final notes = NoteProvider(storage: storage);
  final notebooks = NotebookProvider(storage: storage);

  tester.view.physicalSize = const Size(900, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MultiProvider(
      providers: [
        Provider<VerseProvider>.value(value: VerseProvider()),
        Provider<SubscriptionProvider>.value(value: SubscriptionProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: NotebookDetailScreen(
          notebook: _notebook,
          notebookProvider: notebooks,
          noteProvider: notes,
        ),
      ),
    ),
  );
  await _pump(tester);
  return storage;
}

Future<void> _swipeAway(WidgetTester tester, String title) async {
  await tester.drag(find.text(title), const Offset(-700, 0));
  await _pump(tester);
}

void main() {
  tearDown(() => AppLock.instance = AppLock());

  group('swipe to delete a note', () {
    testWidgets('asks first, then removes the note', (tester) async {
      await _open(tester);

      await _swipeAway(tester, 'Note A');
      expect(find.text(_l10n.deleteNoteTitle), findsOneWidget,
          reason: 'must ask before deleting');
      await tester.tap(find.text(_l10n.delete));
      await _pump(tester);

      expect(find.text('Note A'), findsNothing);
      expect(find.text('Note B'), findsOneWidget);
    });

    testWidgets('cancelling keeps the note', (tester) async {
      await _open(tester);

      await _swipeAway(tester, 'Note A');
      await tester.tap(find.text(_l10n.cancel));
      await _pump(tester);

      expect(find.text('Note A'), findsOneWidget);
      expect(find.text('Note B'), findsOneWidget);
    });

    testWidgets('if the delete fails the note stays and the problem is shown', (
      tester,
    ) async {
      final storage = await _open(tester);
      storage.failDeletes = true;

      await _swipeAway(tester, 'Note A');
      await tester.tap(find.text(_l10n.delete));
      await _pump(tester);

      expect(find.text('Note A'), findsOneWidget,
          reason: 'no ghost row, and the note is not silently lost');
      expect(find.text(_l10n.storageIssueNoteDelete), findsOneWidget);
    });
  });

  group('new note in a notebook', () {
    testWidgets('uses the default paper chosen in Settings', (tester) async {
      await _open(tester, prefs: {AppConstants.prefPaperStyleDefault: 'lined'});

      await tester.tap(find.byType(FloatingActionButton));
      await _pump(tester, 1500);

      final editor = tester.widget<NoteEditorScreen>(find.byType(NoteEditorScreen));
      expect(editor.note.paperStyle, 'lined');
      expect(editor.note.notebookId, 'nb1');
    });

    testWidgets('falls back to cream when nothing was chosen', (tester) async {
      await _open(tester);

      await tester.tap(find.byType(FloatingActionButton));
      await _pump(tester, 1500);

      final editor = tester.widget<NoteEditorScreen>(find.byType(NoteEditorScreen));
      expect(editor.note.paperStyle, 'cream');
    });
  });
}
