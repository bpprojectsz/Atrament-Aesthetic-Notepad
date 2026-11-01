import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;

/// The language flutter_quill should use for [locale].
///
/// flutter_quill ships its own translations and does not cover every language
/// the app has. It knows Norwegian as `no` (the app uses `nb`), and has none
/// for a few languages, which fall back to English. Without this, the editor
/// cannot find its labels in those languages.
@visibleForTesting
Locale quillLocaleFor(Locale locale) {
  final code = locale.languageCode == 'nb' || locale.languageCode == 'nn'
      ? 'no'
      : locale.languageCode;
  final candidate = Locale(code);
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
  Future<FlutterQuillLocalizations> load(Locale locale) =>
      FlutterQuillLocalizations.delegate.load(quillLocaleFor(locale));

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
