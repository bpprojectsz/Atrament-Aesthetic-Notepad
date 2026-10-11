import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../platform/biometric_service.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Result of asking to open protected content.
enum LockOutcome {
  /// Lock is off, already unlocked this session, or the user just passed
  /// authentication.
  granted,

  /// The device can no longer authenticate (no screen lock / biometrics),
  /// so the lock was switched off instead of locking the user out. The
  /// content may be opened; callers should tell the user.
  grantedLockDisabled,

  /// The user cancelled or failed authentication.
  denied,
}

/// Result of turning the lock on or off from Settings.
enum LockChangeOutcome { changed, denied, notSupported }

/// App-wide state for the optional note lock.
///
/// * One successful authentication unlocks the whole app session; it
///   locks again after the app has been in the background for
///   [relockAfter], or on a cold start.
/// * Turning the lock on or off always requires authenticating.
/// * If the device can no longer authenticate, the lock switches itself
///   off rather than trapping the user out of their notes.
class AppLock with WidgetsBindingObserver {
  AppLock({BiometricService? biometrics, DateTime Function()? clock})
    : _biometrics = biometrics ?? BiometricService(),
      _now = clock ?? DateTime.now;

  /// Replaceable so tests can inject a fake.
  static AppLock instance = AppLock();

  static const Duration relockAfter = Duration(seconds: 60);

  final BiometricService _biometrics;
  final DateTime Function() _now;

  final ValueNotifier<bool> _contentHidden = ValueNotifier<bool>(false);

  bool _enabled = false;
  bool _unlocked = false;
  DateTime? _backgroundedAt;
  Future<void>? _initFuture;
  Future<LockOutcome>? _inFlightUnlock;

  /// True while the lock is on and the app is not unlocked: list screens
  /// hide note previews.
  ValueListenable<bool> get contentHidden => _contentHidden;

  bool get enabled => _enabled;
  bool get isUnlocked => _unlocked;

  /// Loads the saved setting. Safe to call repeatedly.
  Future<void> init({bool observeLifecycle = true}) =>
      _initFuture ??= _load(observeLifecycle);

  Future<void> _load(bool observeLifecycle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _enabled = prefs.getBool(AppConstants.prefBiometricLockEnabled) ?? false;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load note lock setting',
        context: 'app_lock.load',
        severity: ErrorSeverity.warning,
      );
    }
    _refresh();
    if (observeLifecycle) {
      try {
        WidgetsBinding.instance.addObserver(this);
      } catch (error, stackTrace) {
        ErrorHandler.report(
          error,
          stackTrace,
          message: 'Could not observe app lifecycle for note lock',
          context: 'app_lock.load',
          severity: ErrorSeverity.warning,
        );
      }
    }
  }

  void _refresh() {
    _contentHidden.value = _enabled && !_unlocked;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _backgroundedAt = _now();
    } else if (state == AppLifecycleState.resumed) {
      final since = _backgroundedAt;
      _backgroundedAt = null;
      if (since != null && _now().difference(since) >= relockAfter) {
        lock();
      }
    }
  }

  void lock() {
    _unlocked = false;
    _refresh();
  }

  void markUnlocked() {
    _unlocked = true;
    _refresh();
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    if (!value) _unlocked = false;
    _refresh();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.prefBiometricLockEnabled, value);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to save note lock setting',
        context: 'app_lock.setEnabled',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Authenticates if needed before protected content is shown or leaves
  /// the app (editor, share, export). Concurrent callers share one prompt.
  Future<LockOutcome> ensureUnlocked({required String reason}) {
    return _inFlightUnlock ??= _ensureUnlocked(reason).whenComplete(() {
      _inFlightUnlock = null;
    });
  }

  Future<LockOutcome> _ensureUnlocked(String reason) async {
    await init();
    if (!_enabled || _unlocked) return LockOutcome.granted;

    final result = await _biometrics.authenticate(reason: reason);
    switch (result) {
      case BiometricAuthResult.success:
        markUnlocked();
        return LockOutcome.granted;
      case BiometricAuthResult.unavailable:
        await setEnabled(false);
        return LockOutcome.grantedLockDisabled;
      case BiometricAuthResult.failed:
        return LockOutcome.denied;
    }
  }

  /// Turns the lock on or off. Both directions require authenticating, so
  /// someone holding an unlocked phone can't simply switch the lock off.
  /// The one exception: if the device can no longer authenticate at all,
  /// turning the lock off is allowed (otherwise it could never be removed).
  Future<LockChangeOutcome> changeEnabled(
    bool enable, {
    required String reason,
  }) async {
    await init();
    final result = await _biometrics.authenticate(reason: reason);
    switch (result) {
      case BiometricAuthResult.success:
        await setEnabled(enable);
        if (enable) markUnlocked();
        return LockChangeOutcome.changed;
      case BiometricAuthResult.unavailable:
        if (enable) return LockChangeOutcome.notSupported;
        await setEnabled(false);
        return LockChangeOutcome.changed;
      case BiometricAuthResult.failed:
        return LockChangeOutcome.denied;
    }
  }

  Future<bool> isSupported() => _biometrics.isSupported();
}
