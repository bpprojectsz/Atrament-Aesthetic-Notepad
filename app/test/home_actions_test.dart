import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/core/utils/route_observer.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/platform/biometric_service.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:atrament/widgets/note_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';
import 'helpers/fake_biometrics.dart';

final _l10n = lookupAppLocalizations(const Locale('en'));

Future<void> _pump(WidgetTester tester, [int ms = 600]) async {
  var elapsed = 0;
  while (elapsed < ms) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += 50;
  }
}

NoteModel _typed(String id, String title) => testNote(id, title);

NoteModel _ink(String id, String title) => NoteModel(
  id: id,
  title: title,
  content: '{"type":"handwriting","strokes":[]}',
  paperStyle: 'cream',
  createdAt: DateTime(2026, 1, 1),
  modifiedAt: DateTime(2026, 1, 1),
);

class _Home {
  _Home(this.storage, this.notes, this.notebooks);
  final ControlledStorage storage;
  final NoteProvider notes;
  final NotebookProvider notebooks;
}

Future<_Home> _open(
  WidgetTester tester,
  List<NoteModel> notes, {
  Map<String, Object> prefs = const {},
  FakeBiometrics? bio,
  bool lockEnabled = false,
}) async {
  SharedPreferences.setMockInitialValues({
    AppConstants.prefBiometricLockEnabled: lockEnabled,
    ...prefs,
  });
  AppLock.instance = AppLock(biometrics: bio ?? FakeBiometrics());

  final storage = ControlledStorage()..allNotes = notes;
  final noteProvider = NoteProvider(storage: storage);
  final notebookProvider = NotebookProvider(storage: storage);
  final subscription = SubscriptionProvider();

  tester.view.physicalSize = const Size(900, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MultiProvider(
      providers: [
        Provider<VerseProvider>.value(value: VerseProvider()),
        Provider<SubscriptionProvider>.value(value: subscription),
      ],
      child: MaterialApp(
        navigatorObservers: [appRouteObserver],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(
          notebookProvider: notebookProvider,
          noteProvider: noteProvider,
          subscriptionProvider: subscription,
        ),
      ),
    ),
  );
  await _pump(tester);
  return _Home(storage, noteProvider, notebookProvider);
}

/// Taps the "more" button on the row of the note called [title].
Future<void> _openActions(WidgetTester tester, String title) async {
  final row = find.ancestor(
    of: find.text(title),
    matching: find.byType(NoteListItem),
  );
  await tester.tap(
    find.descendant(of: row, matching: find.byIcon(Icons.more_vert)),
  );
  await _pump(tester);
}

void main() {
  tearDown(() => AppLock.instance = AppLock());

  group('note actions on Home', () {
    testWidgets('Rename changes the title and saves it', (tester) async {
      final home = await _open(tester, [_typed('a', 'Old title')]);

      await _openActions(tester, 'Old title');
      await tester.tap(find.text(_l10n.noteActionRename));
      await _pump(tester);
      await tester.enterText(find.byType(TextField).last, 'New title');
      await tester.tap(find.text(_l10n.save));
      await _pump(tester);

      expect(find.text('New title'), findsOneWidget);
      expect(find.text('Old title'), findsNothing);
      expect(home.storage.savedNotes.last.title, 'New title');
    });

    testWidgets('Cancelling a rename changes nothing', (tester) async {
      final home = await _open(tester, [_typed('a', 'Keep me')]);

      await _openActions(tester, 'Keep me');
      await tester.tap(find.text(_l10n.noteActionRename));
      await _pump(tester);
      await tester.enterText(find.byType(TextField).last, 'Discarded');
      await tester.tap(find.text(_l10n.cancel));
      await _pump(tester);

      expect(find.text('Keep me'), findsOneWidget);
      expect(home.storage.savedNotes, isEmpty);
    });
  });

  group('export from Home', () {
    testWidgets('a typed note can be exported as text or PDF', (tester) async {
      await _open(tester, [_typed('a', 'Typed note')]);

      await _openActions(tester, 'Typed note');
      await tester.tap(find.text(_l10n.noteActionExport));
      await _pump(tester);

      expect(find.text(_l10n.exportAsTxt), findsOneWidget);
      expect(find.text(_l10n.exportAsPdf), findsOneWidget);
    });

    testWidgets('a drawing is offered as PDF only (it has no text)', (tester) async {
      await _open(tester, [_ink('a', 'My drawing')]);

      await _openActions(tester, 'My drawing');
      await tester.tap(find.text(_l10n.noteActionExport));
      await _pump(tester);

      expect(find.text(_l10n.exportAsPdf), findsOneWidget);
      expect(find.text(_l10n.exportAsTxt), findsNothing);
    });

    testWidgets('with the lock on, a refused authentication blocks the export', (
      tester,
    ) async {
      await _open(
        tester,
        [_typed('a', 'Private note')],
        lockEnabled: true,
        bio: FakeBiometrics()..fallback = BiometricAuthResult.failed,
      );

      await _openActions(tester, 'Private note');
      await tester.tap(find.text(_l10n.noteActionExport));
      await _pump(tester);

      expect(find.text(_l10n.biometricAuthFailedMessage), findsOneWidget);
      expect(find.text(_l10n.exportAsPdf), findsNothing,
          reason: 'the export options must not appear');
    });

    testWidgets('with the lock on, authenticating lets the export continue', (
      tester,
    ) async {
      final bio = FakeBiometrics();
      await _open(
        tester,
        [_typed('a', 'Private note')],
        lockEnabled: true,
        bio: bio,
      );

      await _openActions(tester, 'Private note');
      await tester.tap(find.text(_l10n.noteActionExport));
      await _pump(tester);

      expect(bio.prompts, 1);
      expect(find.text(_l10n.exportAsPdf), findsOneWidget);
    });

    testWidgets('with the lock on, a refused authentication blocks sharing too', (
      tester,
    ) async {
      await _open(
        tester,
        [_typed('a', 'Private note')],
        lockEnabled: true,
        bio: FakeBiometrics()..fallback = BiometricAuthResult.failed,
      );

      await _openActions(tester, 'Private note');
      await tester.tap(find.text(_l10n.noteActionShare));
      await _pump(tester);

      expect(find.text(_l10n.biometricAuthFailedMessage), findsOneWidget);
    });
  });

  group('new notebook on Home', () {
    testWidgets('inherits the default paper chosen in Settings', (tester) async {
      final home = await _open(
        tester,
        const [],
        prefs: {AppConstants.prefPaperStyleDefault: 'lined'},
      );

      await tester.tap(find.byTooltip(_l10n.newNotebookTitle));
      await _pump(tester);
      await tester.enterText(find.byType(TextField).last, 'Work');
      await tester.tap(find.text(_l10n.save));
      await _pump(tester);

      final created = home.notebooks.notebooks.value.single;
      expect(created.name, 'Work');
      expect(created.paperStyleDefault, 'lined');
    });

    testWidgets('an empty name creates nothing', (tester) async {
      final home = await _open(tester, const []);

      await tester.tap(find.byTooltip(_l10n.newNotebookTitle));
      await _pump(tester);
      await tester.tap(find.text(_l10n.save));
      await _pump(tester);

      expect(home.notebooks.notebooks.value, isEmpty);
    });
  });
}
