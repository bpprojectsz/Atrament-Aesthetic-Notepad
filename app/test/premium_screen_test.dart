import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/services/iap_service.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart' show PurchaseStatus;
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_store.dart';
import 'helpers/screen_texts.dart';

final _l10n = lookupAppLocalizations(const Locale('en'));

Future<void> _pump(WidgetTester tester, [int ms = 500]) async {
  var elapsed = 0;
  while (elapsed < ms) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += 50;
  }
}

Future<(FakeStore, SubscriptionProvider)> _open(
  WidgetTester tester, {
  bool cachedPro = false,
}) async {
  SharedPreferences.setMockInitialValues({
    if (cachedPro) AppConstants.prefAdFreeCached: true,
  });
  final store = FakeStore();
  final provider = SubscriptionProvider(
    iapService: IapService.forTesting(iap: store, isAndroid: false),
  );
  await provider.init();

  tester.view.physicalSize = const Size(900, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PremiumScreen(subscriptionProvider: provider),
    ),
  );
  await _pump(tester);
  return (store, provider);
}

void main() {
  testWidgets('buying when the store has no product says so, in words', (
    tester,
  ) async {
    await _open(tester);

    await tester.tap(find.text(_l10n.premiumUnlockLabel));
    await _pump(tester);

    expect(find.text(_l10n.purchaseUnavailableMessage), findsOneWidget);
  });

  testWidgets('a purchase the store reports as failed shows a message', (
    tester,
  ) async {
    final (store, _) = await _open(tester);

    store.purchases.add([purchaseDetails(PurchaseStatus.error)]);
    await _pump(tester);

    expect(find.text(_l10n.purchaseFailedMessage), findsOneWidget);
  });

  testWidgets('Restore reports a restored purchase', (tester) async {
    final (store, provider) = await _open(tester);
    store.onRestore = () =>
        store.purchases.add([purchaseDetails(PurchaseStatus.restored)]);

    await tester.tap(find.text(_l10n.premiumRestoreButton));
    await _pump(tester);

    expectOnScreen(tester, _l10n.restoreSuccessMessage,
        extra: 'restoreCalls=${store.restoreCalls} processing=${provider.isProcessingPurchase.value} status=${provider.status.value}');
  });

  testWidgets('Restore reports when there is nothing to restore', (tester) async {
    await _open(tester);

    await tester.tap(find.text(_l10n.premiumRestoreButton));
    await _pump(tester, 800);

    expectOnScreen(tester, _l10n.restoreNothingFoundMessage);
  });

  testWidgets('Restore reports when the store cannot be reached', (tester) async {
    final (store, provider) = await _open(tester);
    store.restoreThrows = true;

    await tester.tap(find.text(_l10n.premiumRestoreButton));
    await _pump(tester);

    expectOnScreen(tester, _l10n.restoreFailedMessage,
        extra: 'restoreCalls=${store.restoreCalls} processing=${provider.isProcessingPurchase.value} status=${provider.status.value}');
  });

  testWidgets('someone who already bought ad removal is told so', (tester) async {
    await _open(tester, cachedPro: true);

    expect(find.text(_l10n.premiumAlreadyProMessage), findsOneWidget);
  });
}
