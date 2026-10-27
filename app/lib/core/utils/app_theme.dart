import 'package:flutter/material.dart';

import 'constants.dart';

/// Carries the app's real theme choice (light, dark or parchment) inside
/// [ThemeData].
///
/// Flutter's own `Brightness` only knows light and dark, so Parchment (a
/// light theme with its own warm colors) was indistinguishable from Light to
/// every widget that picked colors from brightness. Widgets read
/// `context.appMode` instead.
class AtramentTheme extends ThemeExtension<AtramentTheme> {
  const AtramentTheme(this.mode);

  final AppThemeMode mode;

  @override
  AtramentTheme copyWith({AppThemeMode? mode}) =>
      AtramentTheme(mode ?? this.mode);

  @override
  AtramentTheme lerp(ThemeExtension<AtramentTheme>? other, double t) {
    if (other is! AtramentTheme) return this;
    return t < 0.5 ? this : other;
  }
}

extension AtramentThemeContext on BuildContext {
  /// The active [AppThemeMode]. Falls back to light/dark from brightness when
  /// the theme does not carry the extension (e.g. a bare test MaterialApp).
  AppThemeMode get appMode {
    final theme = Theme.of(this);
    final extension = theme.extension<AtramentTheme>();
    if (extension != null) return extension.mode;
    return theme.brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
  }
}

/// Builds the app-wide [ThemeData] for [mode].
ThemeData buildAppTheme(AppThemeMode mode) {
  final brightness = mode == AppThemeMode.dark
      ? Brightness.dark
      : Brightness.light;

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bgPrimary.resolve(mode),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent.resolve(mode),
      brightness: brightness,
    ),
    fontFamily: 'Roboto',
    extensions: [AtramentTheme(mode)],
  );
}
