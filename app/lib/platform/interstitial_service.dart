import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/iap_service.dart';
import '../core/utils/error_handler.dart';
import 'admob_service.dart';

/// Owns interstitial load-and-show. Every countable user action feeds ONE
/// combined counter (see the `record…` methods). After [actionThreshold]
/// actions an ad becomes PENDING, and it is shown on the first counting
/// action at which the minimum gap since the last ad has passed. Nothing
/// is wasted: a pending ad waits for the gap instead of being dropped.
///
/// The counter, the pending flag and the time of the last shown ad are
/// stored in SharedPreferences, so they survive app restarts.
///
/// Never shows an interstitial if:
///   - the user has the ad-free purchase
///   - the SDK failed to initialize
///   - fewer than [minGap] have passed since the last interstitial
///
/// There is deliberately no session, daily or hourly cap (owner decision
/// D-070); the gap is the only limit besides the counter.
class InterstitialService {
  InterstitialService._internal();

  static final InterstitialService instance = InterstitialService._internal();

  static const int actionThreshold = 9;
  static const Duration minGap = Duration(minutes: 9);

  /// After an attempt that showed nothing (offline, no fill, SDK off), wait
  /// this long before trying again, so every action does not start a load.
  static const Duration retryAfterFailure = Duration(seconds: 60);

  /// An ad and the review sheet never appear within this long of each other.
  static const Duration reviewProximity = Duration(minutes: 10);

  static const String prefActionCount = 'interstitial_action_count';
  static const String prefPending = 'interstitial_pending';
  static const String prefLastShownMs = 'interstitial_last_shown_ms';
  static const String prefLastReviewMs = 'interstitial_last_review_ms';

  int _actionCount = 0;
  bool _pending = false;
  int? _lastShownMs;
  int? _lastReviewMs;
  int? _lastAttemptMs; // memory only
  bool _attempting = false;
  bool _loaded = false;
  Future<void>? _loading;
  DateTime Function() _now = DateTime.now;

  /// True when at least [gap] has passed since [lastMs]. A missing value
  /// counts as elapsed, and so does a clock that moved backwards (negative
  /// difference), so a wrong device clock can never block ads for good.
  @visibleForTesting
  static bool gapElapsed(DateTime now, int? lastMs, [Duration gap = minGap]) {
    if (lastMs == null) return true;
    final diff = now.millisecondsSinceEpoch - lastMs;
    if (diff < 0) return true;
    return diff >= gap.inMilliseconds;
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _actionCount = prefs.getInt(prefActionCount) ?? 0;
      _pending = prefs.getBool(prefPending) ?? false;
      _lastShownMs = prefs.getInt(prefLastShownMs);
      _lastReviewMs = prefs.getInt(prefLastReviewMs);
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
      await prefs.setBool(prefPending, _pending);
      final last = _lastShownMs;
      if (last != null) await prefs.setInt(prefLastShownMs, last);
      final review = _lastReviewMs;
      if (review != null) await prefs.setInt(prefLastReviewMs, review);
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

  /// Tests replace the real show step (which needs the ads and purchase
  /// plugins). It returns true when an ad was shown.
  @visibleForTesting
  Future<bool> Function()? showAttemptForTesting;

  @visibleForTesting
  set clockForTesting(DateTime Function() clock) => _now = clock;

  /// Actions counted towards the next ad (0 to [actionThreshold] - 1).
  /// Counting pauses while an ad is pending.
  @visibleForTesting
  int get pendingActionCount => _actionCount;

  /// Kept for existing callers and tests; every action type shares one counter.
  @visibleForTesting
  int get pendingSaveCount => _actionCount;

  /// True when the counter is full and an ad is waiting for the gap to pass.
  @visibleForTesting
  bool get isAdPending => _pending;

  /// When an interstitial was last shown (persisted), or null if never.
  /// The review prompt uses this to stay away from ads.
  Future<DateTime?> lastShownAt() async {
    await _ensureLoaded();
    final ms = _lastShownMs;
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  /// The review prompt asks for the right to appear. Granted only when no
  /// ad is being loaded or shown right now and none was shown in the last
  /// [reviewProximity]; if granted, the time is recorded so ads keep away
  /// from the review sheet for the same period. The check and the
  /// recording happen with no await between them, so an ad and the review
  /// sheet can never both pass on the same save.
  Future<bool> claimReviewSlot() async {
    await _ensureLoaded();
    final now = _now();
    if (_attempting) return false;
    if (!gapElapsed(now, _lastShownMs, reviewProximity)) return false;
    _lastReviewMs = now.millisecondsSinceEpoch;
    await _persist();
    return true;
  }

  /// Resets memory only, and marks it loaded so tests need no preferences.
  @visibleForTesting
  void resetCountersForTesting() {
    _actionCount = 0;
    _pending = false;
    _lastShownMs = null;
    _lastReviewMs = null;
    _lastAttemptMs = null;
    _attempting = false;
    _loaded = true;
    _loading = null;
    _now = DateTime.now;
    showAttemptForTesting = null;
  }

  /// Forgets memory so the next action reads SharedPreferences again,
  /// like a fresh app start.
  @visibleForTesting
  void simulateRestartForTesting() {
    _actionCount = 0;
    _pending = false;
    _lastShownMs = null;
    _lastReviewMs = null;
    _lastAttemptMs = null;
    _attempting = false;
    _loaded = false;
    _loading = null;
  }

  bool _isAdFree() =>
      IapService.instance.lastKnownStatus == SubscriptionStatus.pro;

  /// One countable action. While loaded, the count goes up before any
  /// await, so callers and tests see it immediately.
  Future<void> _recordAction() async {
    if (!_loaded) await _ensureLoaded();
    if (!_pending) {
      _actionCount++;
      if (_actionCount >= actionThreshold) {
        _actionCount = 0;
        _pending = true;
      }
    }
    await _persist();
    if (_pending) await _tryShowPending();
  }

  Future<void> _tryShowPending() async {
    if (_attempting) return;
    final now = _now();
    if (!gapElapsed(now, _lastShownMs)) return;
    // The review sheet was shown recently: the ad stays pending.
    if (!gapElapsed(now, _lastReviewMs, reviewProximity)) return;
    if (!gapElapsed(now, _lastAttemptMs, retryAfterFailure)) return;

    _attempting = true;
    try {
      final shown = await (showAttemptForTesting ?? _showIfReady)();
      if (shown) {
        _pending = false;
        _lastAttemptMs = null;
        await _persist();
      } else {
        _lastAttemptMs = _now().millisecondsSinceEpoch;
      }
    } finally {
      _attempting = false;
    }
  }

  // ---- The counting points (owner list, 21 Nov 2026) -----------------

  /// A real save succeeded (editor exit or background, rename, move).
  Future<void> recordNoteSave() => _recordAction();

  /// A new note was started (Home button or inside a notebook).
  Future<void> recordNoteCreate() => _recordAction();

  /// A new notebook was created.
  Future<void> recordNotebookCreate() => _recordAction();

  /// The Edit item of the note menu was chosen.
  Future<void> recordNoteEdit() => _recordAction();

  /// An export finished (the share sheet returned).
  Future<void> showAfterExport() => _recordAction();

  /// Share-as-text finished (the share sheet returned).
  Future<void> recordNoteShare() => _recordAction();

  /// A note was deleted.
  Future<void> recordNoteDelete() => _recordAction();

  /// A notebook was deleted.
  Future<void> showAfterNotebookDelete() => _recordAction();

  /// The user came back from Settings to Home.
  Future<void> recordSettingsReturn() => _recordAction();

  /// The user came back from a notebook screen to Home.
  Future<void> recordNotebookBack() => _recordAction();

  /// A paper style was chosen in the editor.
  Future<void> recordPaperStyleChange() => _recordAction();

  /// Loads and shows one interstitial. Returns true when it was shown.
  Future<bool> _showIfReady() async {
    // Availability first: it is a plain flag, and it keeps the purchase
    // plugin untouched when ads are off (and in unit tests).
    if (!AdMobService.instance.isAvailable) return false;
    if (_isAdFree()) return false;

    try {
      final ad = await AdMobService.instance.loadInterstitial();
      if (ad == null) return false;
      _lastShownMs = _now().millisecondsSinceEpoch;
      await _persist();
      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) => ad.dispose(),
        onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose(),
      );
      await ad.show();
      return true;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Interstitial load/show failed',
        context: 'interstitial_service.showIfReady',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }
}
