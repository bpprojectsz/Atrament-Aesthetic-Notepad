import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import '../core/utils/error_handler.dart';

/// Outcome of a biometric authentication attempt, surfaced by the caller
/// (note_editor_screen's lock overlay) for explicit UI feedback.
enum BiometricAuthResult {
  success,

  /// Device has no biometric hardware enrolled, or the OS reported it as
  /// unavailable — the caller should offer to disable the lock setting.
  unavailable,

  /// User cancelled or failed the prompt.
  failed,
}

/// Wraps `local_auth` for gating note-editor access behind Face ID /
/// fingerprint. This is the only file that imports `local_auth` directly.
class BiometricService {
  BiometricService();

  final LocalAuthentication _auth = LocalAuthentication();

  /// Whether the device can authenticate the user at all: a biometric OR a
  /// screen-lock PIN / pattern / passcode. (Requiring enrolled biometrics
  /// would wrongly reject PIN-only devices, which [authenticate] fully
  /// supports through its device-credential fallback.)
  Future<bool> isSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Biometric support check failed',
        context: 'biometric_service.isSupported',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }

  /// Errors that mean authentication cannot work on this device right now
  /// or ever (nothing set up), as opposed to the user cancelling or a
  /// temporary lockout.
  @visibleForTesting
  static bool codeMeansUnavailable(LocalAuthExceptionCode code) =>
      code == LocalAuthExceptionCode.noCredentialsSet ||
      code == LocalAuthExceptionCode.noBiometricsEnrolled ||
      code == LocalAuthExceptionCode.noBiometricHardware;

  /// Prompts the user to authenticate. [reason] is the localized string
  /// shown in the system prompt (and, on iOS, must match the
  /// `NSFaceIDUsageDescription` intent in Info.plist).
  Future<BiometricAuthResult> authenticate({required String reason}) async {
    try {
      final supported = await isSupported();
      if (!supported) return BiometricAuthResult.unavailable;

      final didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: false, // Allow device PIN/passcode as fallback.
        persistAcrossBackgrounding: true,
      );
      return didAuthenticate
          ? BiometricAuthResult.success
          : BiometricAuthResult.failed;
    } on LocalAuthException catch (error, stackTrace) {
      if (codeMeansUnavailable(error.code)) {
        return BiometricAuthResult.unavailable;
      }
      final userChoice = error.code == LocalAuthExceptionCode.userCanceled ||
          error.code == LocalAuthExceptionCode.systemCanceled ||
          error.code == LocalAuthExceptionCode.userRequestedFallback;
      if (!userChoice) {
        ErrorHandler.report(
          error,
          stackTrace,
          message: 'Biometric authentication failed (${error.code.name})',
          context: 'biometric_service.authenticate',
          severity: ErrorSeverity.warning,
        );
      }
      return BiometricAuthResult.failed;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Biometric authentication threw',
        context: 'biometric_service.authenticate',
        severity: ErrorSeverity.warning,
      );
      return BiometricAuthResult.failed;
    }
  }
}
