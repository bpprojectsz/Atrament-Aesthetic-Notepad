import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/utils/error_handler.dart';

/// What to do after asking Google about consent.
@immutable
class ConsentOutcome {
  const ConsentOutcome({
    required this.requestAds,
    required this.retryOnForeground,
    required this.showPrivacyChoices,
  });

  /// Whether ads may be requested now.
  final bool requestAds;

  /// Whether to ask Google once more the next time the app returns to the
  /// foreground (only after an error reading Google's answer).
  final bool retryOnForeground;

  /// Whether Settings should show the "Privacy choices" row.
  final bool showPrivacyChoices;

  @override
  bool operator ==(Object other) =>
      other is ConsentOutcome &&
      other.requestAds == requestAds &&
      other.retryOnForeground == retryOnForeground &&
      other.showPrivacyChoices == showPrivacyChoices;

  @override
  int get hashCode =>
      Object.hash(requestAds, retryOnForeground, showPrivacyChoices);

  @override
  String toString() => 'ConsentOutcome(requestAds: $requestAds, '
      'retryOnForeground: $retryOnForeground, '
      'showPrivacyChoices: $showPrivacyChoices)';
}

/// The one place that decides what a consent answer means (decision D-071).
///
/// - [canRequestAds] true: request ads.
/// - [canRequestAds] false (including a user who declined): do not request.
///   Google's answer is followed as given, and it is never retried.
/// - [canRequestAds] null, meaning reading Google's answer failed or timed
///   out: request ads, and ask again once at the next foreground. After a
///   retry ([isRetry]) that fails again, ads stay allowed and there is no
///   further retry.
///
/// A failed consent-info update or form is not an input here: the caller
/// still reads Google's saved answer afterwards and passes that in.
///
/// [privacyOptionsRequired] null (unreadable) keeps the row as it was
/// ([previousShowPrivacyChoices]).
ConsentOutcome consentOutcome({
  required bool? canRequestAds,
  required bool? privacyOptionsRequired,
  bool previousShowPrivacyChoices = false,
  bool isRetry = false,
}) {
  return ConsentOutcome(
    requestAds: canRequestAds ?? true,
    retryOnForeground: canRequestAds == null && !isRetry,
    showPrivacyChoices: privacyOptionsRequired ?? previousShowPrivacyChoices,
  );
}

/// Google's User Messaging Platform (UMP) consent flow. Ads for users in
/// the EEA / UK are requested only according to Google's own answer (see
/// [consentOutcome]); a user who declines gets whatever Google allows.
///
/// If Google's answer cannot be read at all (an error or a timeout), ads
/// are allowed and the question is asked once more when the app returns to
/// the foreground. The consent message itself is configured in the AdMob
/// console; until one is published (and real AdMob IDs are used) the form
/// simply never appears.
class ConsentService {
  ConsentService._internal();

  /// Replaceable for tests.
  static ConsentService instance = ConsentService._internal();

  @visibleForTesting
  ConsentService.forTesting();

  /// True when the user must be offered a way to change their consent
  /// later (a "Privacy choices" entry in Settings).
  final ValueNotifier<bool> privacyOptionsRequired = ValueNotifier<bool>(false);

  static const Duration _infoUpdateTimeout = Duration(seconds: 15);
  static const Duration _readTimeout = Duration(seconds: 10);

  bool _retryPending = false;

  /// True while one foreground retry is still owed.
  @visibleForTesting
  bool get retryPending => _retryPending;

  /// Updates consent info and shows the consent form if one is required.
  /// Returns whether ads may now be requested. Never throws.
  Future<bool> gatherConsent() async =>
      (await _gather(isRetry: false)).requestAds;

  /// Asks Google once more, but only if an earlier read failed. Returns
  /// null when nothing was owed, otherwise whether ads may be requested.
  /// Owed at most once: the flag is cleared before asking.
  Future<bool?> retryIfNeeded() async {
    if (!_retryPending) return null;
    _retryPending = false;
    return (await _gather(isRetry: true)).requestAds;
  }

  Future<ConsentOutcome> _gather({required bool isRetry}) async {
    try {
      await _updateConsentInfo();
      await ConsentForm.loadAndShowConsentFormIfRequired((FormError? error) {
        if (error != null) _report(error, 'Consent form dismissed with error');
      });
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Consent flow failed',
        context: 'consent_service.gatherConsent',
        severity: ErrorSeverity.warning,
      );
    }
    return _evaluate(isRetry: isRetry);
  }

  Future<void> _updateConsentInfo() {
    final completer = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () {
        if (!completer.isCompleted) completer.complete();
      },
      (FormError error) {
        _report(error, 'Consent info update failed');
        if (!completer.isCompleted) completer.complete();
      },
    );
    return completer.future.timeout(_infoUpdateTimeout, onTimeout: () {});
  }

  /// Reads Google's saved answer (even after a failed update or form) and
  /// turns it into an outcome with [consentOutcome].
  Future<ConsentOutcome> _evaluate({required bool isRetry}) async {
    bool? canRequestAds;
    try {
      canRequestAds =
          await ConsentInformation.instance.canRequestAds().timeout(_readTimeout);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read ad consent state',
        context: 'consent_service.refreshState',
        severity: ErrorSeverity.warning,
      );
    }
    bool? privacyRequired;
    try {
      final status = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus()
          .timeout(_readTimeout);
      privacyRequired = status == PrivacyOptionsRequirementStatus.required;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read privacy options status',
        context: 'consent_service.refreshState',
        severity: ErrorSeverity.warning,
      );
    }
    final outcome = consentOutcome(
      canRequestAds: canRequestAds,
      privacyOptionsRequired: privacyRequired,
      previousShowPrivacyChoices: privacyOptionsRequired.value,
      isRetry: isRetry,
    );
    privacyOptionsRequired.value = outcome.showPrivacyChoices;
    _retryPending = outcome.retryOnForeground;
    return outcome;
  }

  /// Reads the current consent state without showing anything.
  Future<bool> refreshState() async =>
      (await _evaluate(isRetry: false)).requestAds;

  /// Shows the "Privacy choices" form. Returns whether ads may be
  /// requested afterwards.
  Future<bool> showPrivacyOptions() async {
    try {
      await ConsentForm.showPrivacyOptionsForm((FormError? error) {
        if (error != null) _report(error, 'Privacy options form error');
      });
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Privacy options form failed',
        context: 'consent_service.showPrivacyOptions',
        severity: ErrorSeverity.warning,
      );
    }
    return refreshState();
  }

  void _report(FormError error, String message) {
    ErrorHandler.report(
      Exception('${error.errorCode}: ${error.message}'),
      StackTrace.current,
      message: message,
      context: 'consent_service',
      severity: ErrorSeverity.warning,
    );
  }
}
