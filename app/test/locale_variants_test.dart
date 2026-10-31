import 'dart:ui';

import 'package:atrament/core/providers/locale_provider.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const supported = AppLocalizations.supportedLocales;

  Locale resolve(String tag) =>
      resolveAppLocale([localeFromTag(tag)!], supported);

  group('locale tags', () {
    test('round trip for plain, region and script locales', () {
      for (final tag in ['en', 'pt_PT', 'pt_BR', 'zh_Hans', 'zh_Hant']) {
        expect(localeTag(localeFromTag(tag)!), tag);
      }
    });

    test('accepts BCP-47 dashes and rejects junk', () {
      expect(localeTag(localeFromTag('zh-Hant-TW')!), 'zh_Hant_TW');
      expect(localeFromTag(''), isNull);
      expect(localeFromTag('x'), isNull);
    });

    test('old saved codes become explicit variants', () {
      expect(localeTag(migrateLegacyLocale(const Locale('zh'))), 'zh_Hans');
      expect(localeTag(migrateLegacyLocale(const Locale('pt'))), 'pt_BR');
      expect(localeTag(migrateLegacyLocale(const Locale('de'))), 'de');
      expect(
        localeTag(migrateLegacyLocale(const Locale('pt', 'PT'))),
        'pt_PT',
      );
    });
  });

  group('the app defines the variants explicitly', () {
    test('Chinese and Portuguese variants are all supported', () {
      final tags = supported.map(localeTag).toSet();
      expect(tags, containsAll(['zh_Hans', 'zh_Hant', 'pt_BR', 'pt_PT']));
    });

    test('the picker shows each variant once and no bare fallback', () {
      final tags = pickerLocales(supported).map(localeTag).toList();
      expect(tags, isNot(contains('zh')));
      expect(tags, isNot(contains('pt')));
      expect(tags.toSet().length, tags.length);
      expect(tags, containsAll(['zh_Hans', 'zh_Hant', 'pt_BR', 'pt_PT', 'en']));
    });
  });

  group('system language resolution', () {
    test('Chinese: script wins, then region, default is Simplified', () {
      expect(localeTag(resolve('zh_Hant')), 'zh_Hant');
      expect(localeTag(resolve('zh_Hant_CN')), 'zh_Hant');
      expect(localeTag(resolve('zh_Hans_TW')), 'zh_Hans');
      expect(localeTag(resolve('zh_TW')), 'zh_Hant');
      expect(localeTag(resolve('zh_HK')), 'zh_Hant');
      expect(localeTag(resolve('zh_CN')), 'zh_Hans');
      expect(localeTag(resolve('zh')), 'zh_Hans');
    });

    test('Portuguese: Portugal and African/Asian regions are European', () {
      expect(localeTag(resolve('pt_PT')), 'pt_PT');
      expect(localeTag(resolve('pt_AO')), 'pt_PT');
      expect(localeTag(resolve('pt_MZ')), 'pt_PT');
      expect(localeTag(resolve('pt_BR')), 'pt_BR');
      expect(localeTag(resolve('pt')), 'pt_BR');
    });

    test('other languages and fallbacks', () {
      expect(localeTag(resolve('de_AT')), 'de');
      expect(localeTag(resolve('fr_CA')), 'fr');
      expect(localeTag(resolve('iw')), 'he');
      expect(localeTag(resolve('xx')), 'en');
    });

    test('the first supported language in the device list wins', () {
      final result = resolveAppLocale(
        [const Locale('xx'), const Locale('de'), const Locale('fr')],
        supported,
      );
      expect(localeTag(result), 'de');
    });

    test('an empty or missing device list falls back to English', () {
      expect(resolveAppLocale(null, supported), const Locale('en'));
      expect(resolveAppLocale(const [], supported), const Locale('en'));
    });
  });

  group('date locale names have Flutter date data', () {
    test('mapping', () {
      expect(dateLocaleName(const Locale('en')), 'en');
      expect(dateLocaleName(localeFromTag('zh_Hans')!), 'zh');
      expect(dateLocaleName(localeFromTag('zh_Hant')!), 'zh_TW');
      expect(dateLocaleName(localeFromTag('pt_PT')!), 'pt_PT');
      expect(dateLocaleName(localeFromTag('pt_BR')!), 'pt');
    });
  });

  group('saved language choice', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('keeps Traditional Chinese and European Portuguese apart', () async {
      for (final tag in ['zh_Hant', 'pt_PT']) {
        final first = LocaleProvider();
        await first.init();
        await first.setLocale(localeFromTag(tag));
        final second = LocaleProvider();
        await second.init();
        expect(localeTag(second.preference.value!), tag);
      }
    });

    test('a language saved by an older release is upgraded', () async {
      SharedPreferences.setMockInitialValues({AppConstants.prefLocale: 'zh'});
      final a = LocaleProvider();
      await a.init();
      expect(localeTag(a.preference.value!), 'zh_Hans');

      SharedPreferences.setMockInitialValues({AppConstants.prefLocale: 'pt'});
      final b = LocaleProvider();
      await b.init();
      expect(localeTag(b.preference.value!), 'pt_BR');
    });
  });

  group('translations', () {
    test('Traditional Chinese really is Traditional and Taiwanese', () {
      final hant = lookupAppLocalizations(localeFromTag('zh_Hant')!);
      final hans = lookupAppLocalizations(localeFromTag('zh_Hans')!);
      expect(hant.save, '儲存');
      expect(hans.save, '保存');
      expect(hant.settingsTitle, '設定');
      expect(hans.settingsTitle, '设置');
    });

    test('European and Brazilian Portuguese differ where they should', () {
      final pt = lookupAppLocalizations(localeFromTag('pt_PT')!);
      final br = lookupAppLocalizations(localeFromTag('pt_BR')!);
      expect(pt.save, 'Guardar');
      expect(br.save, 'Salvar');
      expect(pt.settingsTitle, 'Definições');
      expect(br.settingsTitle, 'Configurações');
    });

    test('no Chinese file mixes the two scripts or the two wordings', () {
      final hant = lookupAppLocalizations(localeFromTag('zh_Hant')!);
      expect(hant.noteActionShare, '分享');
      expect(hant.exportTitle, '匯出');
      expect(hant.errorGeneric, isNot(contains('出现')));
    });
  });
}
