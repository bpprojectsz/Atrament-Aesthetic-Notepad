import 'dart:async';

import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/services/iap_service.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_store.dart';

Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 40));

Future<bool?> _cachedFlag() async =>
    (await SharedPreferences.getInstance()).getBool(AppConstants.prefAdFreeCached);

void main() {
  late FakeStore store;

  void seedCache(bool? value) => SharedPreferences.setMockInitialValues({
    if (value != null) AppConstants.prefAdFreeCached: value,
  });

  IapService makeService({required bool android}) =>
      IapService.forTesting(iap: store, isAndroid: android);

  setUp(() {
    store = FakeStore();
    seedCache(null);
  });

  tearDown(() => store.dispose());

  group('remembered ad-free state', () {
    test('is applied before the store answers', () async {
      seedCache(true);
      final service = makeService(android: true);

      await service.loadCachedStatus();

      expect(service.lastKnownStatus, SubscriptionStatus.pro);
    });

    test('is absent for a user who never bought it', () async {
      final service = makeService(android: true);

      await service.loadCachedStatus();

      expect(service.lastKnownStatus, SubscriptionStatus.unknown);
    });

    test('survives the store being unreachable', () async {
      seedCache(true);
      store.available = false;
      final service = makeService(android: true);

      await service.loadCachedStatus();
      await service.initialize();

      expect(service.lastKnownStatus, SubscriptionStatus.pro,
          reason: 'offline must not demote a paying user');
    });

    test('a store-confirmed purchase is remembered for next launch', () async {
      final service = makeService(android: true);
      await service.initialize();

      store.purchases.add([purchaseDetails(PurchaseStatus.purchased)]);
      await _settle();

      expect(service.lastKnownStatus, SubscriptionStatus.pro);
      expect(await _cachedFlag(), isTrue);
    });

    test('Android drops a remembered flag the store never confirms', () async {
      seedCache(true);
      final service = makeService(android: true);
      await service.loadCachedStatus();
      await service.initialize();

      await Future<void>.delayed(const Duration(milliseconds: 400));

      expect(service.lastKnownStatus, SubscriptionStatus.free,
          reason: 'e.g. the purchase was refunded');
      expect(await _cachedFlag(), isFalse);
    });

    test('Android keeps it when the store does confirm', () async {
      seedCache(true);
      final service = makeService(android: true);
      await service.loadCachedStatus();
      store.onRestore = () =>
          store.purchases.add([purchaseDetails(PurchaseStatus.restored)]);
      await service.initialize();

      await Future<void>.delayed(const Duration(milliseconds: 400));

      expect(service.lastKnownStatus, SubscriptionStatus.pro);
      expect(await _cachedFlag(), isTrue);
    });
  });

  group('restore at startup', () {
    test('Android restores silently at launch', () async {
      await makeService(android: true).initialize();
      expect(store.restoreCalls, 1);
    });

    test('iOS never restores on its own (it can prompt for an Apple ID)', () async {
      await makeService(android: false).initialize();
      expect(store.restoreCalls, 0);
    });
  });

  group('purchase updates', () {
    test('a failed purchase is reported to the UI', () async {
      final service = makeService(android: true);
      await service.initialize();
      final events = <PurchaseEvent>[];
      service.eventStream.listen(events.add);

      store.purchases.add([purchaseDetails(PurchaseStatus.error)]);
      await _settle();

      expect(events, [PurchaseEvent.failed]);
    });

    test('failing to acknowledge a purchase still gives the user ad-free', () async {
      store.completeThrows = true;
      final service = makeService(android: true);
      await service.initialize();

      store.purchases.add([
        purchaseDetails(PurchaseStatus.purchased, pendingComplete: true),
      ]);
      await _settle();

      expect(service.lastKnownStatus, SubscriptionStatus.pro);
    });

    test('a pending or cancelled update never demotes a known pro user', () async {
      final service = makeService(android: true);
      await service.initialize();
      store.purchases.add([purchaseDetails(PurchaseStatus.purchased)]);
      await _settle();
      expect(service.lastKnownStatus, SubscriptionStatus.pro);

      store.purchases.add([purchaseDetails(PurchaseStatus.pending)]);
      await _settle();
      store.purchases.add([purchaseDetails(PurchaseStatus.canceled)]);
      await _settle();

      expect(service.lastKnownStatus, SubscriptionStatus.pro);
    });

    test('a cancelled purchase from an unknown state simply means free', () async {
      final service = makeService(android: false);
      await service.initialize();

      store.purchases.add([purchaseDetails(PurchaseStatus.canceled)]);
      await _settle();

      expect(service.lastKnownStatus, SubscriptionStatus.free);
    });

    test('purchases of some other product do not unlock ad-free', () async {
      final service = makeService(android: true);
      await service.initialize();

      store.purchases.add([
        purchaseDetails(PurchaseStatus.restored, productId: 'something.else'),
      ]);
      await _settle();

      expect(service.lastKnownStatus, SubscriptionStatus.free);
    });
  });

  group('user-initiated restore', () {
    test('reports restored when the store confirms a purchase', () async {
      final service = makeService(android: false);
      await service.initialize();
      store.onRestore = () =>
          store.purchases.add([purchaseDetails(PurchaseStatus.restored)]);

      final outcome = await service.restorePurchases(userInitiated: true);

      expect(outcome, RestoreOutcome.restored);
      expect(service.lastKnownStatus, SubscriptionStatus.pro);
    });

    test('reports nothing found, and forgets a stale remembered flag', () async {
      seedCache(true);
      final service = makeService(android: false);
      await service.loadCachedStatus();
      await service.initialize();
      expect(service.lastKnownStatus, SubscriptionStatus.pro);

      final outcome = await service.restorePurchases(userInitiated: true);

      expect(outcome, RestoreOutcome.nothingFound);
      expect(service.lastKnownStatus, SubscriptionStatus.free);
      expect(await _cachedFlag(), isFalse);
    });

    test('reports failure when the store cannot be reached', () async {
      final service = makeService(android: false);
      await service.initialize();
      store.restoreThrows = true;

      expect(
        await service.restorePurchases(userInitiated: true),
        RestoreOutcome.failed,
      );
    });
  });

  group('SubscriptionProvider', () {
    test('shows a remembered ad-free state immediately, before the store answers', () async {
      seedCache(true);
      store.availabilityGate = Completer<bool>(); // the store is still slow
      final provider = SubscriptionProvider(
        iapService: makeService(android: true),
      );

      unawaited(provider.init());
      await _settle();

      expect(provider.status.value, SubscriptionStatus.pro);
      expect(provider.shouldShowAds, isFalse,
          reason: 'a paying user must not see an ad while the store loads');

      store.availabilityGate!.complete(true);
      await _settle();
      provider.dispose();
    });

    test('raises purchaseFailed when the store reports a failure', () async {
      final provider = SubscriptionProvider(
        iapService: makeService(android: true),
      );
      await provider.init();
      expect(provider.purchaseFailed.value, isFalse);

      store.purchases.add([purchaseDetails(PurchaseStatus.error)]);
      await _settle();

      expect(provider.purchaseFailed.value, isTrue);
      provider.dispose();
    });

    test('restore() passes the outcome through', () async {
      final provider = SubscriptionProvider(
        iapService: makeService(android: false),
      );
      await provider.init();
      store.onRestore = () =>
          store.purchases.add([purchaseDetails(PurchaseStatus.restored)]);

      expect(await provider.restore(), RestoreOutcome.restored);
      expect(provider.isProcessingPurchase.value, isFalse);
      provider.dispose();
    });
  });
}
