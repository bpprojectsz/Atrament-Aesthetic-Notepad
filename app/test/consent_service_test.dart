import 'package:atrament/platform/consent_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class _FakeConsentInfo implements ConsentInformation {
  bool canRequest = true;
  bool canRequestThrows = false;
  bool privacyThrows = false;
  bool updateFails = false;
  PrivacyOptionsRequirementStatus privacy =
      PrivacyOptionsRequirementStatus.notRequired;
  int updates = 0;

  @override
  void requestConsentInfoUpdate(
    ConsentRequestParameters params,
    OnConsentInfoUpdateSuccessListener successListener,
    OnConsentInfoUpdateFailureListener failureListener,
  ) {
    updates++;
    if (updateFails) {
      failureListener(FormError(errorCode: 1, message: 'offline'));
    } else {
      successListener();
    }
  }

  @override
  Future<bool> canRequestAds() async {
    if (canRequestThrows) throw StateError('no answer');
    return canRequest;
  }

  @override
  Future<PrivacyOptionsRequirementStatus> getPrivacyOptionsRequirementStatus() async {
    if (privacyThrows) throw StateError('no answer');
    return privacy;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('consentOutcome (the decision, every combination)', () {
    test('Google says yes: request ads, no retry', () {
      expect(
        consentOutcome(canRequestAds: true, privacyOptionsRequired: false),
        const ConsentOutcome(
          requestAds: true,
          retryOnForeground: false,
          showPrivacyChoices: false,
        ),
      );
    });

    test('Google says no (also after a decline): no ads, no retry', () {
      expect(
        consentOutcome(canRequestAds: false, privacyOptionsRequired: true),
        const ConsentOutcome(
          requestAds: false,
          retryOnForeground: false,
          showPrivacyChoices: true,
        ),
      );
    });

    test('the answer cannot be read: ads allowed, retry once', () {
      expect(
        consentOutcome(canRequestAds: null, privacyOptionsRequired: null),
        const ConsentOutcome(
          requestAds: true,
          retryOnForeground: true,
          showPrivacyChoices: false,
        ),
      );
    });

    test('the answer cannot be read on the retry either: allowed, no more retries',
        () {
      final outcome = consentOutcome(
        canRequestAds: null,
        privacyOptionsRequired: null,
        isRetry: true,
      );

      expect(outcome.requestAds, isTrue);
      expect(outcome.retryOnForeground, isFalse);
    });

    test('an unreadable privacy status keeps the previous row state', () {
      expect(
        consentOutcome(
          canRequestAds: true,
          privacyOptionsRequired: null,
          previousShowPrivacyChoices: true,
        ).showPrivacyChoices,
        isTrue,
      );
      expect(
        consentOutcome(
          canRequestAds: true,
          privacyOptionsRequired: null,
        ).showPrivacyChoices,
        isFalse,
      );
    });

    test('invariants hold for all 36 inputs', () {
      for (final can in <bool?>[true, false, null]) {
        for (final priv in <bool?>[true, false, null]) {
          for (final previous in [true, false]) {
            for (final retry in [true, false]) {
              final o = consentOutcome(
                canRequestAds: can,
                privacyOptionsRequired: priv,
                previousShowPrivacyChoices: previous,
                isRetry: retry,
              );
              final label = 'can=$can priv=$priv prev=$previous retry=$retry';
              if (can != null) {
                expect(o.requestAds, can, reason: label);
                expect(o.retryOnForeground, isFalse, reason: label);
              } else {
                expect(o.requestAds, isTrue, reason: label);
                expect(o.retryOnForeground, !retry, reason: label);
              }
              expect(o.showPrivacyChoices, priv ?? previous, reason: label);
            }
          }
        }
      }
    });
  });

  late _FakeConsentInfo info;
  late ConsentService service;

  setUp(() {
    info = _FakeConsentInfo();
    ConsentInformation.instance = info;
    service = ConsentService.forTesting();
  });

  // The consent *form* itself is a native screen and is not available in
  // unit tests; the service must treat that as a normal failure and still
  // answer from the stored consent state.

  test('ads are allowed when consent is not blocking them', () async {
    expect(await service.gatherConsent(), isTrue);
    expect(info.updates, 1);
  });

  test('ads are NOT allowed when the user has not consented', () async {
    info.canRequest = false;

    expect(await service.gatherConsent(), isFalse);
  });

  test('an update failure still falls back to the stored consent answer', () async {
    info.updateFails = true;
    info.canRequest = true;
    expect(await service.gatherConsent(), isTrue);

    info.canRequest = false;
    expect(await service.gatherConsent(), isFalse,
        reason: 'no go-ahead means no ads, never a default yes');
  });

  test('an unreadable answer means ads are allowed, with one retry owed',
      () async {
    info.canRequestThrows = true;

    expect(await service.gatherConsent(), isTrue);
    expect(service.retryPending, isTrue);
  });

  test('a clear answer never owes a retry', () async {
    await service.gatherConsent();
    expect(service.retryPending, isFalse);

    info.canRequest = false;
    await service.gatherConsent();
    expect(service.retryPending, isFalse);
  });

  group('the one foreground retry', () {
    test('nothing is owed, so nothing happens', () async {
      await service.gatherConsent();
      final updatesBefore = info.updates;

      expect(await service.retryIfNeeded(), isNull);
      expect(info.updates, updatesBefore);
    });

    test('it asks Google again and follows the new answer', () async {
      info.canRequestThrows = true;
      await service.gatherConsent();
      final updatesBefore = info.updates;

      info.canRequestThrows = false;
      info.canRequest = false;
      expect(await service.retryIfNeeded(), isFalse);
      expect(info.updates, updatesBefore + 1);
      expect(service.retryPending, isFalse);
    });

    test('it happens only once, even if it fails again', () async {
      info.canRequestThrows = true;
      await service.gatherConsent();

      expect(await service.retryIfNeeded(), isTrue,
          reason: 'still unreadable: ads stay allowed');
      expect(service.retryPending, isFalse);
      expect(await service.retryIfNeeded(), isNull);
    });
  });

  test('an unreadable privacy status keeps the row as it was', () async {
    info.privacy = PrivacyOptionsRequirementStatus.required;
    await service.gatherConsent();
    expect(service.privacyOptionsRequired.value, isTrue);

    info.privacyThrows = true;
    await service.refreshState();

    expect(service.privacyOptionsRequired.value, isTrue);
  });

  test('the privacy-choices entry appears only when required', () async {
    await service.gatherConsent();
    expect(service.privacyOptionsRequired.value, isFalse);

    info.privacy = PrivacyOptionsRequirementStatus.required;
    await service.gatherConsent();
    expect(service.privacyOptionsRequired.value, isTrue);

    info.privacy = PrivacyOptionsRequirementStatus.notRequired;
    await service.refreshState();
    expect(service.privacyOptionsRequired.value, isFalse);
  });
}
