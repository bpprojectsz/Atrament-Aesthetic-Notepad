import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Current subscription state, emitted to `subscription_provider.dart`.
enum SubscriptionStatus {
  /// Purchase state not yet determined (still querying at startup).
  unknown,

  /// No active ad-removal subscription — banner ads show.
  free,

  /// Active ad-removal subscription — banner ads hidden.
  pro,
}

/// Result of a purchase or restore attempt, for explicit UI feedback
/// (Section 15).
class PurchaseAttemptResult {
  const PurchaseAttemptResult.success()
    : errorMessage = null,
      cancelled = false;
  const PurchaseAttemptResult.failure(this.errorMessage) : cancelled = false;
  const PurchaseAttemptResult.cancelled()
    : errorMessage = null,
      cancelled = true;

  final String? errorMessage;
  final bool cancelled;

  bool get succeeded => errorMessage == null && !cancelled;
}

/// Wraps `in_app_purchase` (StoreKit on iOS, Play Billing on Android) for
/// the single one-time ad-removal purchase. This is the only file that
/// imports `in_app_purchase` directly — `subscription_provider.dart`
/// listens to [statusStream] rather than touching the plugin.
class IapService {
  IapService._internal();

  static final IapService instance = IapService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  final StreamController<SubscriptionStatus> _statusController =
      StreamController<SubscriptionStatus>.broadcast();

  /// Emits whenever subscription status changes — provider subscribes to
  /// this to update ad visibility reactively.
  Stream<SubscriptionStatus> get statusStream => _statusController.stream;

  SubscriptionStatus _lastKnownStatus = SubscriptionStatus.unknown;
  SubscriptionStatus get lastKnownStatus => _lastKnownStatus;

  List<ProductDetails> _products = const [];
  List<ProductDetails> get products => _products;

  bool _initialized = false;

  /// Initializes the store connection and begins listening for purchase
  /// updates. Call once from app startup (e.g. `subscription_provider`'s
  /// constructor). Safe to call multiple times — no-ops after the first.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final available = await _iap.isAvailable();
      if (!available) {
        _emitStatus(SubscriptionStatus.free);
        return;
      }

      _purchaseSubscription = _iap.purchaseStream.listen(
        _handlePurchaseUpdates,
        onError: (Object error, StackTrace stackTrace) {
          ErrorHandler.report(
            error,
            stackTrace,
            message: 'Purchase stream error',
            context: 'iap_service.purchaseStream',
            severity: ErrorSeverity.warning,
          );
        },
      );

      await _queryProducts();
      await restorePurchases();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to initialize in-app purchases',
        context: 'iap_service.initialize',
        severity: ErrorSeverity.warning,
      );
      // Degrade gracefully: treat as free tier rather than blocking the app.
      _emitStatus(SubscriptionStatus.free);
    }
  }

  Future<void> _queryProducts() async {
    const ids = {AppConstants.iapAdFreeProductId};
    final response = await _iap.queryProductDetails(ids);
    if (response.error != null) {
      ErrorHandler.report(
        response.error!,
        StackTrace.current,
        message: 'Product query returned an error',
        context: 'iap_service.queryProducts',
        severity: ErrorSeverity.warning,
      );
    }
    _products = response.productDetails;
  }

  Future<PurchaseAttemptResult> purchase(String productId) async {
    final product = _products.where((p) => p.id == productId).firstOrNull;
    if (product == null) {
      return const PurchaseAttemptResult.failure(
        'This product is not available right now. Please try again later.',
      );
    }

    try {
      final param = PurchaseParam(productDetails: product);
      final started = await _iap.buyNonConsumable(purchaseParam: param);
      if (!started) {
        return const PurchaseAttemptResult.failure(
          'Could not start the purchase. Please try again.',
        );
      }
      // Actual success/failure arrives asynchronously via purchaseStream
      // and is reflected in statusStream; this return value only confirms
      // the purchase flow was launched.
      return const PurchaseAttemptResult.success();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Purchase attempt threw',
        context: 'iap_service.purchase',
        severity: ErrorSeverity.warning,
      );
      return const PurchaseAttemptResult.failure(
        'Something went wrong starting the purchase.',
      );
    }
  }

  Future<PurchaseAttemptResult> restorePurchases() async {
    try {
      await _iap.restorePurchases();
      return const PurchaseAttemptResult.success();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Restore purchases failed',
        context: 'iap_service.restorePurchases',
        severity: ErrorSeverity.warning,
      );
      return const PurchaseAttemptResult.failure(
        'Could not restore purchases. Please check your connection and try again.',
      );
    }
  }

  Future<void> _handlePurchaseUpdates(
    List<PurchaseDetails> purchases,
  ) async {
    var hasActivePro = false;

    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final isKnownProduct =
              purchase.productID == AppConstants.iapAdFreeProductId;
          if (isKnownProduct) {
            hasActivePro = true;
          }
          // Android requires explicit acknowledgement or the purchase
          // auto-refunds within 3 days.
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.error:
          ErrorHandler.report(
            purchase.error ?? Exception('Unknown purchase error'),
            StackTrace.current,
            message: 'Purchase reported an error status',
            context: 'iap_service.handlePurchaseUpdates',
            severity: ErrorSeverity.warning,
          );
          break;

        case PurchaseStatus.canceled:
          break;
      }
    }

    _emitStatus(hasActivePro ? SubscriptionStatus.pro : SubscriptionStatus.free);
  }

  void _emitStatus(SubscriptionStatus status) {
    _lastKnownStatus = status;
    _statusController.add(status);
  }

  void dispose() {
    _purchaseSubscription?.cancel();
    _statusController.close();
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
