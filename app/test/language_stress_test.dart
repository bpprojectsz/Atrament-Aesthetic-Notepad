import 'package:atrament/core/providers/locale_provider.dart';
import 'package:atrament/core/utils/app_localization_setup.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

/// Exercises every language the app offers: that Flutter's own delegates
/// support it, that the app resolves it from a device's language list, that a
/// manual choice survives a restart, and that text direction agrees.
void main() {
  const all = AppLocalizations.supportedLocales;
  final languages = pickerLocales(all);

  String tag(Locale l) => localeTag(l);

  test('the app offers all 41 requested languages plus the two variants', () {
    final codes = languages.map((l) => l.languageCode).toSet();
    expect(
      codes,
      containsAll(<String>[
        'en', 'zh', 'es', 'hi', 'ar', 'pt', 'bn', 'ru', 'ja', 'de', 'fr', //
        'ur', 'id', 'ko', 'tr', 'vi', 'it', 'th', 'fa', 'ta', 'te', 'mr',
        'gu', 'pl', 'uk', 'nl', 'ms', 'sw', 'ro', 'el', 'cs', 'sv', 'hu',
        'he', 'da', 'fi', 'nb', 'sk', 'bg', 'ca', 'fil',
      ]),
    );
    expect(codes.length, 41);
    expect(languages.length, 43, reason: 'zh and pt each have two variants');
  });

  group('every language works with every localization delegate', () {
    for (final locale in languages) {
      test(tag(locale), () async {
        for (final delegate in appLocalizationsDelegates) {
          expect(
            delegate.isSupported(locale),
            isTrue,
            reason: '${delegate.runtimeType} does not support ${tag(locale)}',
          );
          // Loading must not throw; this also loads the date formats.
          await delegate.load(locale);
        }
        final l10n = lookupAppLocalizations(locale);
        expect(l10n.appName, isNotEmpty);
        expect(l10n.save, isNotEmpty);

        final date = DateFormat.yMMMd(
          dateLocaleName(locale),
        ).format(DateTime(2026, 11, 2));
        expect(date, isNotEmpty);
        expect(
          DateFormat.jm(dateLocaleName(locale)).format(DateTime(2026, 1, 1, 14)),
          isNotEmpty,
        );
      });
    }
  });

  group('a device set to the language gets that language', () {
    for (final locale in languages) {
      test(tag(locale), () {
        expect(tag(resolveAppLocale([locale], all)), tag(locale));
      });
    }
  });

  group('first install follows the device language list', () {
    Locale pick(List<Locale> preferred) => resolveAppLocale(preferred, all);

    test('regional and legacy codes map to the right app language', () {
      final cases = <String, String>{
        'en_US': 'en',
        'en_GB': 'en',
        'es_MX': 'es',
        'fr_CA': 'fr',
        'de_AT': 'de',
        'hi_IN': 'hi',
        'bn_BD': 'bn',
        'ta_LK': 'ta',
        'ur_PK': 'ur',
        'fa_AF': 'fa',
        'ar_EG': 'ar',
        'ms_MY': 'ms',
        'id_ID': 'id',
        'in_ID': 'id',
        'iw_IL': 'he',
        'no_NO': 'nb',
        'nn_NO': 'nb',
        'nb_NO': 'nb',
        'tl_PH': 'fil',
        'fil_PH': 'fil',
        'pt_BR': 'pt_BR',
        'pt_PT': 'pt_PT',
        'pt_AO': 'pt_PT',
        'zh_CN': 'zh_Hans',
        'zh_SG': 'zh_Hans',
        'zh_TW': 'zh_Hant',
        'zh_HK': 'zh_Hant',
        'zh_MO': 'zh_Hant',
      };
      cases.forEach((system, expected) {
        expect(
          tag(pick([localeFromTag(system)!])),
          expected,
          reason: 'device language $system',
        );
      });
    });

    test('Chinese by script beats region', () {
      expect(
        tag(pick([localeFromTag('zh_Hant_CN')!])),
        'zh_Hant',
      );
      expect(
        tag(pick([localeFromTag('zh_Hans_HK')!])),
        'zh_Hans',
      );
    });

    test('the first language the app has wins', () {
      expect(
        tag(pick([const Locale('sr'), const Locale('hi', 'IN'), const Locale('fr')])),
        'hi',
      );
      expect(
        tag(pick([const Locale('xx'), const Locale('yy')])),
        'en',
        reason: 'nothing supported falls back to English',
      );
    });
  });

  group('device language list in a running app', () {
    Future<Locale> openAppIn(
      WidgetTester tester,
      List<Locale> deviceLocales,
    ) async {
      tester.platformDispatcher.localesTestValue = deviceLocales;
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      late Locale shown;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: all,
          localeListResolutionCallback: resolveAppLocale,
          home: Builder(
            builder: (context) {
              shown = Localizations.localeOf(context);
              return Text(AppLocalizations.of(context)!.settingsTitle);
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      return shown;
    }

    testWidgets('Traditional Chinese device', (tester) async {
      final shown = await openAppIn(tester, [localeFromTag('zh_Hant_TW')!]);
      expect(tag(shown), 'zh_Hant');
      expect(find.text('設定'), findsOneWidget);
    });

    testWidgets('Portugal device', (tester) async {
      final shown = await openAppIn(tester, [const Locale('pt', 'PT')]);
      expect(tag(shown), 'pt_PT');
      expect(find.text('Definições'), findsOneWidget);
    });

    testWidgets('Brazil device', (tester) async {
      final shown = await openAppIn(tester, [const Locale('pt', 'BR')]);
      expect(tag(shown), 'pt_BR');
      expect(find.text('Configurações'), findsOneWidget);
    });

    testWidgets('legacy Norwegian code', (tester) async {
      final shown = await openAppIn(tester, [const Locale('no', 'NO')]);
      expect(tag(shown), 'nb');
      expect(find.text('Innstillinger'), findsOneWidget);
    });

    testWidgets('unsupported language falls back to English', (tester) async {
      final shown = await openAppIn(tester, [const Locale('sr', 'RS')]);
      expect(tag(shown), 'en');
      expect(find.text('Settings'), findsOneWidget);
    });
  });

  group('manual choice', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    for (final locale in languages) {
      test('${tag(locale)} survives a restart', () async {
        final first = LocaleProvider();
        await first.init();
        await first.setLocale(locale);

        final second = LocaleProvider();
        await second.init();
        expect(tag(second.preference.value!), tag(locale));
      });
    }

    test('"follow the device" clears the choice', () async {
      final first = LocaleProvider();
      await first.init();
      await first.setLocale(const Locale('de'));
      await first.setLocale(null);

      final second = LocaleProvider();
      await second.init();
      expect(second.preference.value, isNull);
    });

    test('a manual choice is not overridden by the device language', () async {
      SharedPreferences.setMockInitialValues({AppConstants.prefLocale: 'ta'});
      final provider = LocaleProvider();
      await provider.init();
      expect(provider.preference.value, const Locale('ta'));
    });

    test('a saved language the app no longer has is ignored safely', () async {
      SharedPreferences.setMockInitialValues({AppConstants.prefLocale: '???'});
      final provider = LocaleProvider();
      await provider.init();
      expect(provider.preference.value, isNot(isA<Never>()));
    });
  });

  group('text direction', () {
    for (final locale in languages) {
      test('${tag(locale)} direction matches the app list', () async {
        final widgets = await GlobalWidgetsLocalizations.delegate.load(locale);
        final flutterSaysRtl = widgets.textDirection == TextDirection.rtl;
        expect(
          rtlLanguageCodes.contains(locale.languageCode),
          flutterSaysRtl,
          reason: 'rtlLanguageCodes and Flutter disagree for ${tag(locale)}',
        );
      });
    }
  });
}
