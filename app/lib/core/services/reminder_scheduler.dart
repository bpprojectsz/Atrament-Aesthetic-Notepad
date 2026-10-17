import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/verse_model.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';
import 'verse_service.dart';

/// One notification to show: a moment in local time plus its text.
class ReminderNotification {
  const ReminderNotification({
    required this.when,
    required this.title,
    required this.body,
  });

  final DateTime when;
  final String title;
  final String body;
}

/// What actually talks to the operating system. Kept as an interface so the
/// scheduling rules can be tested without a phone.
abstract class ReminderGateway {
  /// Replaces every pending reminder with [reminders]. Returns whether all
  /// of them were scheduled.
  Future<bool> scheduleReminders(List<ReminderNotification> reminders);

  /// Removes every pending reminder.
  Future<void> cancelReminders();
}

/// A planned reminder before its text is chosen.
class PlannedReminder {
  const PlannedReminder(this.when, this.verse);

  final DateTime when;

  /// That day's verse, or null if the verse pool could not be loaded.
  final VerseModel? verse;
}

/// The next [days] reminder moments at [hour]:[minute], starting today if
/// that time is still ahead of [now] and tomorrow otherwise. Each carries
/// the verse for its own day, so every morning's notification shows that
/// day's verse (not the one picked when the reminder was switched on).
List<PlannedReminder> planReminders({
  required DateTime now,
  required int hour,
  required int minute,
  required int days,
  required List<VerseModel> verses,
}) {
  final todayAtTime = DateTime(now.year, now.month, now.day, hour, minute);
  final firstOffset = todayAtTime.isAfter(now) ? 0 : 1;

  return [
    for (var i = 0; i < days; i++)
      () {
        // Calendar arithmetic in local time keeps the chosen hour right
        // across daylight-saving changes.
        final when = DateTime(
          now.year,
          now.month,
          now.day + firstOffset + i,
          hour,
          minute,
        );
        return PlannedReminder(when, VerseService.verseForDateIn(verses, when));
      }(),
  ];
}

/// Keeps the daily verse reminder scheduled.
///
/// A single repeating notification can only carry fixed text, so instead the
/// next [daysAhead] days are scheduled individually, each with its day's
/// verse. [refresh] tops the window up; the app calls it at launch, when it
/// returns to the foreground, and when the language or reminder settings
/// change. If the app isn't opened for [daysAhead] days the reminders stop
/// until it is.
class ReminderScheduler {
  ReminderScheduler({
    required ReminderGateway gateway,
    Future<List<VerseModel>> Function()? loadVerses,
    DateTime Function()? clock,
  }) : _gateway = gateway,
       _loadVerses = loadVerses ?? VerseService.instance.dailyVerses,
       _clock = clock ?? DateTime.now;

  /// Wired to the real notification service in `main.dart`.
  static late ReminderScheduler instance;

  static const int daysAhead = 14;

  /// A routine top-up is skipped if one ran this recently.
  static const Duration minRefreshInterval = Duration(minutes: 30);

  final ReminderGateway _gateway;
  final Future<List<VerseModel>> Function() _loadVerses;
  final DateTime Function() _clock;

  DateTime? _lastRefreshAt;

  // Runs one scheduling job at a time so overlapping triggers (resume,
  // settings change, language change) can't interleave their cancel/schedule
  // steps.
  Future<void> _queue = Future.value();

  Future<T> _serialized<T>(Future<T> Function() job) {
    final result = _queue.then((_) => job());
    _queue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  /// Schedules the reminders for the given time, replacing any existing
  /// ones. Used right after the user switches the reminder on or changes its
  /// time. Returns whether scheduling succeeded.
  Future<bool> schedule({
    required int hour,
    required int minute,
    required String fallbackTitle,
    required String fallbackBody,
  }) {
    return _serialized(() async {
      List<VerseModel> verses;
      try {
        verses = await _loadVerses();
      } catch (error, stackTrace) {
        ErrorHandler.report(
          error,
          stackTrace,
          message: 'Could not load verses for the reminder',
          context: 'reminder_scheduler.schedule',
          severity: ErrorSeverity.warning,
        );
        verses = const [];
      }

      final now = _clock();
      final plan = planReminders(
        now: now,
        hour: hour,
        minute: minute,
        days: daysAhead,
        verses: verses,
      );
      final ok = await _gateway.scheduleReminders([
        for (final item in plan)
          ReminderNotification(
            when: item.when,
            title: item.verse?.reference ?? fallbackTitle,
            body: item.verse?.text ?? fallbackBody,
          ),
      ]);
      if (ok) _lastRefreshAt = now;
      return ok;
    });
  }

  /// Re-reads the saved reminder settings and brings the scheduled
  /// notifications in line with them (removing them if the reminder is off).
  /// A routine top-up ([force] false) is skipped if one ran very recently.
  Future<bool> refresh({
    required String fallbackTitle,
    required String fallbackBody,
    bool force = true,
  }) async {
    final last = _lastRefreshAt;
    if (!force &&
        last != null &&
        _clock().difference(last) < minRefreshInterval) {
      return true;
    }

    final bool enabled;
    final int hour;
    final int minute;
    try {
      final prefs = await SharedPreferences.getInstance();
      enabled = prefs.getBool(AppConstants.prefNotificationsEnabled) ?? false;
      hour = prefs.getInt(AppConstants.prefReminderHour) ?? 8;
      minute = prefs.getInt(AppConstants.prefReminderMinute) ?? 0;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Could not read reminder settings',
        context: 'reminder_scheduler.refresh',
        severity: ErrorSeverity.warning,
      );
      return false;
    }

    if (!enabled) {
      await cancel();
      return true;
    }
    return schedule(
      hour: hour,
      minute: minute,
      fallbackTitle: fallbackTitle,
      fallbackBody: fallbackBody,
    );
  }

  /// Removes every pending reminder.
  Future<void> cancel() {
    return _serialized(() async {
      _lastRefreshAt = null;
      await _gateway.cancelReminders();
    });
  }
}
