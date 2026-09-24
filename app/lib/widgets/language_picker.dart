import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/providers/locale_provider.dart';
import '../core/utils/constants.dart';

/// Shows the language picker bottom sheet. Selecting "System default"
/// clears the override; selecting a language stores it.
///
/// Extracted from SettingsScreen so both the Settings row and the home
/// header icon open the same sheet with identical behaviour.
Future<void> showLanguagePicker(
  BuildContext context,
  LocaleProvider localeProvider,
) async {
  final l10n = AppLocalizations.of(context)!;
  final current = localeProvider.preference.value;

  final picked = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  l10n.languagePickerTitle,
                  style: TextStyle(
                    fontSize: AppTypography.title2.size,
                    fontWeight: AppTypography.title2.weight,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(l10n.languageSystem),
                subtitle: Text(l10n.languageFollowsSystem),
                trailing: current == null ? const Icon(Icons.check) : null,
                onTap: () => Navigator.pop(context, ''),
              ),
              const Divider(height: 1),
              for (final locale in AppLocalizations.supportedLocales)
                ListTile(
                  title: Text(
                    nativeNameFor(locale.languageCode) ?? locale.languageCode,
                  ),
                  trailing: current?.languageCode == locale.languageCode
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => Navigator.pop(context, locale.languageCode),
                ),
            ],
          ),
        ),
      );
    },
  );

  if (picked == null) return;
  if (picked.isEmpty) {
    await localeProvider.setLocale(null);
  } else {
    await localeProvider.setLocale(Locale(picked));
  }
}

/// Native language names for the picker. Hardcoded: readers see their own
/// language in its own script, which is the conventional UX for language
/// selectors — a translated label would be unreadable to users who do not
/// yet speak the currently active language.
String? nativeNameFor(String code) {
  switch (code) {
    case 'ar':
      return 'العربية';
    case 'de':
      return 'Deutsch';
    case 'en':
      return 'English';
    case 'es':
      return 'Español';
    case 'fr':
      return 'Français';
    case 'he':
      return 'עברית';
    case 'hi':
      return 'हिन्दी';
    case 'ja':
      return '日本語';
    case 'ko':
      return '한국어';
    case 'pt':
      return 'Português';
    case 'zh':
      return '中文';
    default:
      return null;
  }
}
