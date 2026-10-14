import 'dart:async';

import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/utils/route_observer.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:atrament/screens/notebook_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';

Future<void> _pumpFor(WidgetTester tester, Duration total) async {
  var elapsed = Duration.zero;
  while (elapsed < total) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += const Duration(milliseconds: 50);
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets(
    'tapping a note that belongs to a notebook opens the editor directly, '
    'and Back returns to Home',
    (tester) async {
      final storage = ControlledStorage()
        ..allNotes = [testNote('n1', 'Inside a notebook', notebookId: 'nb1')];
      final noteProvider = NoteProvider(storage: storage);
      final notebookProvider = NotebookProvider(storage: storage);
      final subscriptionProvider = SubscriptionProvider();
      final verseProvider = VerseProvider();

      await tester.pumpWidget(
        Provider<VerseProvider>.value(
          value: verseProvider,
          child: MaterialApp(
            navigatorObservers: [appRouteObserver],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeScreen(
              notebookProvider: notebookProvider,
              noteProvider: noteProvider,
              subscriptionProvider: subscriptionProvider,
            ),
          ),
        ),
      );
      await _pumpFor(tester, const Duration(milliseconds: 600));

      await tester.tap(find.text('Inside a notebook'));
      await _pumpFor(tester, const Duration(milliseconds: 1500));

      expect(find.byType(NoteEditorScreen), findsOneWidget);
      expect(find.byType(NotebookDetailScreen), findsNothing,
          reason: 'no detour through the notebook screen');

      final navigator = tester.state<NavigatorState>(
        find.byType(Navigator).first,
      );
      unawaited(navigator.maybePop());
      await _pumpFor(tester, const Duration(milliseconds: 1500));

      expect(find.byType(NoteEditorScreen), findsNothing);
      expect(find.byType(NotebookDetailScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget,
          reason: 'Back must land on Home');

      await tester.pumpWidget(const SizedBox.shrink());
      notebookProvider.dispose();
      noteProvider.dispose();
      subscriptionProvider.dispose();
      verseProvider.dispose();
    },
  );
}
