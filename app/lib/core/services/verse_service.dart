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

  /// Returns the verse assigned to [date]'s calendar day.
  ///
  /// The daily_verses pool isn't guaranteed to be exactly 365/366 entries
  /// (curated pools grow over time), so rather than indexing by day-of-year
  /// directly, this hashes a stable per-day key across the pool size. The
  /// same calendar date always yields the same verse for a given pool
  /// (deterministic), and the mapping spreads evenly as the pool grows or
  /// shrinks between app versions.
  Future<VerseModel?> verseForDate(DateTime date) async {
    final verses = await _loadDailyVerses();
    if (verses.isEmpty) return null;

    final dayKey = '${date.year}-${date.month}-${date.day}';
    final index = dayKey.hashCode.abs() % verses.length;
    return verses[index];
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
