import 'dart:async';

import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:atrament/core/utils/route_observer.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';

Future<void> _pumpFor(WidgetTester tester, Duration total) async {
  const step = Duration(milliseconds: 50);
  var elapsed = Duration.zero;
  while (elapsed < total) {
    await tester.pump(step);
    elapsed += step;
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets(
    'Home: clearing the search restores all notes, and returning from another '
    'screen keeps the typed search and its results in agreement',
    (tester) async {
      final storage = ControlledStorage()
        ..allNotes = [testNote('a', 'Alpha note'), testNote('b', 'Beta note')];
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

      expect(find.text('Alpha note'), findsOneWidget);
      expect(find.text('Beta note'), findsOneWidget);

      // Type a search; after the debounce only the matching note is shown.
      await tester.enterText(find.byType(TextField), 'alpha');
      await _pumpFor(tester, const Duration(milliseconds: 400));
      expect(storage.searchCalls, ['alpha']);
      storage.searchCompleters.last.complete(
        StorageResult.success([testNote('a', 'Alpha note')]),
      );
      await _pumpFor(tester, const Duration(milliseconds: 200));
      expect(find.text('Alpha note'), findsOneWidget);
      expect(find.text('Beta note'), findsNothing);

      // Open another screen and come back: the box still says "alpha", so
      // the search is re-run instead of silently showing every note.
      final navigator = tester.state<NavigatorState>(
        find.byType(Navigator).first,
      );
      unawaited(
        navigator.push(
          MaterialPageRoute<void>(
            builder: (_) => const Scaffold(body: Text('other screen')),
          ),
        ),
      );
      await _pumpFor(tester, const Duration(milliseconds: 1000));
      navigator.pop();
      await _pumpFor(tester, const Duration(milliseconds: 1000));

      expect(storage.searchCalls, ['alpha', 'alpha'],
          reason: 'the typed search was re-run on return');
      storage.searchCompleters.last.complete(
        StorageResult.success([testNote('a', 'Alpha note')]),
      );
      await _pumpFor(tester, const Duration(milliseconds: 200));
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'alpha',
      );
      expect(find.text('Alpha note'), findsOneWidget);
      expect(find.text('Beta note'), findsNothing);

      // Clearing the box must bring every note back.
      await tester.enterText(find.byType(TextField), '');
      await _pumpFor(tester, const Duration(milliseconds: 600));
      expect(find.text('Alpha note'), findsOneWidget);
      expect(find.text('Beta note'), findsOneWidget,
          reason: 'cleared search must not leave stale filtered results');

      await tester.pumpWidget(const SizedBox.shrink());
      notebookProvider.dispose();
      noteProvider.dispose();
      subscriptionProvider.dispose();
    },
  );
}
