import 'package:intl/intl.dart';

/// Bucket returned by [DateFormatter.relativeBucket]. The widget layer maps
/// each value to a localized label (e.g. `l10n.today`, `l10n.yesterday`).
enum RelativeDateBucket { today, yesterday, thisWeek, older }

/// Locale-aware date formatting helpers, backed by `intl`.
///
/// All formatting goes through this class rather than ad-hoc `DateFormat`
/// construction in widgets, so locale propagation stays centralized.
class DateFormatter {
  const DateFormatter._();

  /// e.g. "Aug 7, 2026" — used on note cards and list items.
  static String short(DateTime date, {required String localeCode}) {
    return DateFormat.yMMMd(localeCode).format(date);
  }

  /// e.g. "August 7, 2026" — used in note detail headers.
  static String long(DateTime date, {required String localeCode}) {
    return DateFormat.yMMMMd(localeCode).format(date);
  }

  /// e.g. "3:45 PM" / "15:45" depending on locale conventions.
  static String time(DateTime date, {required String localeCode}) {
    return DateFormat.jm(localeCode).format(date);
  }

  /// e.g. "Aug 7, 2026, 3:45 PM" — used in export footers.
  static String dateTime(DateTime date, {required String localeCode}) {
    return DateFormat.yMMMd(localeCode).add_jm().format(date);
  }

  /// Classifies [date] relative to today. The widget layer maps this to a
  /// localized string via `AppLocalizations` — this function never returns
  /// hardcoded English text, keeping `core/` free of user-facing strings.
  static RelativeDateBucket relativeBucket(DateTime date, {DateTime? now}) {
    final current = now ?? DateTime.now();
    // Compare calendar dates in UTC. Local midnights are only 23 or 25 hours
    // apart across a daylight-saving change, which made a note from
    // "yesterday" count as "today" (or the reverse) for a day.
    final today = DateTime.utc(current.year, current.month, current.day);
    final target = DateTime.utc(date.year, date.month, date.day);
    final diffDays = today.difference(target).inDays;

    if (diffDays == 0) return RelativeDateBucket.today;
    if (diffDays == 1) return RelativeDateBucket.yesterday;
    if (diffDays > 1 && diffDays < 7) return RelativeDateBucket.thisWeek;
    return RelativeDateBucket.older;
  }

  /// Weekday name for [RelativeDateBucket.thisWeek] items, e.g. "Tuesday".
  static String weekday(DateTime date, {required String localeCode}) {
    return DateFormat.EEEE(localeCode).format(date);
  }

  /// Month/day key used to rotate the daily verse (e.g. "08-07"),
  /// intentionally independent of locale and year so the same verse shows
  /// on the same calendar day every year.
  static String verseRotationKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$month-$day';
  }
}
