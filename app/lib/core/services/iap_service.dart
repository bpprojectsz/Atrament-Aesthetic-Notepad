import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

/// Something the user should be told about that arrives asynchronously from
/// the store.
enum PurchaseEvent {
  /// The store reported that a purchase failed.
  failed,
}

/// Result of a user-initiated restore.
enum RestoreOutcome {
  /// The store confirmed an ad-free purchase.
  restored,

  /// The store answered but has no ad-free purchase for this account.
  nothingFound,

  /// Restoring could not be attempted (offline, store unavailable, ...).
  failed,
}

/// Result of a purchase attempt, for explicit UI feedback (Section 15).
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
  IapService._internal({
    InAppPurchase? iap,
    bool? isAndroid,
    Duration restoreWait = const Duration(seconds: 6),
    Duration staleCacheWait = const Duration(seconds: 15),
  }) : _iap = iap ?? InAppPurchase.instance,
       _isAndroid = isAndroid ?? (defaultTargetPlatform == TargetPlatform.android),
       _restoreWait = restoreWait,
       _staleCacheWait = staleCacheWait;

  @visibleForTesting
  IapService.forTesting({
    required InAppPurchase iap,
    required bool isAndroid,
    Duration restoreWait = const Duration(milliseconds: 200),
    Duration staleCacheWait = const Duration(milliseconds: 200),
  }) : this._internal(
         iap: iap,
         isAndroid: isAndroid,
         restoreWait: restoreWait,
         staleCacheWait: staleCacheWait,
       );

  static final IapService instance = IapService._internal();

  final InAppPurchase _iap;
  final bool _isAndroid;
  final Duration _restoreWait;
  final Duration _staleCacheWait;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  Timer? _staleCacheTimer;

  final StreamController<SubscriptionStatus> _statusController =
      StreamController<SubscriptionStatus>.broadcast();
  final StreamController<PurchaseEvent> _eventController =
      StreamController<PurchaseEvent>.broadcast();

  /// Emits whenever subscription status changes — provider subscribes to
  /// this to update ad visibility reactively.
  Stream<SubscriptionStatus> get statusStream => _statusController.stream;

  /// Store-reported problems (e.g. a failed purchase) to surface to the user.
  Stream<PurchaseEvent> get eventStream => _eventController.stream;

  SubscriptionStatus _lastKnownStatus = SubscriptionStatus.unknown;
  SubscriptionStatus get lastKnownStatus => _lastKnownStatus;

  /// Pro was assumed from the saved flag and not yet confirmed by the store.
  bool _proFromCache = false;

  /// The store itself confirmed pro during this run.
  bool _proConfirmed = false;

  List<ProductDetails> _products = const [];
  List<ProductDetails> get products => _products;

  bool _initialized = false;

  /// Applies the last confirmed ad-free state immediately, before the store
  /// has answered, so paying users never see an ad flash at startup. Call
  /// before [initialize].
  Future<void> loadCachedStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(AppConstants.prefAdFreeCached) == true &&
          _lastKnownStatus == SubscriptionStatus.unknown) {
        _proFromCache = true;
        _lastKnownStatus = SubscriptionStatus.pro;
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read cached ad-free state',
        context: 'iap_service.loadCachedStatus',
        severity: ErrorSeverity.warning,
      );
    }
  }

  Future<void> _setCache(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.prefAdFreeCached, value);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not save cached ad-free state',
        context: 'iap_service.setCache',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Initializes the store connection and begins listening for purchase
  /// updates. Call once from app startup (e.g. `subscription_provider`'s
  /// constructor). Safe to call multiple times — no-ops after the first.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final available = await _iap.isAvailable();
      if (!available) {
        // Keep a remembered pro state while the store is unreachable.
        if (_lastKnownStatus != SubscriptionStatus.pro) {
          _emitStatus(SubscriptionStatus.free);
        }
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

      // Android restores silently on every launch (Play Billing). iOS must
      // only restore when the user asks: it can show an Apple ID sign-in
      // prompt, and Apple expects restore to be a user action.
      if (_isAndroid) {
        await _iap.restorePurchases();
        _startStaleCacheTimer();
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to initialize in-app purchases',
        context: 'iap_service.initialize',
        severity: ErrorSeverity.warning,
      );
      // Degrade gracefully: treat as free tier rather than blocking the app
      // (but never demote a remembered pro state just because we're offline).
      if (_lastKnownStatus != SubscriptionStatus.pro) {
        _emitStatus(SubscriptionStatus.free);
      }
    }
  }

  /// Play Billing returns nothing for a refunded or revoked purchase. If the
  /// saved pro flag is never confirmed by the store, drop it.
  void _startStaleCacheTimer() {
    if (!_proFromCache) return;
    _staleCacheTimer?.cancel();
    _staleCacheTimer = Timer(_staleCacheWait, () {
      if (_proConfirmed) return;
      _proFromCache = false;
      _emitStatus(SubscriptionStatus.free, persist: true);
    });
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

  /// Asks the store to restore purchases. When the user asked for it, waits
  /// briefly for the store's answer so the UI can say what happened.
  Future<RestoreOutcome> restorePurchases({bool userInitiated = false}) async {
    StreamSubscription<SubscriptionStatus>? listener;
    final confirmed = Completer<void>();
    if (userInitiated) {
      listener = statusStream.listen((status) {
        if (status == SubscriptionStatus.pro && !confirmed.isCompleted) {
          confirmed.complete();
        }
      });
    }

    try {
      await _iap.restorePurchases();
      if (!userInitiated) return RestoreOutcome.restored;

      var gotPro = false;
      try {
        await confirmed.future.timeout(_restoreWait);
        gotPro = true;
      } on TimeoutException {
        gotPro = false;
      }
      if (gotPro) return RestoreOutcome.restored;

      // The store answered with no ad-free purchase for this account, so a
      // remembered pro flag is no longer trustworthy.
      _proFromCache = false;
      _proConfirmed = false;
      _emitStatus(SubscriptionStatus.free, persist: true);
      return RestoreOutcome.nothingFound;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Restore purchases failed',
        context: 'iap_service.restorePurchases',
        severity: ErrorSeverity.warning,
      );
      return RestoreOutcome.failed;
    } finally {
      await listener?.cancel();
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    var hasActivePro = false;
    var sawOutcome = false;

    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          sawOutcome = true;
          final isKnownProduct =
              purchase.productID == AppConstants.iapAdFreeProductId;
          if (isKnownProduct) {
            hasActivePro = true;
          }
          // Android requires explicit acknowledgement or the purchase
          // auto-refunds within 3 days. A failure here must not stop the
          // user getting what they paid for; the store re-delivers it.
          if (purchase.pendingCompletePurchase) {
            try {
              await _iap.completePurchase(purchase);
            } catch (error, stackTrace) {
              ErrorHandler.report(
                error,
                stackTrace,
                message: 'Could not complete purchase',
                context: 'iap_service.completePurchase',
                severity: ErrorSeverity.warning,
              );
            }
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
          _eventController.add(PurchaseEvent.failed);
          break;

        case PurchaseStatus.canceled:
          break;
      }
    }

    if (hasActivePro) {
      _proConfirmed = true;
      _proFromCache = false;
      _staleCacheTimer?.cancel();
      _emitStatus(SubscriptionStatus.pro, persist: true);
    } else if (sawOutcome) {
      // The store returned purchases, none of them ours.
      _emitStatus(SubscriptionStatus.free, persist: true);
    } else if (_lastKnownStatus != SubscriptionStatus.pro) {
      // Only pending / cancelled / failed entries: not enough to change a
      // known pro state, but a still-unknown state is now simply free.
      _emitStatus(SubscriptionStatus.free);
    }
  }

  void _emitStatus(SubscriptionStatus status, {bool persist = false}) {
    _lastKnownStatus = status;
    if (persist && status != SubscriptionStatus.unknown) {
      unawaited(_setCache(status == SubscriptionStatus.pro));
    }
    _statusController.add(status);
  }

  void dispose() {
    _staleCacheTimer?.cancel();
    _purchaseSubscription?.cancel();
    _statusController.close();
    _eventController.close();
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
