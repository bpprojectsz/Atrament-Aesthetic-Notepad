import 'dart:async';

import 'package:atrament/core/models/verse_model.dart';
import 'package:atrament/core/services/reminder_scheduler.dart';
import 'package:atrament/core/services/verse_service.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<VerseModel> _pool(int n) => [
  for (var i = 0; i < n; i++)
    VerseModel(
      reference: 'Book $i:1',
      text: 'Verse number $i',
      translation: 'KJV',
      themeCategory: 'peace',
    ),
];

class _FakeGateway implements ReminderGateway {
  final List<List<ReminderNotification>> scheduled = [];
  int cancelCalls = 0;
  bool succeed = true;
  Duration delay = Duration.zero;
  final List<String> log = [];

  @override
  Future<bool> scheduleReminders(List<ReminderNotification> reminders) async {
    log.add('schedule:start');
    if (delay > Duration.zero) await Future<void>.delayed(delay);
    scheduled.add(reminders);
    log.add('schedule:end');
    return succeed;
  }

  @override
  Future<void> cancelReminders() async {
    log.add('cancel');
    cancelCalls++;
  }
}

void main() {
  group('planReminders', () {
    final pool = _pool(500);

    test('starts today when the time is still ahead', () {
      final plan = planReminders(
        now: DateTime(2026, 10, 15, 7, 0),
        hour: 8,
        minute: 30,
        days: 3,
        verses: pool,
      );

      expect(plan.map((p) => p.when), [
        DateTime(2026, 10, 15, 8, 30),
        DateTime(2026, 10, 16, 8, 30),
        DateTime(2026, 10, 17, 8, 30),
      ]);
    });

    test('starts tomorrow when the time has passed, or is right now', () {
      for (final now in [DateTime(2026, 10, 15, 9, 0), DateTime(2026, 10, 15, 8, 30)]) {
        final plan = planReminders(now: now, hour: 8, minute: 30, days: 2, verses: pool);
        expect(plan.first.when, DateTime(2026, 10, 16, 8, 30), reason: '$now');
      }
    });

    test('schedules 14 consecutive days, keeping the chosen time', () {
      final plan = planReminders(
        now: DateTime(2026, 10, 15, 12, 0),
        hour: 6,
        minute: 5,
        days: 14,
        verses: pool,
      );

      expect(plan, hasLength(14));
      for (var i = 0; i < 14; i++) {
        expect(plan[i].when, DateTime(2026, 10, 16 + i, 6, 5));
      }
    });

    test('rolls over month and year ends', () {
      final plan = planReminders(
        now: DateTime(2026, 12, 30, 12, 0),
        hour: 8,
        minute: 0,
        days: 4,
        verses: pool,
      );

      expect(plan.map((p) => p.when), [
        DateTime(2026, 12, 31, 8, 0),
        DateTime(2027, 1, 1, 8, 0),
        DateTime(2027, 1, 2, 8, 0),
        DateTime(2027, 1, 3, 8, 0),
      ]);
    });

    test('each reminder carries the verse of its OWN day', () {
      final plan = planReminders(
        now: DateTime(2026, 10, 15, 12, 0),
        hour: 8,
        minute: 0,
        days: 5,
        verses: pool,
      );

      for (final item in plan) {
        expect(item.verse, VerseService.verseForDateIn(pool, item.when));
      }
      expect(plan.map((p) => p.verse).toSet().length, 5,
          reason: 'not the same verse every morning');
    });

    test('without a verse pool the reminders still exist (with no verse)', () {
      final plan = planReminders(
        now: DateTime(2026, 10, 15, 12, 0),
        hour: 8,
        minute: 0,
        days: 3,
        verses: const [],
      );

      expect(plan, hasLength(3));
      expect(plan.every((p) => p.verse == null), isTrue);
    });
  });

  group('ReminderScheduler', () {
    late _FakeGateway gateway;
    late DateTime now;

    ReminderScheduler make({List<VerseModel>? verses}) => ReminderScheduler(
      gateway: gateway,
      loadVerses: () async => verses ?? _pool(500),
      clock: () => now,
    );

    setUp(() {
      gateway = _FakeGateway();
      now = DateTime(2026, 10, 15, 12, 0);
      SharedPreferences.setMockInitialValues({});
    });

    test('schedules 14 reminders whose text is that day\'s verse', () async {
      final ok = await make().schedule(
        hour: 8,
        minute: 0,
        fallbackTitle: 'Atrament',
        fallbackBody: 'Your daily verse is ready.',
      );

      expect(ok, isTrue);
      final sent = gateway.scheduled.single;
      expect(sent, hasLength(ReminderScheduler.daysAhead));
      final pool = _pool(500);
      for (final r in sent) {
        final verse = VerseService.verseForDateIn(pool, r.when)!;
        expect(r.title, verse.reference);
        expect(r.body, verse.text);
      }
      expect(sent.map((r) => r.body).toSet().length, sent.length,
          reason: 'a different verse each day');
    });

    test('uses the generic text when verses could not be loaded', () async {
      await make(verses: const []).schedule(
        hour: 8,
        minute: 0,
        fallbackTitle: 'Atrament',
        fallbackBody: 'Your daily verse is ready.',
      );

      final sent = gateway.scheduled.single;
      expect(sent, hasLength(ReminderScheduler.daysAhead));
      expect(sent.every((r) => r.title == 'Atrament'), isTrue);
      expect(sent.every((r) => r.body == 'Your daily verse is ready.'), isTrue);
    });

    test('reports failure when the system refuses', () async {
      gateway.succeed = false;

      final ok = await make().schedule(
        hour: 8,
        minute: 0,
        fallbackTitle: 't',
        fallbackBody: 'b',
      );

      expect(ok, isFalse);
    });

    test('refresh removes the reminders when the reminder is off', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefNotificationsEnabled: false,
      });

      final ok = await make().refresh(fallbackTitle: 't', fallbackBody: 'b');

      expect(ok, isTrue);
      expect(gateway.cancelCalls, 1);
      expect(gateway.scheduled, isEmpty);
    });

    test('refresh reschedules using the saved time when the reminder is on', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefNotificationsEnabled: true,
        AppConstants.prefReminderHour: 6,
        AppConstants.prefReminderMinute: 45,
      });

      await make().refresh(fallbackTitle: 't', fallbackBody: 'b');

      final sent = gateway.scheduled.single;
      expect(sent.first.when, DateTime(2026, 10, 16, 6, 45));
    });

    test('refresh defaults to 08:00 when no time was ever saved', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefNotificationsEnabled: true,
      });

      await make().refresh(fallbackTitle: 't', fallbackBody: 'b');

      expect(gateway.scheduled.single.first.when, DateTime(2026, 10, 16, 8, 0));
    });

    test('routine top-ups are skipped if one just ran, but forced ones are not', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefNotificationsEnabled: true,
      });
      final scheduler = make();

      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b');
      expect(gateway.scheduled, hasLength(1));

      now = now.add(const Duration(minutes: 10));
      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b', force: false);
      expect(gateway.scheduled, hasLength(1), reason: 'too soon');

      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b');
      expect(gateway.scheduled, hasLength(2), reason: 'forced');

      now = now.add(ReminderScheduler.minRefreshInterval);
      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b', force: false);
      expect(gateway.scheduled, hasLength(3), reason: 'long enough ago');
    });

    test('cancel clears the throttle so the next top-up runs', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefNotificationsEnabled: true,
      });
      final scheduler = make();
      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b');
      await scheduler.cancel();

      await scheduler.refresh(fallbackTitle: 't', fallbackBody: 'b', force: false);

      expect(gateway.scheduled, hasLength(2));
    });

    test('overlapping requests run one after the other, never interleaved', () async {
      gateway.delay = const Duration(milliseconds: 30);
      final scheduler = make();

      await Future.wait([
        scheduler.schedule(hour: 8, minute: 0, fallbackTitle: 't', fallbackBody: 'b'),
        scheduler.schedule(hour: 9, minute: 0, fallbackTitle: 't', fallbackBody: 'b'),
        scheduler.cancel(),
      ]);

      expect(gateway.log, [
        'schedule:start',
        'schedule:end',
        'schedule:start',
        'schedule:end',
        'cancel',
      ]);
      expect(gateway.scheduled.first.first.when.hour, 8);
      expect(gateway.scheduled.last.first.when.hour, 9);
    });

    test('a failed job does not block the jobs after it', () async {
      final scheduler = ReminderScheduler(
        gateway: gateway,
        loadVerses: () async => throw StateError('assets missing'),
        clock: () => now,
      );

      final ok = await scheduler.schedule(
        hour: 8,
        minute: 0,
        fallbackTitle: 'Atrament',
        fallbackBody: 'Your daily verse is ready.',
      );

      expect(ok, isTrue, reason: 'falls back to the generic text');
      expect(gateway.scheduled.single.first.title, 'Atrament');
    });
  });
}
