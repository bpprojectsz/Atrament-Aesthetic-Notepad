import 'package:flutter/widgets.dart';

/// Semantic design tokens for Atrament (Section 17 of the blueprint).
///
/// Widget code must never reference raw hex values directly — always go
/// through [AppColors], [AppTypography], [AppSpacing], or [AppRadius] so a
/// theme mode swap is a single source-of-truth change.

enum AppThemeMode { light, dark, parchment }

/// Color tokens. Each field holds the value for all three theme modes so
/// callers can resolve via [AppColors.resolve].
class AppColorToken {
  const AppColorToken({
    required this.light,
    required this.dark,
    required this.parchment,
  });

  final Color light;
  final Color dark;
  final Color parchment;

  Color resolve(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return light;
      case AppThemeMode.dark:
        return dark;
      case AppThemeMode.parchment:
        return parchment;
    }
  }
}

class AppColors {
  const AppColors._();

  static const bgPrimary = AppColorToken(
    light: Color(0xFFF5F1E8),
    dark: Color(0xFF1A1612),
    parchment: Color(0xFFF0E6D2),
  );

  static const bgSecondary = AppColorToken(
    light: Color(0xFFEDE8D8),
    dark: Color(0xFF252018),
    parchment: Color(0xFFE6D9C0),
  );

  static const bgTertiary = AppColorToken(
    light: Color(0xFFE6DCC8),
    dark: Color(0xFF332D24),
    parchment: Color(0xFFDDD0B8),
  );

  static const accent = AppColorToken(
    light: Color(0xFF8B6914),
    dark: Color(0xFFA68B4B),
    parchment: Color(0xFF9A7E4F),
  );

  static const accentDim = AppColorToken(
    light: Color(0xFF6B5010),
    dark: Color(0xFF8A7340),
    parchment: Color(0xFF7A6540),
  );

  static const textPrimary = AppColorToken(
    light: Color(0xFF2C2416),
    dark: Color(0xFFE8DFD0),
    parchment: Color(0xFF3D3020),
  );

  static const textSecondary = AppColorToken(
    light: Color(0xFF5C4F3A),
    dark: Color(0xFFB8AFA0),
    parchment: Color(0xFF6B5B45),
  );

  static const textTertiary = AppColorToken(
    light: Color(0xFF9E8E76),
    dark: Color(0xFF7A7268),
    parchment: Color(0xFF9A8B76),
  );

  static const borderSubtle = AppColorToken(
    light: Color(0xFFD4C9B0),
    dark: Color(0xFF3D352C),
    parchment: Color(0xFFC9B99A),
  );

  static const borderFocus = AppColorToken(
    light: Color(0xFF8B6914),
    dark: Color(0xFFA68B4B),
    parchment: Color(0xFF9A7E4F),
  );

  static const error = AppColorToken(
    light: Color(0xFFB54242),
    dark: Color(0xFFD66A6A),
    parchment: Color(0xFFB54242),
  );

  static const success = AppColorToken(
    light: Color(0xFF4A7C59),
    dark: Color(0xFF6BA87A),
    parchment: Color(0xFF4A7C59),
  );

  static const warning = AppColorToken(
    light: Color(0xFFC78D3D),
    dark: Color(0xFFD9A55C),
    parchment: Color(0xFFC78D3D),
  );
}

/// Typography scale (Section 17). Sizes/weights/line-heights only — font
/// family is resolved by callers (system font for UI, Merriweather for
/// scripture elements per the design system rule).
class AppTextStyleToken {
  const AppTextStyleToken({
    required this.size,
    required this.weight,
    required this.height,
  });

  final double size;
  final FontWeight weight;
  final double height;
}

class AppTypography {
  const AppTypography._();

  static const display = AppTextStyleToken(
    size: 34,
    weight: FontWeight.w700,
    height: 1.1,
  );

  static const headline = AppTextStyleToken(
    size: 28,
    weight: FontWeight.w600,
    height: 1.2,
  );

  static const title1 = AppTextStyleToken(
    size: 22,
    weight: FontWeight.w600,
    height: 1.3,
  );

  static const title2 = AppTextStyleToken(
    size: 17,
    weight: FontWeight.w600,
    height: 1.3,
  );

  static const body = AppTextStyleToken(
    size: 17,
    weight: FontWeight.w400,
    height: 1.5,
  );

  static const callout = AppTextStyleToken(
    size: 16,
    weight: FontWeight.w500,
    height: 1.4,
  );

  static const footnote = AppTextStyleToken(
    size: 13,
    weight: FontWeight.w400,
    height: 1.4,
  );

  static const caption = AppTextStyleToken(
    size: 12,
    weight: FontWeight.w400,
    height: 1.3,
  );
}

/// Spacing scale on a 4px base grid.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

/// Shape / radius tokens.
class AppRadius {
  const AppRadius._();

  static const double card = 16;
  static const double button = 12;
  static const double bottomSheetTop = 20;
  static const double dialog = 16;
  static const double textInput = 12;
}

/// Elevation / border tokens.
class AppElevation {
  const AppElevation._();

  static const double cardBorderWidth = 0.5;
  static const double minTouchTarget = 48;
}

/// Animation durations and curves (Section 17).
class AppMotion {
  const AppMotion._();

  static const Duration screenPush = Duration(milliseconds: 350);
  static const Duration screenPop = Duration(milliseconds: 280);
  static const Duration sheetPresent = Duration(milliseconds: 400);
  static const Duration buttonPress = Duration(milliseconds: 150);
  static const Duration saveSuccess = Duration(milliseconds: 300);
  static const Duration themeToggle = Duration(milliseconds: 200);
  static const Duration reduceMotion = Duration.zero;

  static const Curve screenPushCurve = Curves.easeInOut;
  static const Curve screenPopCurve = Curves.easeInOut;
  static const Curve sheetPresentCurve = Curves.easeOut;
  static const Curve buttonPressCurve = Curves.easeOut;
  static const Curve saveSuccessCurve = Curves.easeOut;
  static const Curve themeToggleCurve = Curves.linear;

  static const double buttonPressScale = 0.97;
  static const double screenPushSlideOffsetPx = 20;

  /// Returns [Duration.zero] when the platform has Reduce Motion enabled,
  /// otherwise returns [duration]. Callers pass the result of
  /// `MediaQuery.disableAnimationsOf(context)`.
  static Duration resolve(Duration duration, {required bool reduceMotion}) {
    return reduceMotion ? AppMotion.reduceMotion : duration;
  }
}

/// Non-localized, structural app strings (identifiers, keys, URLs). Every
/// user-facing string lives in the ARB files instead — see lib/l10n/.
class AppConstants {
  const AppConstants._();

  static const String appName = 'Atrament';

  // SharedPreferences keys
  static const String prefThemeMode = 'pref_theme_mode';
  static const String prefPaperStyleDefault = 'pref_paper_style_default';
  static const String prefFontChoice = 'pref_font_choice';
  static const String prefVerseDisplayMode = 'pref_verse_display_mode';
  static const String prefScriptureFontScale = 'pref_scripture_font_scale';
  static const String prefNotificationsEnabled = 'pref_notifications_enabled';
  static const String prefReminderHour = 'pref_reminder_hour';
  static const String prefReminderMinute = 'pref_reminder_minute';
  static const String prefBiometricLockEnabled = 'pref_biometric_lock_enabled';
  static const String prefHasSeenOnboarding = 'pref_has_seen_onboarding';

  // SQLite
  static const String dbName = 'atrament.db';
  static const int dbVersion = 1;
  static const String tableNotes = 'notes';
  static const String tableNotebooks = 'notebooks';
  static const String tableNotesFts = 'notes_fts';

  // Asset paths
  static const String dailyVersesAssetPath = 'assets/json/daily_verses.json';
  static const String kjvAssetPath = 'assets/json/kjv.json';

  // In-app purchase product IDs.
  // REPLACE: confirm these match App Store Connect / Play Console exactly
  // before submission (see Section 1a of the blueprint).
  static const String iapMonthlyProductId =
      'com.[youraccount].atrament.pro.monthly';
  static const String iapYearlyProductId =
      'com.[youraccount].atrament.pro.yearly';

  // External URLs
  static const String privacyPolicyUrl = 'https://atrament.app/privacy.html';
  static const String supportUrl = 'https://atrament.app/support.html';

  // Notification
  static const int dailyVerseNotificationId = 1001;
  static const String dailyVerseNotificationChannelId = 'daily_verse_channel';
}
