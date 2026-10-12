import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/services/engagement_service.dart';
import 'package:atrament/platform/interstitial_service.dart';
import 'package:atrament/widgets/banner_ad_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/controlled_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('banner retry backoff', () {
    test('retries three times with growing delays, then stops', () {
      expect(bannerRetryDelay(0), const Duration(seconds: 30));
      expect(bannerRetryDelay(1), const Duration(seconds: 60));
      expect(bannerRetryDelay(2), const Duration(seconds: 120));
      expect(bannerRetryDelay(3), isNull);
      expect(bannerRetryDelay(-1), isNull);
    });
  });

  group('App Store ID', () {
    test('the all-zero placeholder counts as "not set"', () {
      expect(
        EngagementService.appStoreIdFromUrl('https://apps.apple.com/app/id0000000000'),
        isNull,
      );
    });

    test('a real ID is extracted from the URL', () {
      expect(
        EngagementService.appStoreIdFromUrl('https://apps.apple.com/app/id1234567890'),
        '1234567890',
      );
      expect(
        EngagementService.appStoreIdFromUrl(
          'https://apps.apple.com/us/app/atrament/id1234567890?mt=8',
        ),
        '1234567890',
      );
    });

    test('a URL without an ID gives null', () {
      expect(EngagementService.appStoreIdFromUrl('https://example.com'), isNull);
    });
  });

  group('what counts toward the interstitial ad counter', () {
    late NoteProvider provider;
    final note = testNote('n1', 'A note');

    setUp(() {
      InterstitialService.instance.resetCountersForTesting();
      provider = NoteProvider(storage: ControlledStorage());
    });

    tearDown(() => provider.dispose());

    test('a normal save counts', () async {
      await provider.saveNote(note, plainTextContent: 'x');

      expect(InterstitialService.instance.pendingSaveCount, 1);
    });

    test('autosave, background saves, renames and moves do not count', () async {
      await provider.saveNote(
        note,
        plainTextContent: 'x',
        countsAsUserSave: false,
      );

      expect(InterstitialService.instance.pendingSaveCount, 0);
    });

    test('only counted saves advance the counter', () async {
      await provider.saveNote(note, plainTextContent: 'x');
      await provider.saveNote(note, plainTextContent: 'x', countsAsUserSave: false);
      await provider.saveNote(note, plainTextContent: 'x');

      expect(InterstitialService.instance.pendingSaveCount, 2);
    });
  });
}
