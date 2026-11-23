import 'dart:io' show Platform;

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../platform/interstitial_service.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Owns all engagement gating: review prompt, share-app prompt, ATT
/// request. Every decision is a pure predicate over counters and
/// timestamps stored in SharedPreferences. Callers report events
/// ("note saved", "export completed"); the service decides whether a
/// prompt is due and fires it once.
///
/// Thresholds (locked in the audit that preceded this file):
///   - Review: 20 successful note saves on at least 3 distinct days of use
///     (a day counts when it had one successful save), then no sooner than
///     60 days after our last attempt. Never on the same save as an
///     interstitial ad, and never within 10 minutes of one (see
///     [InterstitialService.claimReviewSlot]). The OS also applies its own
///     quota (iOS: 3 per 365 days) and may show nothing.
///   - Share: 10 successful exports, 30-day cooldown.
///   - ATT: iOS only, fired once per install after the first successful
///     note save — never on first frame, never before user value.
class EngagementService {
  EngagementService._internal()
      : _reviewAvailable = null,
        _requestReview = null,
        _now = DateTime.now;

  /// Replaceable so tests can substitute a fake.
  static EngagementService instance = EngagementService._internal();

  /// For tests: the review sheet and the clock can be replaced.
  @visibleForTesting
  EngagementService.forTesting({
    Future<bool> Function()? reviewAvailable,
    Future<void> Function()? requestReview,
    DateTime Function()? clock,
  })  : _reviewAvailable = reviewAvailable,
        _requestReview = requestReview,
        _now = clock ?? DateTime.now;

  final Future<bool> Function()? _reviewAvailable;
  final Future<void> Function()? _requestReview;
  final DateTime Function() _now;

  static const int _reviewMinSaves = 20;
  static const int _shareMinExports = 10;
  static const int _reviewMinDays = 3;
  static const Duration _reviewCooldown = Duration(days: 60);
  static const Duration _shareCooldown = Duration(days: 30);

  final InAppReview _review = InAppReview.instance;

  bool _installDateChecked = false;

  /// Pure rule: is the review sheet due? [daysWithSaves] counts distinct
  /// local days that had a successful save (only needs to reach 3).
  /// [lastPromptMs] is our last attempt; a time in the future (the clock
  /// moved back) does not block for good.
  @visibleForTesting
  static bool reviewDue({
    required int saveCount,
    required int daysWithSaves,
    required DateTime now,
    required int? lastPromptMs,
  }) {
    if (saveCount < _reviewMinSaves) return false;
    if (daysWithSaves < _reviewMinDays) return false;
    if (lastPromptMs == null || lastPromptMs == 0) return true;
    final since = now.millisecondsSinceEpoch - lastPromptMs;
    if (since < 0) return true;
    return since >= _reviewCooldown.inMilliseconds;
  }

  /// Adds today to the saved set of days with a successful save. Three
  /// days are enough for the rule, so the set stops growing at three.
  /// Returns the number of days now stored.
  Future<int> _recordDayOfUse(SharedPreferences prefs) async {
    final days = prefs.getStringList(AppConstants.prefSaveDays) ?? <String>[];
    if (days.length >= _reviewMinDays) return days.length;
    final now = _now();
    final key = '${now.year}-${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
    if (days.contains(key)) return days.length;
    final updated = [...days, key];
    await prefs.setStringList(AppConstants.prefSaveDays, updated);
    return updated.length;
  }

  // -----------------------------------------------------------------
  // Install-date stamping — call once at startup.
  // -----------------------------------------------------------------
  Future<void> ensureInstallDate() async {
    if (_installDateChecked) return;
    _installDateChecked = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(AppConstants.prefInstallDate)) {
        await prefs.setInt(
          AppConstants.prefInstallDate,
          DateTime.now().millisecondsSinceEpoch,
        );
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to stamp install date',
        context: 'engagement_service.ensureInstallDate',
        severity: ErrorSeverity.warning,
      );
    }
  }

  // -----------------------------------------------------------------
  // Event report + maybe prompt.
  // -----------------------------------------------------------------

  /// Call after a note save succeeds. Increments the save counter and
  /// fires the review prompt if the thresholds are met.
  Future<void> recordNoteSave() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final count = (prefs.getInt(AppConstants.prefNoteSaveCount) ?? 0) + 1;
      await prefs.setInt(AppConstants.prefNoteSaveCount, count);
      final days = await _recordDayOfUse(prefs);
      await _maybePromptReview(prefs, count, days);
      await _maybeRequestAtt(prefs);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to record note save for engagement',
        context: 'engagement_service.recordNoteSave',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Call after a successful export + share hand-off. Increments the
  /// export counter and fires the share-app prompt if the thresholds
  /// are met.
  Future<void> recordExport() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final count = (prefs.getInt(AppConstants.prefExportCount) ?? 0) + 1;
      await prefs.setInt(AppConstants.prefExportCount, count);
      await _maybePromptShare(prefs, count);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to record export for engagement',
        context: 'engagement_service.recordExport',
        severity: ErrorSeverity.warning,
      );
    }
  }

  // -----------------------------------------------------------------
  // Predicates and firing.
  // -----------------------------------------------------------------

  Future<void> _maybePromptReview(
    SharedPreferences prefs,
    int count,
    int days,
  ) async {
    final now = _now();
    if (!reviewDue(
      saveCount: count,
      daysWithSaves: days,
      now: now,
      lastPromptMs: prefs.getInt(AppConstants.prefLastReviewPrompt),
    )) {
      return;
    }

    // Use the native in-app review sheet. It keeps the user inside the app
    // (Apple does not allow custom prompts that send people to the store),
    // and the OS applies its own quota, so it may legitimately show
    // nothing. We still record the attempt so we don't ask again soon.
    final available = await (_reviewAvailable ?? _review.isAvailable)();
    if (available) {
      // Not near an interstitial: if an ad is loading or showing, or was
      // shown in the last 10 minutes, the prompt waits for a later save
      // (nothing is recorded, so the next qualifying save asks again).
      if (!await InterstitialService.instance.claimReviewSlot()) return;
      await (_requestReview ?? _review.requestReview)();
    }
    await prefs.setInt(
      AppConstants.prefLastReviewPrompt,
      _now().millisecondsSinceEpoch,
    );
  }

  Future<void> _maybePromptShare(SharedPreferences prefs, int count) async {
    if (count < _shareMinExports) return;

    final lastMs = prefs.getInt(AppConstants.prefLastSharePrompt) ?? 0;
    if (lastMs != 0) {
      final sinceLast = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(lastMs),
      );
      if (sinceLast < _shareCooldown) return;
    }

    // The share sheet itself is triggered from Settings via the
    // "Share Atrament" ListTile. This hook only records that the
    // threshold was crossed; the UI layer decides whether to surface
    // a contextual card. No system dialog here.
    await prefs.setInt(
      AppConstants.prefLastSharePrompt,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // -----------------------------------------------------------------
  // ATT (iOS only).
  // -----------------------------------------------------------------

  Future<void> _maybeRequestAtt(SharedPreferences prefs) async {
    if (!Platform.isIOS) return;
    final already = prefs.getBool(AppConstants.prefAttRequested) ?? false;
    if (already) return;

    try {
      final status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status != TrackingStatus.notDetermined) {
        await prefs.setBool(AppConstants.prefAttRequested, true);
        return;
      }
      await AppTrackingTransparency.requestTrackingAuthorization();
      await prefs.setBool(AppConstants.prefAttRequested, true);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'ATT request failed',
        context: 'engagement_service.maybeRequestAtt',
        severity: ErrorSeverity.warning,
      );
    }
  }

  // -----------------------------------------------------------------
  // Explicit user-initiated paths (Settings rows).
  // -----------------------------------------------------------------

  /// Called by the "Rate Atrament" row in Settings. Bypasses thresholds.
  /// The numeric App Store ID inside [AppConstants.appStoreUrl], or null
  /// while it is still the all-zero placeholder. Filling in the real ID in
  /// that one constant makes both the Share link and the Rate row work on
  /// iOS.
  @visibleForTesting
  static String? appStoreIdFromUrl(String url) {
    final match = RegExp(r'/id(\d+)').firstMatch(url);
    final id = match?.group(1);
    if (id == null || RegExp(r'^0+$').hasMatch(id)) return null;
    return id;
  }

  /// Opens the store page for rating. Returns false (never throws) when it
  /// could not be opened, so the caller can tell the user.
  Future<bool> openStoreListingForReview() async {
    try {
      if (!await _review.isAvailable()) return false;
      await _review.openStoreListing(
        appStoreId: appStoreIdFromUrl(AppConstants.appStoreUrl),
      );
      return true;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not open the store listing',
        context: 'engagement_service.openStoreListingForReview',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }
}
