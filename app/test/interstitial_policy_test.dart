import 'package:atrament/platform/interstitial_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final service = InterstitialService.instance;
  final t0 = DateTime(2026, 11, 21, 12, 0, 0);

  Future<void> actions(int n) async {
    for (var i = 0; i < n; i++) {
      await service.recordNoteSave();
    }
  }

  tearDown(() => service.resetCountersForTesting());

  group('9-minute gap rule', () {
    test('the gap is nine minutes', () {
      expect(InterstitialService.minGap, const Duration(minutes: 9));
    });

    test('no earlier ad means the gap has elapsed', () {
      expect(InterstitialService.gapElapsed(t0, null), isTrue);
    });

    test('8 min 59 s after the last ad is too soon', () {
      final last = t0.subtract(const Duration(minutes: 8, seconds: 59));
      expect(
        InterstitialService.gapElapsed(t0, last.millisecondsSinceEpoch),
        isFalse,
      );
    });

    test('exactly 9 minutes is enough', () {
      final last = t0.subtract(const Duration(minutes: 9));
      expect(
        InterstitialService.gapElapsed(t0, last.millisecondsSinceEpoch),
        isTrue,
      );
    });

    test('a clock that moved backwards never blocks ads', () {
      final last = t0.add(const Duration(hours: 3));
      expect(
        InterstitialService.gapElapsed(t0, last.millisecondsSinceEpoch),
        isTrue,
      );
    });
  });

  group('one combined counter', () {
    var attempts = 0;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service.resetCountersForTesting();
      service.clockForTesting = () => t0;
      attempts = 0;
      service.showAttemptForTesting = () async {
        attempts++;
        return true;
      };
    });

    test('every counting point adds one action', () async {
      await service.recordNoteSave();
      await service.recordNoteCreate();
      await service.recordNotebookCreate();
      await service.recordNoteEdit();
      await service.showAfterExport();
      await service.recordNoteShare();
      await service.recordNoteDelete();
      await service.showAfterNotebookDelete();

      expect(service.pendingActionCount, 8);
      expect(attempts, 0);
    });

    test('navigation and editor points count too', () async {
      await service.recordSettingsReturn();
      await service.recordNotebookBack();
      await service.recordPaperStyleChange();

      expect(service.pendingActionCount, 3);
    });

    test('the 9th action of any mix makes the ad due and shows it', () async {
      await actions(4);
      await service.showAfterExport();
      await service.recordNoteDelete();
      await service.recordNoteEdit();
      await service.recordNotebookBack();
      expect(service.pendingActionCount, 8);
      expect(attempts, 0);

      await service.recordSettingsReturn();

      expect(attempts, 1);
      expect(service.isAdPending, isFalse);
      expect(service.pendingActionCount, 0);
    });
  });

  group('pending ad (nothing is wasted)', () {
    var attempts = 0;
    var result = true;
    var clock = t0;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service.resetCountersForTesting();
      clock = t0;
      service.clockForTesting = () => clock;
      attempts = 0;
      result = true;
      service.showAttemptForTesting = () async {
        attempts++;
        return result;
      };
    });

    test('inside the gap the ad waits instead of being dropped', () async {
      final shown = t0.subtract(const Duration(minutes: 3));
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefLastShownMs: shown.millisecondsSinceEpoch,
      });
      service.simulateRestartForTesting();
      service.clockForTesting = () => clock;
      service.showAttemptForTesting = () async {
        attempts++;
        return true;
      };

      await actions(9);

      expect(attempts, 0);
      expect(service.isAdPending, isTrue);
      expect(service.pendingActionCount, 0);
    });

    test('the first action after the gap shows it', () async {
      final shown = t0.subtract(const Duration(minutes: 3));
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefLastShownMs: shown.millisecondsSinceEpoch,
      });
      service.simulateRestartForTesting();
      service.clockForTesting = () => clock;
      service.showAttemptForTesting = () async {
        attempts++;
        return true;
      };
      await actions(9);
      expect(service.isAdPending, isTrue);

      clock = t0.add(const Duration(minutes: 7)); // 10 min after the last ad
      await service.recordNoteDelete();

      expect(attempts, 1);
      expect(service.isAdPending, isFalse);
    });

    test('while an ad is pending the counter does not run on', () async {
      result = false;
      await actions(9);
      expect(service.isAdPending, isTrue);

      await actions(5);

      expect(service.pendingActionCount, 0);
    });

    test('a failed attempt stays pending and retries after 60 s, not before',
        () async {
      result = false;
      await actions(9);
      expect(attempts, 1);

      clock = t0.add(const Duration(seconds: 30));
      await service.recordNoteSave();
      expect(attempts, 1);

      clock = t0.add(const Duration(seconds: 61));
      await service.recordNoteSave();
      expect(attempts, 2);
      expect(service.isAdPending, isTrue);

      result = true;
      clock = t0.add(const Duration(seconds: 130));
      await service.recordNoteSave();
      expect(attempts, 3);
      expect(service.isAdPending, isFalse);
    });
  });

  group('persistence across restarts', () {
    setUp(() => service.resetCountersForTesting());

    test('the counter is saved after every action', () async {
      SharedPreferences.setMockInitialValues({});
      service.resetCountersForTesting();

      await service.recordNoteSave();
      await service.recordNoteCreate();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(InterstitialService.prefActionCount), 2);
    });

    test('a restart continues from the saved count', () async {
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefActionCount: 5,
      });
      service.simulateRestartForTesting();

      await service.recordNoteSave();

      expect(service.pendingActionCount, 6);
    });

    test('a pending ad survives a restart and shows on the next action',
        () async {
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefPending: true,
      });
      service.simulateRestartForTesting();
      var attempts = 0;
      service.clockForTesting = () => t0;
      service.showAttemptForTesting = () async {
        attempts++;
        return true;
      };

      await service.recordNoteSave();

      expect(attempts, 1);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(InterstitialService.prefPending), isFalse);
    });

    test('the 9th action after a restart saves "pending" when nothing shows',
        () async {
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefActionCount: 8,
      });
      service.simulateRestartForTesting();
      service.clockForTesting = () => t0;
      service.showAttemptForTesting = () async => false;

      await service.showAfterExport();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(InterstitialService.prefActionCount), 0);
      expect(prefs.getBool(InterstitialService.prefPending), isTrue);
    });

    test('the time of the last ad is read back after a restart', () async {
      final shown = DateTime(2026, 11, 21, 9, 30);
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefLastShownMs: shown.millisecondsSinceEpoch,
      });
      service.simulateRestartForTesting();

      expect(await service.lastShownAt(), shown);
    });

    test('lastShownAt is null when no ad was ever shown', () async {
      SharedPreferences.setMockInitialValues({});
      service.simulateRestartForTesting();

      expect(await service.lastShownAt(), isNull);
    });
  });
}
