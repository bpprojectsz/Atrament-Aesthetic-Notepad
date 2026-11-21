import 'package:atrament/platform/interstitial_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final service = InterstitialService.instance;

  group('5-minute gap rule', () {
    final now = DateTime(2026, 11, 21, 12, 0, 0);

    test('no earlier ad means the gap has elapsed', () {
      expect(InterstitialService.gapElapsed(now, null), isTrue);
    });

    test('4 min 59 s after the last ad is too soon', () {
      final last = now.subtract(const Duration(minutes: 4, seconds: 59));
      expect(
        InterstitialService.gapElapsed(now, last.millisecondsSinceEpoch),
        isFalse,
      );
    });

    test('exactly 5 minutes is enough', () {
      final last = now.subtract(const Duration(minutes: 5));
      expect(
        InterstitialService.gapElapsed(now, last.millisecondsSinceEpoch),
        isTrue,
      );
    });

    test('a clock that moved backwards never blocks ads', () {
      final last = now.add(const Duration(hours: 3));
      expect(
        InterstitialService.gapElapsed(now, last.millisecondsSinceEpoch),
        isTrue,
      );
    });
  });

  group('one combined counter', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service.resetCountersForTesting();
    });

    test('save, create, export and delete all count', () async {
      await service.recordNoteSave();
      await service.recordNoteCreate();
      await service.showAfterExport();
      await service.showAfterNotebookDelete();

      expect(service.pendingActionCount, 4);
    });

    test('the 9th action of any mix resets the counter', () async {
      for (var i = 0; i < 4; i++) {
        await service.recordNoteSave();
      }
      for (var i = 0; i < 4; i++) {
        await service.showAfterExport();
      }
      expect(service.pendingActionCount, 8);

      await service.showAfterNotebookDelete();

      expect(service.pendingActionCount, 0);
    });
  });

  group('persistence across restarts', () {
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

    test('the 9th action after a restart resets the saved count', () async {
      SharedPreferences.setMockInitialValues({
        InterstitialService.prefActionCount: 8,
      });
      service.simulateRestartForTesting();

      await service.showAfterExport();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(InterstitialService.prefActionCount), 0);
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
