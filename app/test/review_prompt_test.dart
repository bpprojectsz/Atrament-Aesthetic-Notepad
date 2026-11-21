import 'dart:async';

import 'package:atrament/core/services/engagement_service.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/platform/interstitial_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final day1 = DateTime(2026, 11, 1, 10, 0);

  group('reviewDue (the rule)', () {
    bool due({
      int saves = 20,
      int days = 3,
      int? lastMs,
      DateTime? now,
    }) =>
        EngagementService.reviewDue(
          saveCount: saves,
          daysWithSaves: days,
          now: now ?? day1,
          lastPromptMs: lastMs,
        );

    test('19 saves is not enough, 20 is', () {
      expect(due(saves: 19), isFalse);
      expect(due(saves: 20), isTrue);
    });

    test('two days of use is not enough, three is', () {
      expect(due(days: 2), isFalse);
      expect(due(days: 3), isTrue);
    });

    test('60 days must pass after our last attempt', () {
      final last = day1.subtract(const Duration(days: 59, hours: 23));
      expect(due(lastMs: last.millisecondsSinceEpoch), isFalse);

      final enough = day1.subtract(const Duration(days: 60));
      expect(due(lastMs: enough.millisecondsSinceEpoch), isTrue);
    });

    test('a last attempt in the future (clock moved back) never blocks', () {
      final future = day1.add(const Duration(days: 30));
      expect(due(lastMs: future.millisecondsSinceEpoch), isTrue);
    });
  });

  group('review prompt in use', () {
    late DateTime now;
    late int requests;
    late bool available;
    late EngagementService service;
    final ads = InterstitialService.instance;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      now = day1;
      requests = 0;
      available = true;
      ads.resetCountersForTesting();
      ads.clockForTesting = () => now;
      service = EngagementService.forTesting(
        reviewAvailable: () async => available,
        requestReview: () async => requests++,
        clock: () => now,
      );
    });

    tearDown(ads.resetCountersForTesting);

    Future<void> saves(int n) async {
      for (var i = 0; i < n; i++) {
        await service.recordNoteSave();
      }
    }

    test('20 saves on 3 different days asks once, on the 20th save', () async {
      await saves(7); // day 1
      now = day1.add(const Duration(days: 1));
      await saves(7); // day 2
      now = day1.add(const Duration(days: 2));
      await saves(5); // day 3, 19 saves in total
      expect(requests, 0);

      await saves(1);

      expect(requests, 1);
    });

    test('20 saves in a single day never asks', () async {
      await saves(40);

      expect(requests, 0);
    });

    test('it counts days of use, not days since install', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefInstallDate:
            day1.subtract(const Duration(days: 90)).millisecondsSinceEpoch,
      });
      await saves(40); // one day only, although installed long ago

      expect(requests, 0);
    });

    test('no second ask within 60 days, a second one after', () async {
      await saves(7);
      now = day1.add(const Duration(days: 1));
      await saves(7);
      now = day1.add(const Duration(days: 2));
      await saves(6);
      expect(requests, 1);

      now = day1.add(const Duration(days: 40));
      await saves(10);
      expect(requests, 1);

      now = day1.add(const Duration(days: 63));
      await saves(1);
      expect(requests, 2);
    });

    test('a device without the review sheet records the attempt only',
        () async {
      available = false;
      await saves(7);
      now = day1.add(const Duration(days: 1));
      await saves(7);
      now = day1.add(const Duration(days: 2));
      await saves(6);

      expect(requests, 0);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(AppConstants.prefLastReviewPrompt), isNotNull);
    });

    Future<void> reachThreshold() async {
      await saves(7);
      now = day1.add(const Duration(days: 1));
      await saves(7);
      now = day1.add(const Duration(days: 2));
      await saves(5);
    }

    test('an ad shown 5 minutes ago holds the review back, nothing recorded',
        () async {
      await reachThreshold();
      SharedPreferences.setMockInitialValues({
        ...(await _currentPrefs()),
        InterstitialService.prefLastShownMs:
            now.subtract(const Duration(minutes: 5)).millisecondsSinceEpoch,
      });
      ads.simulateRestartForTesting();
      ads.clockForTesting = () => now;

      await saves(1);

      expect(requests, 0);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(AppConstants.prefLastReviewPrompt), isNull);
    });

    test('once 10 minutes have passed since the ad, the review is asked',
        () async {
      await reachThreshold();
      SharedPreferences.setMockInitialValues({
        ...(await _currentPrefs()),
        InterstitialService.prefLastShownMs:
            now.subtract(const Duration(minutes: 5)).millisecondsSinceEpoch,
      });
      ads.simulateRestartForTesting();
      ads.clockForTesting = () => now;
      await saves(1);
      expect(requests, 0);

      now = now.add(const Duration(minutes: 6)); // 11 minutes after the ad
      await saves(1);

      expect(requests, 1);
    });

    test('an ad loading right now holds the review back', () async {
      await reachThreshold();
      final release = Completer<bool>();
      ads.showAttemptForTesting = () => release.future;
      // Fill the counter: the 9th action starts an attempt that waits.
      final nineActions = <Future<void>>[];
      for (var i = 0; i < InterstitialService.actionThreshold; i++) {
        nineActions.add(ads.recordNoteSave());
      }
      await Future<void>.delayed(Duration.zero);

      await saves(1);
      expect(requests, 0);

      release.complete(false);
      await Future.wait(nineActions);
    });

    test('after the review sheet an ad waits 10 minutes', () async {
      await reachThreshold();
      await saves(1);
      expect(requests, 1);

      var attempts = 0;
      ads.showAttemptForTesting = () async {
        attempts++;
        return true;
      };
      for (var i = 0; i < InterstitialService.actionThreshold; i++) {
        await ads.recordNoteSave();
      }
      expect(attempts, 0, reason: 'inside 10 minutes of the review sheet');
      expect(ads.isAdPending, isTrue);

      now = now.add(const Duration(minutes: 11));
      await ads.recordNoteSave();

      expect(attempts, 1);
      expect(ads.isAdPending, isFalse);
    });
  });
}

Future<Map<String, Object>> _currentPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return {for (final k in prefs.getKeys()) k: prefs.get(k)!};
}
