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

  StreamSubscription<SubscriptionStatus>? _statusSubscription;
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

    await _iap.initialize();
    status.value = _iap.lastKnownStatus;

    _statusSubscription = _iap.statusStream.listen((newStatus) {
      status.value = newStatus;
    });
  }

  Future<void> purchase() => _purchase(AppConstants.iapAdFreeProductId);

  Future<void> _purchase(String productId) async {
    isProcessingPurchase.value = true;
    lastErrorMessage.value = null;
    try {
      final result = await _iap.purchase(productId);
      if (!result.succeeded && result.errorMessage != null) {
        lastErrorMessage.value = result.errorMessage;
      }
    } finally {
      isProcessingPurchase.value = false;
    }
  }

  Future<void> restore() async {
    isProcessingPurchase.value = true;
    lastErrorMessage.value = null;
    try {
      final result = await _iap.restorePurchases();
      if (!result.succeeded && result.errorMessage != null) {
        lastErrorMessage.value = result.errorMessage;
      }
    } finally {
      isProcessingPurchase.value = false;
    }
  }

  void clearError() {
    lastErrorMessage.value = null;
  }

  void dispose() {
    _statusSubscription?.cancel();
    status.dispose();
    isProcessingPurchase.dispose();
    lastErrorMessage.dispose();
  }
}
