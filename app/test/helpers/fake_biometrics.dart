import 'package:atrament/platform/biometric_service.dart';

/// A BiometricService that answers from a script instead of the OS, and
/// counts how many times the user would have been prompted.
class FakeBiometrics extends BiometricService {
  FakeBiometrics([List<BiometricAuthResult>? script])
    : script = script ?? <BiometricAuthResult>[];

  /// Results returned in order; when empty, [fallback] is used.
  final List<BiometricAuthResult> script;
  BiometricAuthResult fallback = BiometricAuthResult.success;
  bool supported = true;
  int prompts = 0;

  @override
  Future<BiometricAuthResult> authenticate({required String reason}) async {
    prompts++;
    return script.isEmpty ? fallback : script.removeAt(0);
  }

  @override
  Future<bool> isSupported() async => supported;
}
