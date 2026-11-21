import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/iap_service.dart';
import '../core/utils/error_handler.dart';
import 'admob_service.dart';

/// Owns interstitial load-and-show. Every countable user action (a real
/// save, a note creation, an export, a notebook delete) feeds ONE combined
/// counter; an ad is attempted on every [actionThreshold]-th action.
///
/// The counter and the time of the last shown ad are stored in
/// SharedPreferences, so they survive app restarts.
///
/// Never shows an interstitial if:
///   - the user has the ad-free purchase
///   - the SDK failed to initialize
///   - fewer than [minGap] have passed since the last interstitial
///
/// There is deliberately no session, daily or hourly cap (owner decision
/// D-070); the 5-minute gap is the only limit besides the counter.
class InterstitialService {
  InterstitialService._internal();

  static final InterstitialService instance = InterstitialService._internal();

  static const int actionThreshold = 9;
  static const Duration minGap = Duration(minutes: 5);
  static const String prefActionCount = 'interstitial_action_count';
  static const String prefLastShownMs = 'interstitial_last_shown_ms';

  int _actionCount = 0;
  int? _lastShownMs;
  bool _loaded = false;
  Future<void>? _loading;

  /// True when at least [minGap] has passed since [lastShownMs]. A missing
  /// value counts as elapsed, and so does a clock that moved backwards
  /// (negative difference), so a wrong device clock can never block ads
  /// for good.
  @visibleForTesting
  static bool gapElapsed(DateTime now, int? lastShownMs) {
    if (lastShownMs == null) return true;
    final diff = now.millisecondsSinceEpoch - lastShownMs;
    if (diff < 0) return true;
    return diff >= minGap.inMilliseconds;
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _actionCount = prefs.getInt(prefActionCount) ?? 0;
      _lastShownMs = prefs.getInt(prefLastShownMs);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load interstitial counters',
        context: 'interstitial_service.load',
        severity: ErrorSeverity.warning,
      );
    }
    _loaded = true;
  }

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    await (_loading ??= _load());
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(prefActionCount, _actionCount);
      final last = _lastShownMs;
      if (last != null) await prefs.setInt(prefLastShownMs, last);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to save interstitial counters',
        context: 'interstitial_service.persist',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Actions counted since the last attempt (0 to [actionThreshold] - 1).
  @visibleForTesting
  int get pendingActionCount => _actionCount;

  /// Kept for existing callers and tests; every action type shares one counter.
  @visibleForTesting
  int get pendingSaveCount => _actionCount;

  /// When an interstitial was last shown (persisted), or null if never.
  /// The review prompt uses this to stay away from ads.
  Future<DateTime?> lastShownAt() async {
    await _ensureLoaded();
    final ms = _lastShownMs;
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  /// Resets memory only, and marks it loaded so tests need no preferences.
  @visibleForTesting
  void resetCountersForTesting() {
    _actionCount = 0;
    _lastShownMs = null;
    _loaded = true;
    _loading = null;
  }

  /// Forgets memory so the next action reads SharedPreferences again,
  /// like a fresh app start.
  @visibleForTesting
  void simulateRestartForTesting() {
    _actionCount = 0;
    _lastShownMs = null;
    _loaded = false;
    _loading = null;
  }

  bool _isAdFree() =>
      IapService.instance.lastKnownStatus == SubscriptionStatus.pro;

  /// One countable action. The count goes up before any await once the
  /// state is loaded, so callers and tests see it immediately.
  Future<void> _recordAction() async {
    if (!_loaded) await _ensureLoaded();
    _actionCount++;
    final due = _actionCount >= actionThreshold;
    if (due) _actionCount = 0;
    await _persist();
    if (due) await _showIfReady();
  }

  /// Called after a note is successfully persisted (except silent autosave).
  Future<void> recordNoteSave() => _recordAction();

  /// Called when a new note is created (editor opened from the FAB).
  Future<void> recordNoteCreate() => _recordAction();

  /// Called after the export + share flow returns.
  Future<void> showAfterExport() => _recordAction();

  /// Called after a notebook is successfully deleted.
  Future<void> showAfterNotebookDelete() => _recordAction();

  Future<void> _showIfReady() async {
    if (_isAdFree()) return;
    if (!gapElapsed(DateTime.now(), _lastShownMs)) return;
    if (!AdMobService.instance.isAvailable) return;

    try {
      final ad = await AdMobService.instance.loadInterstitial();
      if (ad == null) return;
      _lastShownMs = DateTime.now().millisecondsSinceEpoch;
      await _persist();
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
