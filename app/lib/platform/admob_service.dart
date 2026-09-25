import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/utils/error_handler.dart';

/// Wraps `google_mobile_ads` initialization and banner loading. Every call
/// site treats failure as a normal, expected outcome — the banner slot
/// collapses to zero height rather than the app crashing or blocking the
/// home screen (Section 14).
///
/// REPLACE: the unit IDs below with real values from Section 1a before
/// submission. The test IDs shown are Google's official sample ad unit
/// IDs and are safe to ship in development builds.
class AdMobService {
  AdMobService._internal();

  static final AdMobService instance = AdMobService._internal();

  bool _initialized = false;
  bool _initializationFailed = false;

  /// Flipped to true once the SDK finishes initializing successfully.
  /// Banner call sites listen for the false-to-true transition to retry
  /// a load that was requested before the SDK was ready.
  final ValueNotifier<bool> availability = ValueNotifier(false);

  bool get isAvailable => _initialized && !_initializationFailed;

  String get bannerAdUnitId {
    if (Platform.isIOS) {
      // REPLACE: ca-app-pub-xxxxxxxx/xxxxxxxx (AdMob — iOS Banner Unit ID)
      return 'ca-app-pub-3940256099942544/2934735716'; // Google test unit
    }
    // REPLACE: ca-app-pub-xxxxxxxx/xxxxxxxx (AdMob — Android Banner Unit ID)
    return 'ca-app-pub-3940256099942544/6300978111'; // Google test unit
  }

  String get interstitialAdUnitId {
    if (Platform.isIOS) {
      // REPLACE: ca-app-pub-xxxxxxxx/xxxxxxxx (AdMob — iOS Interstitial Unit ID)
      return 'ca-app-pub-3940256099942544/4411468910'; // Google test unit
    }
    // REPLACE: ca-app-pub-xxxxxxxx/xxxxxxxx (AdMob — Android Interstitial Unit ID)
    return 'ca-app-pub-3940256099942544/1033173712'; // Google test unit
  }

  /// Loads a single interstitial. Returns `null` on any failure — network,
  /// fill, SDK not initialized — so callers can safely no-op.
  Future<InterstitialAd?> loadInterstitial() async {
    if (!isAvailable) return null;

    final completer = Completer<InterstitialAd?>();
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) completer.complete(ad);
        },
        onAdFailedToLoad: (error) {
          ErrorHandler.report(
            Exception(error.message),
            StackTrace.current,
            message: 'Interstitial ad failed to load',
            context: 'admob_service.loadInterstitial',
            severity: ErrorSeverity.warning,
          );
          if (!completer.isCompleted) completer.complete(null);
        },
      ),
    );
    return completer.future;
  }

  /// Initializes the Mobile Ads SDK. Safe to call once at app startup;
  /// never throws — failures are caught and recorded so [isAvailable]
  /// reports false and callers can skip ad requests entirely.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await MobileAds.instance.initialize();
      _initialized = true;
      availability.value = true;
    } catch (error, stackTrace) {
      _initializationFailed = true;
      _initialized = true;
      availability.value = false;
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'AdMob SDK failed to initialize',
        context: 'admob_service.initialize',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Loads a single adaptive banner ad. Returns `null` on any failure
  /// (network, fill, SDK not initialized) — the caller
  /// (`banner_ad_widget.dart`) treats a null result as "render nothing."
  Future<BannerAd?> loadBanner({
    required void Function() onFailed,
  }) async {
    if (!isAvailable) {
      onFailed();
      return null;
    }

    // KatharScan parity: fixed 320x50 standard banner, not anchored adaptive.
    const sizeResult = AdSize.banner;

    BannerAd? banner;
    final completer = Completer<BannerAd?>();

    banner = BannerAd(
      adUnitId: bannerAdUnitId,
      size: sizeResult,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!completer.isCompleted) completer.complete(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          ErrorHandler.report(
            Exception(error.message),
            StackTrace.current,
            message: 'Banner ad failed to load',
            context: 'admob_service.loadBanner',
            severity: ErrorSeverity.warning,
          );
          onFailed();
          if (!completer.isCompleted) completer.complete(null);
        },
      ),
    );

    await banner.load();
    return completer.future;
  }
}
