import 'dart:ui';

/// Languages that read right-to-left. Keep in sync with lib/l10n.
const Set<String> rtlLanguageCodes = {'ar', 'he'};

/// Stable text form of a locale, used for the saved language choice:
/// `en`, `pt_PT`, `zh_Hant`.
String localeTag(Locale locale) {
  return [
    locale.languageCode,
    if (locale.scriptCode != null) locale.scriptCode!,
    if (locale.countryCode != null) locale.countryCode!,
  ].join('_');
}

/// Reverse of [localeTag]. Also accepts `-` as the separator. Returns null
/// for text that is not a locale.
Locale? localeFromTag(String tag) {
  final parts = tag.split(RegExp('[_-]')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty || parts.first.length < 2 || parts.first.length > 3) {
    return null;
  }
  String? script;
  String? country;
  for (final part in parts.skip(1)) {
    if (part.length == 4) {
      script = part[0].toUpperCase() + part.substring(1).toLowerCase();
    } else if (part.length == 2 || part.length == 3) {
      country = part.toUpperCase();
    }
  }
  return Locale.fromSubtags(
    languageCode: parts.first.toLowerCase(),
    scriptCode: script,
    countryCode: country,
  );
}

/// Older releases saved only the language code. `zh` meant Simplified
/// Chinese and `pt` meant Brazilian Portuguese; this maps them to the
/// explicit variants.
Locale migrateLegacyLocale(Locale locale) {
  if (locale.scriptCode == null && locale.countryCode == null) {
    if (locale.languageCode == 'zh') {
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans');
    }
    if (locale.languageCode == 'pt') {
      return const Locale('pt', 'BR');
    }
  }
  return locale;
}

/// Locales shown in the language picker and listed on the stores. A plain
/// language (`zh`, `pt`) is only a fallback for its variants, so it is left
/// out when explicit variants exist.
List<Locale> pickerLocales(Iterable<Locale> supported) {
  final list = supported.toList();
  return [
    for (final l in list)
      if (l.scriptCode != null ||
          l.countryCode != null ||
          !list.any(
            (o) =>
                o.languageCode == l.languageCode &&
                (o.scriptCode != null || o.countryCode != null),
          ))
        l,
  ];
}

/// Locale name `intl` has date data for. Flutter ships date data for `zh`,
/// `zh_TW`, `zh_HK`, `pt` and `pt_PT` but not for script codes.
String dateLocaleName(Locale locale) {
  if (locale.languageCode == 'zh') {
    final traditional = locale.scriptCode == 'Hant' ||
        locale.countryCode == 'TW' ||
        locale.countryCode == 'HK' ||
        locale.countryCode == 'MO';
    if (!traditional) return 'zh';
    return locale.countryCode == 'HK' ? 'zh_HK' : 'zh_TW';
  }
  if (locale.languageCode == 'pt' && locale.countryCode == 'PT') {
    return 'pt_PT';
  }
  return locale.languageCode;
}

const Map<String, String> _languageAliases = {
  'iw': 'he',
  'in': 'id',
  'no': 'nb',
  'nn': 'nb',
  'tl': 'fil',
};

const Set<String> _europeanPortugueseCountries = {
  'PT', 'AO', 'MZ', 'CV', 'GW', 'ST', 'TL', 'GQ', 'MO', //
};

/// Picks the app language from the device's language list. Handles what
/// Flutter's default matching cannot: Chinese script/region (Taiwan, Hong
/// Kong and Macau get Traditional), Portuguese regions (Portugal and the
/// African and Asian Portuguese-speaking countries get European Portuguese,
/// everything else Brazilian), and old language codes (`iw`, `in`, `no`).
Locale resolveAppLocale(List<Locale>? preferred, Iterable<Locale> supported) {
  final tags = supported.map(localeTag).toSet();
  const fallback = Locale('en');
  for (final locale in preferred ?? const <Locale>[]) {
    final language = _languageAliases[locale.languageCode] ?? locale.languageCode;
    final candidates = <Locale>[];
    if (language == 'zh') {
      final traditional = locale.scriptCode == 'Hant' ||
          (locale.scriptCode == null &&
              const {'TW', 'HK', 'MO'}.contains(locale.countryCode));
      candidates.add(
        Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: traditional ? 'Hant' : 'Hans',
        ),
      );
    } else if (language == 'pt') {
      candidates.add(
        _europeanPortugueseCountries.contains(locale.countryCode)
            ? const Locale('pt', 'PT')
            : const Locale('pt', 'BR'),
      );
    } else {
      if (locale.countryCode != null) {
        candidates.add(Locale(language, locale.countryCode));
      }
      candidates.add(Locale(language));
    }
    for (final candidate in candidates) {
      if (tags.contains(localeTag(candidate))) return candidate;
    }
  }
  return fallback;
}
