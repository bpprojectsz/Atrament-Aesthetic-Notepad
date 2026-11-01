import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards every translation file against missing keys, broken placeholders
/// and strings that were left in English.
void main() {
  final dir = Directory('lib/l10n');
  final files = dir
      .listSync()
      .whereType<File>()
      .where((f) => RegExp(r'app_[A-Za-z_]+\.arb$').hasMatch(f.path))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  Map<String, dynamic> read(File f) =>
      json.decode(f.readAsStringSync()) as Map<String, dynamic>;

  final english = read(File('lib/l10n/app_en.arb'));
  final keys = english.keys.where((k) => !k.startsWith('@')).toList();
  final placeholder = RegExp(r'\{(\w+)\}');

  List<String> holders(String s) =>
      (placeholder.allMatches(s).map((m) => m.group(1)!).toList()..sort());

  // Variant files with no strings of their own inherit their language file.
  bool isMarker(Map<String, dynamic> d) =>
      d.keys.every((k) => k.startsWith('@@'));

  // Words that are legitimately the same as English in some languages.
  const sameAsEnglish = {
    'appName',
    'fontInter',
    'fontLora',
    'premiumUnlockPriceFallback',
    'proLabel',
    'premiumSectionTitle',
    'exportTitle',
    'notificationsSectionTitle',
    'supportSectionTitle',
    'supportRow',
    'themeSystem',
    'fontSystem',
    'fontSerif',
  };

  test('there is a translation file for each language', () {
    expect(files.length, greaterThanOrEqualTo(11));
  });

  for (final f in files) {
    final name = f.uri.pathSegments.last;
    final data = read(f);
    if (name == 'app_en.arb' || isMarker(data)) continue;

    group(name, () {
      test('has every key and no extras', () {
        final own = data.keys.where((k) => !k.startsWith('@')).toSet();
        expect(keys.where((k) => !own.contains(k)), isEmpty, reason: 'missing');
        expect(own.difference(keys.toSet()), isEmpty, reason: 'extra');
      });

      test('placeholders match English', () {
        for (final k in keys) {
          expect(holders(data[k] as String), holders(english[k] as String),
              reason: k);
        }
      });

      test('no empty strings and no stray whitespace', () {
        for (final k in keys) {
          final v = data[k] as String;
          expect(v, isNotEmpty, reason: k);
          expect(v, v.trim(), reason: k);
        }
      });

      test('most strings are translated', () {
        final same = keys
            .where((k) => data[k] == english[k] && !sameAsEnglish.contains(k))
            .toList();
        expect(same, isEmpty, reason: 'still English: $same');
      });
    });
  }
}
