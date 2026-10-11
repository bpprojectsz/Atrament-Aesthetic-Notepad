import 'dart:async';

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
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:atrament/widgets/lock_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';
import 'helpers/fake_biometrics.dart';

class _NoopNoteProvider extends NoteProvider {
  @override
  Future<bool> saveNote(
    NoteModel note, {
    required String plainTextContent,
    bool countsAsUserSave = true,
  }) async => true;
}

Future<void> _pumpFor(WidgetTester tester, Duration total) async {
  const step = Duration(milliseconds: 50);
  var elapsed = Duration.zero;
  while (elapsed < total) {
    await tester.pump(step);
    elapsed += step;
  }
}

Future<FakeBiometrics> _installLock({
  required bool enabled,
  BiometricAuthResult fallback = BiometricAuthResult.success,
}) async {
  SharedPreferences.setMockInitialValues({
    AppConstants.prefBiometricLockEnabled: enabled,
  });
  final bio = FakeBiometrics()..fallback = fallback;
  AppLock.instance = AppLock(biometrics: bio);
  await AppLock.instance.init(observeLifecycle: false);
  return bio;
}

NoteModel _note() {
  final now = DateTime(2026, 1, 15);
  return NoteModel(
    id: 'note_1',
    title: 'Visible title',
    content: r'[{"insert":"Visible title\nsecret second line\n"}]',
    notebookId: null,
    paperStyle: 'cream',
    createdAt: now,
    modifiedAt: now,
  );
}

Future<void> _openEditor(WidgetTester tester) async {
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
                    note: _note(),
                    noteProvider: _NoopNoteProvider(),
                    verseProvider: VerseProvider(),
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
  await _pumpFor(tester, const Duration(milliseconds: 1200));
}

void main() {
  tearDown(() => AppLock.instance = AppLock());

  group('editor', () {
    testWidgets('shows the lock screen when authentication is refused', (
      tester,
    ) async {
      await _installLock(enabled: true, fallback: BiometricAuthResult.failed);

      await _openEditor(tester);

      expect(find.text('This note is locked'), findsOneWidget);
      expect(find.byType(TextField), findsNothing,
          reason: 'the note must not be editable or visible');
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('opens the note after a successful authentication', (
      tester,
    ) async {
      final bio = await _installLock(enabled: true);

      await _openEditor(tester);

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('This note is locked'), findsNothing);
      expect(bio.prompts, 1);
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('does not ask again for a second note in the same session', (
      tester,
    ) async {
      final bio = await _installLock(enabled: true);

      await _openEditor(tester);
      expect(bio.prompts, 1);
      await tester.pumpWidget(const SizedBox.shrink());

      await _openEditor(tester);
      expect(find.byType(TextField), findsOneWidget);
      expect(bio.prompts, 1, reason: 'the session is already unlocked');
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets(
      'opens the note and switches the lock off when the device can no '
      'longer authenticate',
      (tester) async {
        await _installLock(
          enabled: true,
          fallback: BiometricAuthResult.unavailable,
        );

        await _openEditor(tester);

        expect(find.byType(TextField), findsOneWidget,
            reason: 'the user must never be locked out of their notes');
        expect(
          find.text(
            'Note lock was turned off because this device has no screen '
            'lock or biometrics set up.',
          ),
          findsOneWidget,
        );
        expect(AppLock.instance.enabled, isFalse);
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  });

  group('requireUnlock (share / export gate)', () {
    Future<bool?> runGate(WidgetTester tester) async {
      bool? allowed;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  allowed = await requireUnlock(context, reason: 'reason');
                },
                child: const Text('go'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await _pumpFor(tester, const Duration(milliseconds: 600));
      return allowed;
    }

    testWidgets('lets the action through when the lock is off', (
      tester,
    ) async {
      final bio = await _installLock(enabled: false);

      expect(await runGate(tester), isTrue);
      expect(bio.prompts, 0);
    });

    testWidgets('lets the action through after authenticating', (
      tester,
    ) async {
      final bio = await _installLock(enabled: true);

      expect(await runGate(tester), isTrue);
      expect(bio.prompts, 1);
    });

    testWidgets('blocks the action and explains when authentication fails', (
      tester,
    ) async {
      await _installLock(enabled: true, fallback: BiometricAuthResult.failed);

      expect(await runGate(tester), isFalse);
      expect(find.text('Unable to verify your identity.'), findsOneWidget);
    });

    testWidgets('allows the action but says so if the lock had to turn off', (
      tester,
    ) async {
      await _installLock(
        enabled: true,
        fallback: BiometricAuthResult.unavailable,
      );

      expect(await runGate(tester), isTrue);
      expect(find.textContaining('Note lock was turned off'), findsOneWidget);
    });
  });

  group('home previews', () {
    testWidgets('are hidden while locked and shown once unlocked', (
      tester,
    ) async {
      await _installLock(enabled: true);
      final storage = ControlledStorage()..allNotes = [_note()];
      final noteProvider = NoteProvider(storage: storage);
      final notebookProvider = NotebookProvider(storage: storage);
      final subscriptionProvider = SubscriptionProvider();

      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [appRouteObserver],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(
            notebookProvider: notebookProvider,
            noteProvider: noteProvider,
            subscriptionProvider: subscriptionProvider,
          ),
        ),
      );
      await _pumpFor(tester, const Duration(milliseconds: 600));

      expect(find.text('Visible title'), findsOneWidget,
          reason: 'titles stay visible');
      expect(find.textContaining('secret second line'), findsNothing,
          reason: 'the private body must be hidden while locked');

      AppLock.instance.markUnlocked();
      await _pumpFor(tester, const Duration(milliseconds: 300));

      expect(find.textContaining('secret second line'), findsOneWidget);

      AppLock.instance.lock();
      await _pumpFor(tester, const Duration(milliseconds: 300));
      expect(find.textContaining('secret second line'), findsNothing);

      await tester.pumpWidget(const SizedBox.shrink());
      notebookProvider.dispose();
      noteProvider.dispose();
      subscriptionProvider.dispose();
    });
  });
}
