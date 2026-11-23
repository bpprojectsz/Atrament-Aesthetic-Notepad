import 'dart:io';

import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Guards the native project files (which no Dart test otherwise touches):
/// the languages the stores list, the iOS launch setup, and the Android
/// resources the code refers to by name.
void main() {
  final supported = pickerLocales(AppLocalizations.supportedLocales)
      .map((l) => l.toLanguageTag())
      .toSet();

  String read(String path) => File(path).readAsStringSync();

  group('iOS Info.plist', () {
    final plist = read('ios/Runner/Info.plist');

    test('lists every language the app is translated into', () {
      final block = RegExp(
        r'<key>CFBundleLocalizations</key>\s*<array>(.*?)</array>',
        dotAll: true,
      ).firstMatch(plist);
      expect(block, isNotNull);
      final listed = RegExp(r'<string>([^<]+)</string>')
          .allMatches(block!.group(1)!)
          .map((m) => m.group(1)!)
          .toSet();

      expect(listed, supported,
          reason: 'add new languages here as well as in lib/l10n');
    });

    test('has the scene manifest that matches SceneDelegate.swift', () {
      expect(plist, contains('<key>UIApplicationSceneManifest</key>'));
      expect(plist, contains(r'$(PRODUCT_MODULE_NAME).SceneDelegate'));
      expect(File('ios/Runner/SceneDelegate.swift').existsSync(), isTrue);
    });

    test('keeps the keys the iOS SDKs refuse to run without', () {
      expect(plist, contains('<key>GADApplicationIdentifier</key>'));
      expect(plist, contains('<key>NSUserTrackingUsageDescription</key>'));
      expect(plist, contains('<key>NSFaceIDUsageDescription</key>'));
    });

    test('has no made-up notification usage key', () {
      expect(plist, isNot(contains('NSUserNotificationsUsageDescription')));
    });

    test('declares the app uses only exempt encryption', () {
      expect(
        RegExp(
          r'<key>ITSAppUsesNonExemptEncryption</key>\s*<false/>',
        ).hasMatch(plist),
        isTrue,
      );
    });
  });

  group('Android', () {
    test('per-app language list matches the app languages', () {
      final xml = read('android/app/src/main/res/xml/locales_config.xml');
      final listed = RegExp(r'android:name="([^"]+)"')
          .allMatches(xml)
          .map((m) => m.group(1)!)
          .toSet();

      expect(listed, supported,
          reason: 'add new languages here as well as in lib/l10n');
    });

    test('the manifest points at that list', () {
      final manifest = read('android/app/src/main/AndroidManifest.xml');
      expect(manifest, contains('android:localeConfig="@xml/locales_config"'));
    });

    test('the notification icon the code names exists and is kept in release', () {
      final code = read('lib/platform/notification_service.dart');
      expect(code, contains("'ic_stat_notification'"));
      expect(
        File('android/app/src/main/res/drawable/ic_stat_notification.xml')
            .existsSync(),
        isTrue,
      );
      final keep = read('android/app/src/main/res/raw/keep.xml');
      expect(keep, contains('@drawable/ic_stat_notification'));
    });

    test('launch and normal themes inherit from AppCompat (biometric prompt)', () {
      for (final dir in ['values', 'values-night', 'values-v31', 'values-night-v31']) {
        final styles = read('android/app/src/main/res/$dir/styles.xml');
        for (final name in ['LaunchTheme', 'NormalTheme']) {
          final match = RegExp('<style name="$name" parent="([^"]+)"').firstMatch(styles);
          expect(match, isNotNull, reason: '$dir/$name');
          expect(match!.group(1), startsWith('Theme.AppCompat'),
              reason: '$dir/$name');
        }
      }
    });
  });
}
