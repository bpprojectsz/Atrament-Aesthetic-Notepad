import 'dart:ui';

import 'package:atrament/core/providers/locale_provider.dart';
import 'package:atrament/core/providers/theme_provider.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeProvider', () {
    test('follows the device until the user picks a theme', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();
      await provider.init();

      expect(provider.preference.value, ThemePreference.system);

      provider.onSystemBrightnessChanged(Brightness.dark);
      expect(provider.mode.value, AppThemeMode.dark);
      provider.onSystemBrightnessChanged(Brightness.light);
      expect(provider.mode.value, AppThemeMode.light);
      provider.dispose();
    });

    test('each explicit choice gives its own mode, including Parchment', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();
      await provider.init();

      await provider.setPreference(ThemePreference.dark);
      expect(provider.mode.value, AppThemeMode.dark);
      await provider.setPreference(ThemePreference.light);
      expect(provider.mode.value, AppThemeMode.light);
      await provider.setPreference(ThemePreference.parchment);
      expect(provider.mode.value, AppThemeMode.parchment);
      provider.dispose();
    });

    test('a device brightness change is ignored once a theme is chosen', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();
      await provider.init();
      await provider.setPreference(ThemePreference.parchment);

      provider.onSystemBrightnessChanged(Brightness.dark);

      expect(provider.mode.value, AppThemeMode.parchment);
      provider.dispose();
    });

    test('the choice survives a restart', () async {
      SharedPreferences.setMockInitialValues({});
      final first = ThemeProvider();
      await first.init();
      await first.setPreference(ThemePreference.parchment);
      first.dispose();

      final second = ThemeProvider();
      await second.init();

      expect(second.preference.value, ThemePreference.parchment);
      expect(second.mode.value, AppThemeMode.parchment);
      second.dispose();
    });

    test('a saved dark choice is restored', () async {
      SharedPreferences.setMockInitialValues({});
      final seed = ThemeProvider();
      await seed.init();
      await seed.setPreference(ThemePreference.dark);
      seed.dispose();

      final provider = ThemeProvider();
      await provider.init();

      expect(provider.mode.value, AppThemeMode.dark);
      provider.dispose();
    });
  });

  group('LocaleProvider', () {
    test('starts with no override, so the device language is used', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = LocaleProvider();
      await provider.init();

      expect(provider.preference.value, isNull);
      provider.dispose();
    });

    test('a chosen language is kept across restarts', () async {
      SharedPreferences.setMockInitialValues({});
      final first = LocaleProvider();
      await first.init();
      await first.setLocale(const Locale('ja'));
      expect(first.preference.value, const Locale('ja'));
      first.dispose();

      final second = LocaleProvider();
      await second.init();
      expect(second.preference.value, const Locale('ja'));
      second.dispose();
    });

    test('choosing "system" removes the override', () async {
      SharedPreferences.setMockInitialValues({AppConstants.prefLocale: 'de'});
      final provider = LocaleProvider();
      await provider.init();
      expect(provider.preference.value, const Locale('de'));

      await provider.setLocale(null);

      expect(provider.preference.value, isNull);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey(AppConstants.prefLocale), isFalse);
      provider.dispose();
    });

    test('tells listeners when the language changes', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = LocaleProvider();
      await provider.init();
      var notified = 0;
      provider.preference.addListener(() => notified++);

      await provider.setLocale(const Locale('fr'));
      await provider.setLocale(const Locale('es'));

      expect(notified, 2);
      provider.dispose();
    });
  });
}
