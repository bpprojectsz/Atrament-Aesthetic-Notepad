import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/services/iap_service.dart';
import '../core/utils/error_handler.dart';
import 'admob_service.dart';

/// Owns interstitial load-and-show with a session-wide cooldown and
/// per-action counters. Callers notify this service that a countable
/// event occurred; the service decides whether to actually show an ad.
///
/// Never shows an interstitial if:
///   - the user has the ad-free purchase
///   - the SDK failed to initialize
///   - the minimum cooldown since the last interstitial has not elapsed
///
/// AdMob policy: interstitials may not appear more than once per user
/// action, and not more than once per 30 seconds. The cooldown below
/// enforces the latter; the former is satisfied because every trigger
/// here is a discrete user action.
class InterstitialService {
  InterstitialService._internal();

  static final InterstitialService instance = InterstitialService._internal();

  static const int _saveThreshold = 9;
  static const int _createThreshold = 9;
  static const Duration _minCooldown = Duration(seconds: 30);

  int _saveCount = 0;
  int _createCount = 0;
  DateTime? _lastShownAt;

  bool _cooldownElapsed() {
    final last = _lastShownAt;
    if (last == null) return true;
    return DateTime.now().difference(last) >= _minCooldown;
  }

  bool _isAdFree() =>
      IapService.instance.lastKnownStatus == SubscriptionStatus.pro;

  /// Called after a note is successfully persisted. Fires an interstitial
  /// once every [_saveThreshold] successful saves.
  Future<void> recordNoteSave() async {
    _saveCount++;
    if (_saveCount < _saveThreshold) return;
    _saveCount = 0;
    await _showIfReady();
  }

  /// Called when a new note is created (editor opened from the FAB).
  /// Fires an interstitial once every [_createThreshold] creations.
  Future<void> recordNoteCreate() async {
    _createCount++;
    if (_createCount < _createThreshold) return;
    _createCount = 0;
    await _showIfReady();
  }

  /// Called after the export + share flow returns. Fires at most once
  /// per 30 seconds regardless of how often the user exports.
  Future<void> showAfterExport() async {
    await _showIfReady();
  }

  /// Called after a notebook is successfully deleted.
  Future<void> showAfterNotebookDelete() async {
    await _showIfReady();
  }

  Future<void> _showIfReady() async {
    if (_isAdFree()) return;
    if (!_cooldownElapsed()) return;
    if (!AdMobService.instance.isAvailable) return;

    try {
      final ad = await AdMobService.instance.loadInterstitial();
      if (ad == null) return;
      _lastShownAt = DateTime.now();
      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) => ad.dispose(),
        onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose(),
      );
      await ad.show();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Interstitial load/show failed',
        context: 'interstitial_service.showIfReady',
        severity: ErrorSeverity.warning,
      );
    }
  }
}
