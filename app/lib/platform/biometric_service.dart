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

  /// Whether the device supports and has biometrics enrolled. Used to
  /// decide whether to show the "Lock with Face ID" toggle in Settings at
  /// all.
  Future<bool> isSupported() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      return canCheck && isDeviceSupported;
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

  /// Prompts the user to authenticate. [reason] is the localized string
  /// shown in the system prompt (and, on iOS, must match the
  /// `NSFaceIDUsageDescription` intent in Info.plist).
  Future<BiometricAuthResult> authenticate({required String reason}) async {
    try {
      final supported = await isSupported();
      if (!supported) return BiometricAuthResult.unavailable;

      final didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false, // Allow device PIN/passcode as fallback.
          stickyAuth: true,
        ),
      );
      return didAuthenticate
          ? BiometricAuthResult.success
          : BiometricAuthResult.failed;
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
