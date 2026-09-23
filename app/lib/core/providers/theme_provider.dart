import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Owns the app's theme preference ([ThemePreference]) and the resolved
/// [AppThemeMode] derived from it. State lives in [ValueNotifier]s per
/// Section 15 — widgets bind via [ValueListenableBuilder] or
/// [ListenableBuilder], never `setState`.
///
/// Two notifiers:
///
/// - [preference] — what the user picked. Persisted across launches.
/// - [mode] — what the UI actually renders in. Derived from [preference]
///   and, when the preference is [ThemePreference.system], the current
///   device brightness. Never persisted; recomputed on init and on every
///   system brightness change.
class ThemeProvider {
  ThemeProvider();

  final ValueNotifier<ThemePreference> preference =
      ValueNotifier<ThemePreference>(ThemePreference.system);

  final ValueNotifier<AppThemeMode> mode =
      ValueNotifier<AppThemeMode>(AppThemeMode.light);

  bool _initialized = false;

  /// Loads the persisted preference and resolves [mode] from it. On a
  /// fresh install, defaults to [ThemePreference.system] and writes that
  /// sentinel — so subsequent launches remember "follow the device".
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(AppConstants.prefThemeMode);

      if (stored != null) {
        preference.value = _decodePreference(stored);
      } else {
        preference.value = ThemePreference.system;
      }

      _recomputeMode();
      await prefs.setString(
        AppConstants.prefThemeMode,
        _encodePreference(preference.value),
      );
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load theme preference',
        context: 'theme_provider.init',
        severity: ErrorSeverity.warning,
      );
      // Falls back to defaults set at construction: system preference,
      // light mode. A brightness change will not fix this until next
      // launch, but the app runs.
      _recomputeMode();
    }
  }

  /// Persists the user's choice and re-resolves [mode] from it.
  Future<void> setPreference(ThemePreference newPreference) async {
    preference.value = newPreference;
    _recomputeMode();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        AppConstants.prefThemeMode,
        _encodePreference(newPreference),
      );
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to persist theme preference',
        context: 'theme_provider.setPreference',
        severity: ErrorSeverity.warning,
      );
      // In-memory value still updated above; the UI reflects the change
      // for this session even though it won't survive a restart.
    }
  }

  /// Called from the app's [WidgetsBindingObserver] when the device
  /// brightness changes. No-op unless the preference is
  /// [ThemePreference.system].
  void onSystemBrightnessChanged(Brightness brightness) {
    if (preference.value != ThemePreference.system) return;
    final resolved = brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    if (mode.value != resolved) {
      mode.value = resolved;
    }
  }

  void _recomputeMode() {
    switch (preference.value) {
      case ThemePreference.system:
        final brightness = PlatformDispatcher.instance.platformBrightness;
        mode.value = brightness == Brightness.dark
            ? AppThemeMode.dark
            : AppThemeMode.light;
        break;
      case ThemePreference.light:
        mode.value = AppThemeMode.light;
        break;
      case ThemePreference.dark:
        mode.value = AppThemeMode.dark;
        break;
      case ThemePreference.parchment:
        mode.value = AppThemeMode.parchment;
        break;
    }
  }

  String _encodePreference(ThemePreference value) => value.name;

  ThemePreference _decodePreference(String raw) {
    // Legacy migration: the previous version persisted resolved modes
    // ("light", "dark", "parchment") under the same key. Those strings
    // are valid ThemePreference values too, so old installs decode
    // correctly and lose no user choice.
    return ThemePreference.values.firstWhere(
      (p) => p.name == raw,
      orElse: () => ThemePreference.system,
    );
  }

  void dispose() {
    preference.dispose();
    mode.dispose();
  }
}
