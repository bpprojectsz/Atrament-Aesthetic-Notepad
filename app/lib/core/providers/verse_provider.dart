import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/verse_model.dart';
import '../services/verse_service.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';

enum VerseDisplayMode { watermark, header, footer, off }

/// Owns the daily verse and its display preferences. Talks to
/// [VerseService] for data and `SharedPreferences` for persisted settings
/// — no widget touches either directly.
class VerseProvider {
  VerseProvider({VerseService? verseService})
    : _verseService = verseService ?? VerseService.instance;

  final VerseService _verseService;

  final ValueNotifier<VerseModel?> todaysVerse = ValueNotifier(null);
  final ValueNotifier<VerseDisplayMode> displayMode = ValueNotifier(
    VerseDisplayMode.watermark,
  );

  /// Multiplier applied to `AppTypography.callout` for scripture text,
  /// independent of system Dynamic Type scaling. Range: 0.8-1.6.
  final ValueNotifier<double> scriptureFontScale = ValueNotifier(1.0);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await _loadPreferences();
    await refreshTodaysVerse();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final storedMode = prefs.getString(AppConstants.prefVerseDisplayMode);
      if (storedMode != null) {
        displayMode.value = VerseDisplayMode.values.firstWhere(
          (m) => m.name == storedMode,
          orElse: () => VerseDisplayMode.watermark,
        );
      }

      final storedScale = prefs.getDouble(
        AppConstants.prefScriptureFontScale,
      );
      if (storedScale != null) {
        scriptureFontScale.value = storedScale.clamp(0.8, 1.6).toDouble();
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load verse display preferences',
        context: 'verse_provider.loadPreferences',
        severity: ErrorSeverity.warning,
      );
      // Falls back to the defaults already set on the notifiers above.
    }
  }

  Future<void> refreshTodaysVerse() async {
    isLoading.value = true;
    todaysVerse.value = await _verseService.todaysVerse();
    isLoading.value = false;
  }

  Future<void> setDisplayMode(VerseDisplayMode mode) async {
    displayMode.value = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.prefVerseDisplayMode, mode.name);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to persist verse display mode',
        context: 'verse_provider.setDisplayMode',
        severity: ErrorSeverity.warning,
      );
    }
  }

  Future<void> setScriptureFontScale(double scale) async {
    final clamped = scale.clamp(0.8, 1.6).toDouble();
    scriptureFontScale.value = clamped;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(AppConstants.prefScriptureFontScale, clamped);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to persist scripture font scale',
        context: 'verse_provider.setScriptureFontScale',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Looks up a specific reference against the full KJV, e.g. when a user
  /// taps a verse reference to read it in context. Independent of the
  /// daily rotation.
  Future<String?> lookupReference(String reference) {
    return _verseService.lookupByReference(reference);
  }

  void dispose() {
    todaysVerse.dispose();
    displayMode.dispose();
    scriptureFontScale.dispose();
    isLoading.dispose();
  }
}
