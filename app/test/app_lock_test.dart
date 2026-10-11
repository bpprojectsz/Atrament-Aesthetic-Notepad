import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/platform/biometric_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_biometrics.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBiometrics bio;
  late DateTime now;

  Future<AppLock> makeLock({required bool lockEnabled}) async {
    SharedPreferences.setMockInitialValues({
      AppConstants.prefBiometricLockEnabled: lockEnabled,
    });
    bio = FakeBiometrics();
    now = DateTime(2026, 1, 1, 12);
    final lock = AppLock(biometrics: bio, clock: () => now);
    await lock.init(observeLifecycle: false);
    return lock;
  }

  Future<bool> savedFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefBiometricLockEnabled) ?? false;
  }

  group('ensureUnlocked', () {
    test('does nothing when the lock is off', () async {
      final lock = await makeLock(lockEnabled: false);

      expect(await lock.ensureUnlocked(reason: 'r'), LockOutcome.granted);
      expect(bio.prompts, 0);
      expect(lock.contentHidden.value, isFalse);
    });

    test('prompts once, then stays unlocked for the session', () async {
      final lock = await makeLock(lockEnabled: true);
      expect(lock.contentHidden.value, isTrue, reason: 'locked on start');

      expect(await lock.ensureUnlocked(reason: 'r'), LockOutcome.granted);
      expect(await lock.ensureUnlocked(reason: 'r'), LockOutcome.granted);

      expect(bio.prompts, 1);
      expect(lock.contentHidden.value, isFalse);
    });

    test('a refused prompt keeps the content hidden', () async {
      final lock = await makeLock(lockEnabled: true);
      bio.script.add(BiometricAuthResult.failed);

      expect(await lock.ensureUnlocked(reason: 'r'), LockOutcome.denied);
      expect(lock.contentHidden.value, isTrue);
      expect(lock.enabled, isTrue, reason: 'a refusal must not disable it');
    });

    test('concurrent requests share a single prompt', () async {
      final lock = await makeLock(lockEnabled: true);

      final results = await Future.wait([
        lock.ensureUnlocked(reason: 'a'),
        lock.ensureUnlocked(reason: 'b'),
      ]);

      expect(results, [LockOutcome.granted, LockOutcome.granted]);
      expect(bio.prompts, 1);
    });

    test('if the device can no longer authenticate, the lock turns itself '
        'off instead of locking the user out', () async {
      final lock = await makeLock(lockEnabled: true);
      bio.script.add(BiometricAuthResult.unavailable);

      expect(
        await lock.ensureUnlocked(reason: 'r'),
        LockOutcome.grantedLockDisabled,
      );

      expect(lock.enabled, isFalse);
      expect(lock.contentHidden.value, isFalse);
      expect(await savedFlag(), isFalse, reason: 'must persist');

      // And it stays off: no further prompts.
      expect(await lock.ensureUnlocked(reason: 'r'), LockOutcome.granted);
      expect(bio.prompts, 1);
    });
  });

  group('re-locking after the app was in the background', () {
    test('stays unlocked for a short absence', () async {
      final lock = await makeLock(lockEnabled: true);
      await lock.ensureUnlocked(reason: 'r');

      lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      now = now.add(AppLock.relockAfter - const Duration(seconds: 1));
      lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(lock.isUnlocked, isTrue);
      expect(lock.contentHidden.value, isFalse);
    });

    test('locks again after the full re-lock delay', () async {
      final lock = await makeLock(lockEnabled: true);
      await lock.ensureUnlocked(reason: 'r');

      lock.didChangeAppLifecycleState(AppLifecycleState.paused);
      now = now.add(AppLock.relockAfter);
      lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(lock.isUnlocked, isFalse);
      expect(lock.contentHidden.value, isTrue);

      await lock.ensureUnlocked(reason: 'r');
      expect(bio.prompts, 2, reason: 'must ask again after re-locking');
    });

    test('inactive/hidden transitions alone never lock', () async {
      final lock = await makeLock(lockEnabled: true);
      await lock.ensureUnlocked(reason: 'r');

      lock.didChangeAppLifecycleState(AppLifecycleState.inactive);
      now = now.add(const Duration(minutes: 10));
      lock.didChangeAppLifecycleState(AppLifecycleState.resumed);

      expect(lock.isUnlocked, isTrue);
    });
  });

  group('changeEnabled (Settings toggle)', () {
    test('turning the lock ON requires a successful authentication', () async {
      final lock = await makeLock(lockEnabled: false);

      bio.script.add(BiometricAuthResult.failed);
      expect(
        await lock.changeEnabled(true, reason: 'r'),
        LockChangeOutcome.denied,
      );
      expect(lock.enabled, isFalse);
      expect(await savedFlag(), isFalse);

      bio.script.add(BiometricAuthResult.success);
      expect(
        await lock.changeEnabled(true, reason: 'r'),
        LockChangeOutcome.changed,
      );
      expect(lock.enabled, isTrue);
      expect(lock.isUnlocked, isTrue,
          reason: 'the user just proved who they are');
      expect(await savedFlag(), isTrue);
    });

    test('cannot be turned ON when the device cannot authenticate', () async {
      final lock = await makeLock(lockEnabled: false);
      bio.script.add(BiometricAuthResult.unavailable);

      expect(
        await lock.changeEnabled(true, reason: 'r'),
        LockChangeOutcome.notSupported,
      );
      expect(lock.enabled, isFalse);
    });

    test('turning the lock OFF requires authentication', () async {
      final lock = await makeLock(lockEnabled: true);

      bio.script.add(BiometricAuthResult.failed);
      expect(
        await lock.changeEnabled(false, reason: 'r'),
        LockChangeOutcome.denied,
      );
      expect(lock.enabled, isTrue,
          reason: 'someone holding an unlocked phone must not remove it');
      expect(await savedFlag(), isTrue);

      bio.script.add(BiometricAuthResult.success);
      expect(
        await lock.changeEnabled(false, reason: 'r'),
        LockChangeOutcome.changed,
      );
      expect(lock.enabled, isFalse);
      expect(await savedFlag(), isFalse);
    });

    test('can always be turned OFF if the device cannot authenticate', () async {
      final lock = await makeLock(lockEnabled: true);
      bio.script.add(BiometricAuthResult.unavailable);

      expect(
        await lock.changeEnabled(false, reason: 'r'),
        LockChangeOutcome.changed,
      );
      expect(lock.enabled, isFalse,
          reason: 'otherwise the lock could never be removed');
    });
  });

  group('BiometricService error mapping', () {
    test('only "nothing set up" errors count as unavailable', () {
      const unavailable = {
        LocalAuthExceptionCode.noCredentialsSet,
        LocalAuthExceptionCode.noBiometricsEnrolled,
        LocalAuthExceptionCode.noBiometricHardware,
      };
      for (final code in LocalAuthExceptionCode.values) {
        expect(
          BiometricService.codeMeansUnavailable(code),
          unavailable.contains(code),
          reason: code.name,
        );
      }
    });
  });
}
