import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart' show ProductDetails;

import '../services/iap_service.dart';
import '../utils/constants.dart';

/// Owns ad-removal subscription state for the whole app. Wraps
/// [IapService] so screens never import `in_app_purchase` directly.
class SubscriptionProvider {
  SubscriptionProvider({IapService? iapService})
    : _iap = iapService ?? IapService.instance;

  final IapService _iap;

  final ValueNotifier<SubscriptionStatus> status = ValueNotifier(
    SubscriptionStatus.unknown,
  );

  final ValueNotifier<bool> isProcessingPurchase = ValueNotifier(false);

  final ValueNotifier<String?> lastErrorMessage = ValueNotifier(null);

  /// True after the store reported that a purchase failed; the UI shows a
  /// localized message.
  final ValueNotifier<bool> purchaseFailed = ValueNotifier(false);

  StreamSubscription<SubscriptionStatus>? _statusSubscription;
  StreamSubscription<PurchaseEvent>? _eventSubscription;
  bool _initialized = false;

  /// Whether the banner ad slot should render. `true` for free/unknown so
  /// the UI defaults to showing ads (and thus the correct App Store /
  /// Play policy behavior) until purchase state is confirmed, rather than
  /// briefly hiding ads it isn't yet entitled to hide.
  bool get shouldShowAds => status.value != SubscriptionStatus.pro;

  List<ProductDetails> get availableProducts => _iap.products;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    // Show a remembered ad-free state straight away, then let the store
    // confirm or correct it.
    await _iap.loadCachedStatus();
    status.value = _iap.lastKnownStatus;

    _statusSubscription = _iap.statusStream.listen((newStatus) {
      status.value = newStatus;
    });
    _eventSubscription = _iap.eventStream.listen((event) {
      if (event == PurchaseEvent.failed) {
        purchaseFailed.value = true;
        isProcessingPurchase.value = false;
      }
    });

    await _iap.initialize();
    status.value = _iap.lastKnownStatus;
  }

  Future<void> purchase() => _purchase(AppConstants.iapAdFreeProductId);

  Future<void> _purchase(String productId) async {
    isProcessingPurchase.value = true;
    lastErrorMessage.value = null;
    purchaseFailed.value = false;
    try {
      final result = await _iap.purchase(productId);
      if (!result.succeeded && result.errorMessage != null) {
        lastErrorMessage.value = result.errorMessage;
      }
    } finally {
      isProcessingPurchase.value = false;
    }
  }

  /// Restores purchases on the user's request and reports what happened.
  Future<RestoreOutcome> restore() async {
    isProcessingPurchase.value = true;
    lastErrorMessage.value = null;
    purchaseFailed.value = false;
    try {
      return await _iap.restorePurchases(userInitiated: true);
    } finally {
      isProcessingPurchase.value = false;
    }
  }

  void clearError() {
    lastErrorMessage.value = null;
  }

  void dispose() {
    _statusSubscription?.cancel();
    _eventSubscription?.cancel();
    purchaseFailed.dispose();
    status.dispose();
    isProcessingPurchase.dispose();
    lastErrorMessage.dispose();
  }
}
