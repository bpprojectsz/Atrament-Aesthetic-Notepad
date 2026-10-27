import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;

/// Every localization delegate the app needs: its own strings plus
/// flutter_quill's. Without the Quill delegate, tapping a link inside a note
/// throws because the editor looks up its own translations.
final List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
      ...AppLocalizations.localizationsDelegates,
      FlutterQuillLocalizations.delegate,
    ];
