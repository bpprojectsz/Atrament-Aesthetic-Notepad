import 'dart:io';

import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// The iOS permission prompts (Face ID, tracking) are read from per-language
/// InfoPlist.strings files. They only work if the folder exists, both texts
/// are translated, and the Xcode project lists the files as resources.
void main() {
  final plist = File('ios/Runner/Info.plist').readAsStringSync();
  final project = File('ios/Runner.xcodeproj/project.pbxproj').readAsStringSync();

  String iosFolder(String tag) {
    switch (tag) {
      case 'pt_BR':
        return 'pt-BR';
      case 'pt_PT':
        return 'pt-PT';
      case 'zh_Hans':
        return 'zh-Hans';
      case 'zh_Hant':
        return 'zh-Hant';
      default:
        return tag;
    }
  }

  String english(String key) => RegExp(
    '<key>$key</key>\\s*<string>([^<]*)</string>',
  ).firstMatch(plist)!.group(1)!;

  final locales = pickerLocales(
    AppLocalizations.supportedLocales,
  ).where((l) => l.languageCode != 'en');

  for (final locale in locales) {
    final folder = iosFolder(localeTag(locale));
    test('iOS prompts are translated for $folder', () {
      final file = File('ios/Runner/$folder.lproj/InfoPlist.strings');
      expect(file.existsSync(), isTrue, reason: 'missing $folder.lproj');
      final text = file.readAsStringSync();
      for (final key in ['NSFaceIDUsageDescription', 'NSUserTrackingUsageDescription']) {
        final match = RegExp('"$key" = "([^"]+)";').firstMatch(text);
        expect(match, isNotNull, reason: '$folder is missing $key');
        expect(
          match!.group(1),
          isNot(english(key)),
          reason: '$folder still has the English text for $key',
        );
      }
      // The project must list this folder's file, or Xcode never ships it.
      expect(
        project.contains('$folder.lproj/InfoPlist.strings'),
        isTrue,
        reason: 'project.pbxproj does not reference $folder.lproj',
      );
      expect(plist.contains('<string>$folder</string>'), isTrue);
    });
  }

  test('the English prompts are in Info.plist', () {
    expect(english('NSFaceIDUsageDescription'), 'To lock your notes with Face ID');
    expect(english('NSUserTrackingUsageDescription'), isNotEmpty);
  });

  test('InfoPlist.strings is a localized resource of the Runner target', () {
    expect(project.contains('isa = PBXVariantGroup'), isTrue);
    expect(project.contains('name = InfoPlist.strings;'), isTrue);
    expect(project.contains('InfoPlist.strings in Resources'), isTrue);
  });
}
