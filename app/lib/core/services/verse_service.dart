import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/verse_model.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Loads and serves scripture data from two independent local assets:
///
/// - `daily_verses.json` — a curated pool of mood-tagged verses (see
///   [VerseModel] for the schema) used for the daily rotation shown on the
///   home screen and in the optional reminder notification.
/// - `kjv.json` — the full King James Bible as a flat
///   `{"Book Chapter:Verse": "text"}` map, used for on-demand reference
///   lookup (e.g. when a user taps a reference to read it in context).
///
/// Both files are loaded lazily via `rootBundle.loadString()` on first
/// access, not at app startup (Section 11 performance requirement), and
/// cached in memory afterward.
class VerseService {
  VerseService._internal();

  static final VerseService instance = VerseService._internal();

  List<VerseModel>? _dailyVersesCache;
  Map<String, String>? _kjvCache;

  Future<List<VerseModel>> _loadDailyVerses() async {
    final cached = _dailyVersesCache;
    if (cached != null) return cached;

    try {
      final raw = await rootBundle.loadString(
        AppConstants.dailyVersesAssetPath,
      );
      final decoded = jsonDecode(raw) as List<dynamic>;
      final verses = decoded
          .map((entry) => VerseModel.fromJson(entry as Map<String, dynamic>))
          .toList();
      _dailyVersesCache = verses;
      return verses;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load daily_verses.json',
        context: 'verse_service.loadDailyVerses',
        severity: ErrorSeverity.warning,
      );
      return const [];
    }
  }

  Future<Map<String, String>> _loadKjv() async {
    final cached = _kjvCache;
    if (cached != null) return cached;

    try {
      final raw = await rootBundle.loadString(AppConstants.kjvAssetPath);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final map = decoded.map(
        (key, value) => MapEntry(key, value as String),
      );
      _kjvCache = map;
      return map;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load kjv.json',
        context: 'verse_service.loadKjv',
        severity: ErrorSeverity.warning,
      );
      return const {};
    }
  }

  // ---------------------------------------------------------------------
  // Which verse belongs to which day
  //
  // The pool is walked in a shuffled order that is reshuffled every `n` days
  // (n = pool size): every verse appears exactly once per cycle, a verse is
  // never shown two days running (even across a cycle boundary), and the
  // same date always gives the same verse for a given pool. Everything is
  // plain 32-bit integer arithmetic, so the result does not depend on the
  // Dart version or platform (the earlier `String.hashCode` was not
  // guaranteed to be stable, and repeated verses unevenly).
  // ---------------------------------------------------------------------

  /// Days since 1970-01-01 for [date]'s calendar day. Computed in UTC so a
  /// daylight-saving change can never skip or repeat a day.
  static int _dayNumber(DateTime date) => DateTime.utc(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime.utc(1970)).inDays;

  /// 32-bit FNV-1a hash of [input]'s UTF-8 bytes.
  static int _fnv1a(String input) {
    var hash = 0x811C9DC5;
    for (final byte in utf8.encode(input)) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }

  /// A deterministic shuffle of 0..n-1 for [cycle] (Fisher–Yates driven by a
  /// 32-bit xorshift generator seeded from the cycle number).
  static List<int> _shuffledOrder(int cycle, int n) {
    var state = _fnv1a('atrament-verse-cycle:$cycle');
    if (state == 0) state = 0x9E3779B9;
    int next() {
      state ^= (state << 13) & 0xFFFFFFFF;
      state ^= state >> 17;
      state ^= (state << 5) & 0xFFFFFFFF;
      return state;
    }

    final order = List<int>.generate(n, (i) => i);
    for (var i = n - 1; i > 0; i--) {
      final j = next() % (i + 1);
      final tmp = order[i];
      order[i] = order[j];
      order[j] = tmp;
    }
    return order;
  }

  /// The order for [cycle], adjusted so its first verse differs from the
  /// last verse of the previous cycle. (For n >= 3 the adjustment touches
  /// only the first two entries, so the "last" entry used for the previous
  /// cycle is unaffected.)
  static List<int> _cycleOrder(int cycle, int n) {
    final order = _shuffledOrder(cycle, n);
    final previousLast = _shuffledOrder(cycle - 1, n).last;
    if (order.first == previousLast) {
      final tmp = order[0];
      order[0] = order[1];
      order[1] = tmp;
    }
    return order;
  }

  /// Index into a pool of [poolSize] verses for [date]'s calendar day.
  static int indexForDate(DateTime date, int poolSize) {
    if (poolSize <= 0) {
      throw ArgumentError.value(poolSize, 'poolSize', 'must be positive');
    }
    if (poolSize == 1) return 0;
    final day = _dayNumber(date);
    if (poolSize == 2) return day % 2; // just alternate
    final position = day % poolSize; // Dart's % is never negative
    final cycle = (day - position) ~/ poolSize;
    return _cycleOrder(cycle, poolSize)[position];
  }

  /// The verse for [date] from an already-loaded [verses] pool, or null if
  /// the pool is empty. Synchronous, so callers that need many days (the
  /// reminder planner) don't have to await per day.
  static VerseModel? verseForDateIn(List<VerseModel> verses, DateTime date) {
    if (verses.isEmpty) return null;
    return verses[indexForDate(date, verses.length)];
  }

  /// The loaded daily-verse pool (empty if the asset could not be read).
  Future<List<VerseModel>> dailyVerses() => _loadDailyVerses();

  /// Returns the verse assigned to [date]'s calendar day.
  Future<VerseModel?> verseForDate(DateTime date) async {
    return verseForDateIn(await _loadDailyVerses(), date);
  }

  /// Convenience for "today's verse" — the primary call site from
  /// `verse_provider.dart`.
  Future<VerseModel?> todaysVerse() => verseForDate(DateTime.now());

  /// Returns all daily-pool verses tagged with [mood] (e.g. 'peaceful',
  /// 'anxious'). Reserved for a future mood-based browsing feature; not
  /// currently wired to any screen.
  Future<List<VerseModel>> versesByMood(String mood) async {
    final verses = await _loadDailyVerses();
    return verses
        .where((v) => v.themeCategory.toLowerCase() == mood.toLowerCase())
        .toList();
  }

  /// Looks up a single verse's text by exact reference (e.g. "John 3:16")
  /// against the full KJV. Returns `null` if the reference isn't found or
  /// the data failed to load.
  Future<String?> lookupByReference(String reference) async {
    final kjv = await _loadKjv();
    return kjv[reference];
  }

  /// Clears in-memory caches. Used by tests and by the settings screen's
  /// "reset app data" flow, if ever added.
  void clearCache() {
    _dailyVersesCache = null;
    _kjvCache = null;
  }
}
