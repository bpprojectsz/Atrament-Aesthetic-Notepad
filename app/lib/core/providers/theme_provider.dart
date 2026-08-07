import 'dart:ui' show PlatformDispatcher, Brightness;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Owns the app's theme mode (Light / Dark / Parchment). State lives in a
/// [ValueNotifier] per Section 15 — widgets bind via [ValueListenableBuilder]
/// or [ListenableBuilder], never `setState`.
class ThemeProvider {
  ThemeProvider();

  final ValueNotifier<AppThemeMode> mode = ValueNotifier(AppThemeMode.light);

  bool _initialized = false;

  /// Loads the persisted theme mode, or — on first launch, when nothing is
  /// persisted yet — resolves an initial mode from the system brightness.
  /// "Parchment" mode is never chosen automatically; it's only reachable via
  /// the manual toggle in Settings.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(AppConstants.prefThemeMode);

      if (stored != null) {
        mode.value = _decode(stored);
        return;
      }

      final systemBrightness = PlatformDispatcher.instance.platformBrightness;
      final resolved = systemBrightness == Brightness.dark
          ? AppThemeMode.dark
          : AppThemeMode.light;
      mode.value = resolved;
      await prefs.setString(AppConstants.prefThemeMode, _encode(resolved));
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load theme preference',
        context: 'theme_provider.init',
        severity: ErrorSeverity.warning,
      );
      // Falls back to the default AppThemeMode.light already set above.
    }
  }

  Future<void> setMode(AppThemeMode newMode) async {
    mode.value = newMode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.prefThemeMode, _encode(newMode));
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to persist theme preference',
        context: 'theme_provider.setMode',
        severity: ErrorSeverity.warning,
      );
      // The in-memory value still updated above, so the UI reflects the
      // change for this session even though it won't survive a restart.
    }
  }

  String _encode(AppThemeMode value) => value.name;

  AppThemeMode _decode(String raw) {
    return AppThemeMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => AppThemeMode.light,
    );
  }

  void dispose() {
    mode.dispose();
  }
}
