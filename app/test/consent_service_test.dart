import 'package:atrament/platform/consent_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class _FakeConsentInfo implements ConsentInformation {
  bool canRequest = true;
  bool canRequestThrows = false;
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
  Future<PrivacyOptionsRequirementStatus> getPrivacyOptionsRequirementStatus() async =>
      privacy;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  test('never throws, and answers "no ads" if the consent state cannot be read', () async {
    info.canRequestThrows = true;

    expect(await service.gatherConsent(), isFalse);
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
