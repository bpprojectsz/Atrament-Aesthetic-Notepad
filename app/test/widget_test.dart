import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/main.dart';
import 'package:atrament/screens/home_screen.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('AtramentApp launches and renders the home screen', (
    tester,
  ) async {
    await tester.pumpWidget(const AtramentApp());

    // Let async provider init (theme/subscription/verse) settle. AdMob and
    // notification platform-channel calls inside main() are expected to
    // fail under the test harness — both degrade gracefully by design
    // (Sections 7 and 14), so this should never throw.
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HomeScreen renders standalone with injected providers', (
    tester,
  ) async {
    final notebookProvider = NotebookProvider();
    final noteProvider = NoteProvider();
    final subscriptionProvider = SubscriptionProvider();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(
          notebookProvider: notebookProvider,
          noteProvider: noteProvider,
          subscriptionProvider: subscriptionProvider,
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Search field and FAB should always be present, even before
    // notebooks finish loading.
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    notebookProvider.dispose();
    noteProvider.dispose();
    subscriptionProvider.dispose();
  });
}
