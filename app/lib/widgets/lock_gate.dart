import 'package:flutter/material.dart';

import '../core/services/app_lock.dart';
import '../l10n/generated/app_localizations.dart';

/// Asks the user to unlock before a note leaves the app (share / export).
/// Returns true when it is fine to continue. Shows the explanation itself
/// when the user is refused or the lock had to be switched off.
Future<bool> requireUnlock(BuildContext context, {required String reason}) async {
  // Captured before the first await so no context is used afterwards.
  final l10n = AppLocalizations.of(context)!;
  final messenger = ScaffoldMessenger.of(context);

  final outcome = await AppLock.instance.ensureUnlocked(reason: reason);
  switch (outcome) {
    case LockOutcome.granted:
      return true;
    case LockOutcome.grantedLockDisabled:
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.noteLockTurnedOffMessage)),
      );
      return true;
    case LockOutcome.denied:
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.biometricAuthFailedMessage)),
      );
      return false;
  }
}
