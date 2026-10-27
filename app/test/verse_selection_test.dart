import 'dart:convert';
import 'dart:io';

import 'package:atrament/core/models/verse_model.dart';
import 'package:atrament/core/services/verse_service.dart';
import 'package:flutter_test/flutter_test.dart';

List<VerseModel> _pool(int n) => [
  for (var i = 0; i < n; i++)
    VerseModel(
      reference: 'Book $i:1',
      text: 'Verse number $i',
      translation: 'KJV',
      themeCategory: 'peace',
    ),
];

void main() {
  group('which verse belongs to which day', () {
    test('is pinned to fixed values, so it never changes between Dart versions', () {
      // These come from an independent implementation of the algorithm; if
      // the selection ever drifts (e.g. someone swaps in String.hashCode
      // again) these fail.
      expect(VerseService.indexForDate(DateTime(2026, 10, 15), 500), 126);
      expect(VerseService.indexForDate(DateTime(2026, 10, 16), 500), 339);
      expect(VerseService.indexForDate(DateTime(2026, 1, 1), 500), 98);
      expect(VerseService.indexForDate(DateTime(2024, 2, 29), 500), 41);
      expect(VerseService.indexForDate(DateTime(1969, 12, 31), 500), 157);
      expect(VerseService.indexForDate(DateTime(2026, 10, 15), 492), 67);
    });

    test('the same date always gives the same verse, whatever the time of day', () {
      final morning = VerseService.indexForDate(DateTime(2026, 10, 15, 6, 0), 492);
      final night = VerseService.indexForDate(DateTime(2026, 10, 15, 23, 59), 492);
      expect(morning, night);
    });

    test('a verse is never shown two days in a row, over twenty years', () {
      for (final n in [3, 4, 7, 100, 492]) {
        int? previous;
        var day = DateTime(2026, 1, 1);
        for (var i = 0; i < 365 * 20; i++) {
          final index = VerseService.indexForDate(day, n);
          expect(index, inInclusiveRange(0, n - 1));
          expect(index, isNot(previous), reason: 'pool $n, day $i');
          previous = index;
          day = DateTime(day.year, day.month, day.day + 1);
        }
      }
    });

    test('every verse appears exactly once in each full cycle', () {
      for (final n in [3, 7, 50]) {
        // Cycles are aligned to whole day numbers; walk three of them.
        final seen = <int, int>{};
        final day = DateTime(2027, 3, 1);
        // Advance to a cycle start by trying every offset until we've seen
        // n distinct verses within n consecutive days.
        var found = false;
        for (var offset = 0; offset < n && !found; offset++) {
          final start = DateTime(day.year, day.month, day.day + offset);
          final window = {
            for (var i = 0; i < n; i++)
              VerseService.indexForDate(
                DateTime(start.year, start.month, start.day + i),
                n,
              ),
          };
          if (window.length == n) {
            found = true;
            seen.addAll({for (final v in window) v: 1});
          }
        }
        expect(found, isTrue, reason: 'pool $n');
        expect(seen.keys.toSet(), {for (var i = 0; i < n; i++) i});
      }
    });

    test('over a long stretch every verse gets used', () {
      final used = <int>{};
      var day = DateTime(2026, 1, 1);
      for (var i = 0; i < 492 * 2; i++) {
        used.add(VerseService.indexForDate(day, 492));
        day = DateTime(day.year, day.month, day.day + 1);
      }
      expect(used.length, 492);
    });

    test('tiny pools still work', () {
      expect(VerseService.indexForDate(DateTime(2026, 5, 5), 1), 0);
      final a = VerseService.indexForDate(DateTime(2026, 5, 5), 2);
      final b = VerseService.indexForDate(DateTime(2026, 5, 6), 2);
      expect(a, isNot(b), reason: 'two verses alternate');
      expect(() => VerseService.indexForDate(DateTime(2026, 5, 5), 0),
          throwsArgumentError);
    });

    test('an empty pool gives no verse, a pool gives the matching one', () {
      expect(VerseService.verseForDateIn(const [], DateTime(2026, 1, 1)), isNull);

      final pool = _pool(500);
      final verse = VerseService.verseForDateIn(pool, DateTime(2026, 10, 15));
      expect(verse, pool[126]);
    });
  });

  group('the bundled verse list', () {
    late List<dynamic> verses;

    setUpAll(() {
      verses = jsonDecode(File('assets/json/daily_verses.json').readAsStringSync())
          as List<dynamic>;
    });

    test('has no repeated verses', () {
      final refs = verses.map((v) => (v as Map)['reference']).toList();
      expect(refs.toSet().length, refs.length,
          reason: 'a repeated reference makes some days repeat a verse');
    });

    test('every entry can be parsed and has text and a reference', () {
      for (final entry in verses) {
        final verse = VerseModel.fromJson(entry as Map<String, dynamic>);
        expect(verse.reference.trim(), isNotEmpty);
        expect(verse.text.trim(), isNotEmpty);
      }
      expect(verses.length, greaterThan(300));
    });
  });
}
