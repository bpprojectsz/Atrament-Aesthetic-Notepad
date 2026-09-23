import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Owns the user's manual language selection. A null [preference] means
/// "follow the device locale" — Flutter's default behaviour when
/// [MaterialApp.locale] is null. A non-null value overrides the system
/// locale and survives restarts.
class LocaleProvider {
  LocaleProvider();

  /// null = follow system. Non-null = override persisted by the user.
  final ValueNotifier<Locale?> preference = ValueNotifier<Locale?>(null);

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(AppConstants.prefLocale);
      if (code != null && code.isNotEmpty) {
        preference.value = Locale(code);
      }
      // else: leave null; Flutter resolves from the device locale.
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load locale preference',
        context: 'locale_provider.init',
        severity: ErrorSeverity.warning,
      );
    }
  }

  Future<void> setLocale(Locale? locale) async {
    preference.value = locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (locale == null) {
        await prefs.remove(AppConstants.prefLocale);
      } else {
        await prefs.setString(AppConstants.prefLocale, locale.languageCode);
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to persist locale preference',
        context: 'locale_provider.setLocale',
        severity: ErrorSeverity.warning,
      );
    }
  }

  void dispose() {
    preference.dispose();
  }
}
