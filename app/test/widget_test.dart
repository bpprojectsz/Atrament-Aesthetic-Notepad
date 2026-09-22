import 'dart:io';

import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:atrament/main.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Fakes path_provider's platform channel, which has no implementation
/// under plain `flutter test` and throws MissingPluginException without
/// this — local_storage.dart calls getApplicationDocumentsDirectory() to
/// resolve where the database file lives.
class _FakePathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  final String _tempPath = Directory.systemTemp
      .createTempSync('atrament_test_docs_')
      .path;

  @override
  Future<String?> getApplicationDocumentsPath() async => _tempPath;
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    PathProviderPlatform.instance = _FakePathProviderPlatform();

    // ThemeProvider, VerseProvider, and others call
    // SharedPreferences.getInstance() during init(). Without a mock,
    // that plugin's platform channel has no handler under plain
    // `flutter test` and throws MissingPluginException, which is the
    // real cause of both widget tests failing below.
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    // LocalStorage is a singleton; without closing it between tests,
    // the second test would reuse the first test's open connection and
    // any leftover rows, the same isolation problem addressed in
    // local_storage_test.dart.
    await LocalStorage.instance.close();
  });

  testWidgets('AtramentApp launches and renders the home screen', (
    tester,
  ) async {
    await tester.pumpWidget(const AtramentApp());

    // Deliberately NOT pumpAndSettle(): HomeScreen can legitimately show
    // an indeterminate CircularProgressIndicator (via LoadingIndicator)
    // while notebooks/theme/verse data is loading, and that animation
    // never stops on its own — pumpAndSettle() waits for ALL animation
    // to cease and times out against any indeterminate spinner, even a
    // perfectly correct one. A bounded number of pumps lets queued async
    // work (Futures, setState calls) resolve without demanding a fully
    // animation-free frame.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

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

    // See the note on the first test — bounded pumps, not pumpAndSettle,
    // for the same indeterminate-spinner reason.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Search field and FAB should always be present, even before
    // notebooks finish loading.
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    notebookProvider.dispose();
    noteProvider.dispose();
    subscriptionProvider.dispose();
  });
}
