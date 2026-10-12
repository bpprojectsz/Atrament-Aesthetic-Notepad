import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/utils/error_handler.dart';

/// Google's User Messaging Platform (UMP) consent flow. Required for
/// serving ads to users in the EEA / UK: ads must not be requested until
/// the user has made a choice (or none is required where they are).
///
/// Every call degrades safely: any failure is reported and treated as
/// "cannot request ads", so no ad is ever requested without a clear
/// go-ahead. The consent message itself is configured in the AdMob
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

  /// Updates consent info and shows the consent form if one is required.
  /// Returns whether ads may now be requested. Never throws.
  Future<bool> gatherConsent() async {
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
    return refreshState();
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

  /// Reads the current consent state without showing anything.
  Future<bool> refreshState() async {
    var canRequestAds = false;
    try {
      canRequestAds = await ConsentInformation.instance.canRequestAds();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read ad consent state',
        context: 'consent_service.refreshState',
        severity: ErrorSeverity.warning,
      );
    }
    try {
      final status = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus();
      privacyOptionsRequired.value =
          status == PrivacyOptionsRequirementStatus.required;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read privacy options status',
        context: 'consent_service.refreshState',
        severity: ErrorSeverity.warning,
      );
    }
    return canRequestAds;
  }

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
