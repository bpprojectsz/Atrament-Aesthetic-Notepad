import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/core/utils/quill_extra_localizations.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture, visibleForTesting;
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;

/// The language (and variant) flutter_quill should use for [locale].
///
/// flutter_quill picks Chinese and Portuguese variants by *country code*, so
/// the script and region of the app's language have to be turned into one:
/// Traditional Chinese uses its Taiwan file, Simplified its mainland file, and
/// both kinds of Portuguese use its Brazilian file, which is the complete one
/// (its plain Portuguese file leaves labels in English). Norwegian is `no` in
/// Quill. Languages Quill lacks have translations of the app's own
/// ([appQuillTranslations]) or fall back to English.
@visibleForTesting
Locale quillLocaleFor(Locale locale) {
  switch (locale.languageCode) {
    case 'zh':
      return Locale('zh', locale.scriptCode == 'Hant' ? 'TW' : 'CN');
    case 'pt':
      return const Locale('pt', 'BR');
    case 'nb':
    case 'nn':
      return const Locale('no');
  }
  final candidate = Locale(locale.languageCode);
  return FlutterQuillLocalizations.delegate.isSupported(candidate)
      ? candidate
      : const Locale('en');
}

/// Lets every app language reach flutter_quill's translations.
class QuillLocalizationsFallbackDelegate
    extends LocalizationsDelegate<FlutterQuillLocalizations> {
  const QuillLocalizationsFallbackDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<FlutterQuillLocalizations> load(Locale locale) async {
    final own = appQuillTranslations[locale.languageCode];
    if (own != null) {
      return SynchronousFuture<FlutterQuillLocalizations>(
        AppQuillLocalizations(locale.languageCode, own),
      );
    }
    final inner = await FlutterQuillLocalizations.delegate.load(
      quillLocaleFor(locale),
    );
    final fixes =
        appQuillOverrides[localeTag(locale)] ??
        appQuillOverrides[locale.languageCode];
    if (fixes == null) return inner;
    return PatchedQuillLocalizations(locale.languageCode, inner, fixes);
  }

  @override
  bool shouldReload(QuillLocalizationsFallbackDelegate old) => false;
}

/// Every localization delegate the app needs: its own strings plus
/// flutter_quill's. Without the Quill delegate, tapping a link inside a note
/// throws because the editor looks up its own translations.
final List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
      ...AppLocalizations.localizationsDelegates,
      const QuillLocalizationsFallbackDelegate(),
    ];
