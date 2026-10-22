import 'package:atrament/core/models/verse_model.dart';
import 'package:atrament/core/providers/locale_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/providers/theme_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/core/services/iap_service.dart';
import 'package:atrament/core/services/reminder_scheduler.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/platform/biometric_service.dart';
import 'package:atrament/platform/notification_service.dart';
import 'package:atrament/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart' show PurchaseStatus;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_biometrics.dart';
import 'helpers/fake_store.dart';

class _FakeNotifications extends NotificationService {
  _FakeNotifications() : super.forTesting();
  bool granted = true;

  @override
  Future<bool> requestPermission() async => granted;
}

class _FakeGateway implements ReminderGateway {
  final List<List<ReminderNotification>> scheduled = [];
  int cancelCalls = 0;
  bool succeed = true;

  @override
  Future<bool> scheduleReminders(List<ReminderNotification> reminders) async {
    scheduled.add(reminders);
    return succeed;
  }

  @override
  Future<void> cancelReminders() async => cancelCalls++;
}

class _Env {
  _Env({
    required this.bio,
    required this.store,
    required this.gateway,
    required this.notifications,
    required this.subscription,
  });

  final FakeBiometrics bio;
  final FakeStore store;
  final _FakeGateway gateway;
  final _FakeNotifications notifications;
  final SubscriptionProvider subscription;
}

final _l10n = lookupAppLocalizations(const Locale('en'));

Future<void> _pump(WidgetTester tester, [int ms = 500]) async {
  var elapsed = 0;
  while (elapsed < ms) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += 50;
  }
}

Future<_Env> _pumpSettings(
  WidgetTester tester, {
  bool lockEnabled = false,
  bool biometricsSupported = true,
  BiometricAuthResult auth = BiometricAuthResult.success,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues({
    AppConstants.prefBiometricLockEnabled: lockEnabled,
    ...prefs,
  });

  final bio = FakeBiometrics()
    ..supported = biometricsSupported
    ..fallback = auth;
  AppLock.instance = AppLock(biometrics: bio);

  final store = FakeStore();
  final subscription = SubscriptionProvider(
    iapService: IapService.forTesting(iap: store, isAndroid: false),
  );
  await subscription.init();

  final gateway = _FakeGateway();
  ReminderScheduler.instance = ReminderScheduler(
    gateway: gateway,
    loadVerses: () async => [
      for (var i = 0; i < 40; i++)
        VerseModel(
          reference: 'Book $i:1',
          text: 'Verse $i',
          translation: 'KJV',
          themeCategory: 'peace',
        ),
    ],
    clock: () => DateTime(2026, 10, 15, 12),
  );
  final notifications = _FakeNotifications();
  NotificationService.instance = notifications;

  // A tall screen so every row is on screen without scrolling.
  tester.view.physicalSize = const Size(900, 3600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MultiProvider(
      providers: [
        Provider<LocaleProvider>.value(value: LocaleProvider()),
        Provider<ThemeProvider>.value(value: ThemeProvider()),
        Provider<VerseProvider>.value(value: VerseProvider()),
        Provider<SubscriptionProvider>.value(value: subscription),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(),
      ),
    ),
  );
  await _pump(tester);

  return _Env(
    bio: bio,
    store: store,
    gateway: gateway,
    notifications: notifications,
    subscription: subscription,
  );
}

Finder _toggle(String label) => find.widgetWithText(SwitchListTile, label);

bool _isOn(WidgetTester tester, String label) =>
    tester.widget<SwitchListTile>(_toggle(label)).value;

void main() {
  tearDown(() {
    AppLock.instance = AppLock();
  });

  group('note lock toggle', () {
    testWidgets('turning it on asks you to authenticate, then it is on', (
      tester,
    ) async {
      final env = await _pumpSettings(tester);
      expect(_isOn(tester, _l10n.biometricLockToggle), isFalse);

      await tester.tap(_toggle(_l10n.biometricLockToggle));
      await _pump(tester);

      expect(env.bio.prompts, 1);
      expect(_isOn(tester, _l10n.biometricLockToggle), isTrue);
      expect(AppLock.instance.enabled, isTrue);
    });

    testWidgets('a refused authentication leaves it off and says why', (
      tester,
    ) async {
      await _pumpSettings(tester, auth: BiometricAuthResult.failed);

      await tester.tap(_toggle(_l10n.biometricLockToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.biometricLockToggle), isFalse);
      expect(AppLock.instance.enabled, isFalse);
      expect(find.text(_l10n.biometricAuthFailedMessage), findsOneWidget);
    });

    testWidgets('with no screen lock or biometrics set up it cannot be offered', (
      tester,
    ) async {
      await _pumpSettings(tester, biometricsSupported: false);

      expect(find.text(_l10n.biometricLockToggle), findsNothing);
    });

    testWidgets('it stays visible while on even if the device stopped supporting it', (
      tester,
    ) async {
      await _pumpSettings(
        tester,
        lockEnabled: true,
        biometricsSupported: false,
      );

      expect(find.text(_l10n.biometricLockToggle), findsOneWidget,
          reason: 'otherwise the lock could never be removed');
      expect(_isOn(tester, _l10n.biometricLockToggle), isTrue);
    });

    testWidgets('turning it off needs authentication', (tester) async {
      final env = await _pumpSettings(tester, lockEnabled: true);

      await tester.tap(_toggle(_l10n.biometricLockToggle));
      await _pump(tester);

      expect(env.bio.prompts, 1);
      expect(_isOn(tester, _l10n.biometricLockToggle), isFalse);
      expect(AppLock.instance.enabled, isFalse);
    });

    testWidgets('a refused authentication keeps it on', (tester) async {
      await _pumpSettings(
        tester,
        lockEnabled: true,
        auth: BiometricAuthResult.failed,
      );

      await tester.tap(_toggle(_l10n.biometricLockToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.biometricLockToggle), isTrue);
      expect(AppLock.instance.enabled, isTrue);
      expect(find.text(_l10n.biometricAuthFailedMessage), findsOneWidget);
    });

    testWidgets('it can always be turned off when the device cannot authenticate', (
      tester,
    ) async {
      await _pumpSettings(
        tester,
        lockEnabled: true,
        biometricsSupported: false,
        auth: BiometricAuthResult.unavailable,
      );

      await tester.tap(_toggle(_l10n.biometricLockToggle));
      await _pump(tester);

      expect(AppLock.instance.enabled, isFalse);
    });
  });

  group('daily reminder toggle', () {
    testWidgets('refused notification permission leaves it off', (tester) async {
      final env = await _pumpSettings(tester);
      env.notifications.granted = false;

      await tester.tap(_toggle(_l10n.dailyReminderToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.dailyReminderToggle), isFalse);
      expect(find.text(_l10n.notificationPermissionDenied), findsOneWidget);
      expect(env.gateway.scheduled, isEmpty);
    });

    testWidgets('turning it on schedules the next 14 days and remembers it', (
      tester,
    ) async {
      final env = await _pumpSettings(tester);

      await tester.tap(_toggle(_l10n.dailyReminderToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.dailyReminderToggle), isTrue);
      expect(env.gateway.scheduled.single, hasLength(ReminderScheduler.daysAhead));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.prefNotificationsEnabled), isTrue);
    });

    testWidgets('if scheduling fails it stays off and tells you', (tester) async {
      final env = await _pumpSettings(tester);
      env.gateway.succeed = false;

      await tester.tap(_toggle(_l10n.dailyReminderToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.dailyReminderToggle), isFalse);
      expect(find.text(_l10n.reminderScheduleFailedMessage), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.prefNotificationsEnabled), isNot(true),
          reason: 'must not be saved as on when nothing is scheduled');
    });

    testWidgets('turning it off cancels the reminders', (tester) async {
      final env = await _pumpSettings(
        tester,
        prefs: {AppConstants.prefNotificationsEnabled: true},
      );
      expect(_isOn(tester, _l10n.dailyReminderToggle), isTrue);

      await tester.tap(_toggle(_l10n.dailyReminderToggle));
      await _pump(tester);

      expect(_isOn(tester, _l10n.dailyReminderToggle), isFalse);
      expect(env.gateway.cancelCalls, greaterThanOrEqualTo(1));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.prefNotificationsEnabled), isFalse);
    });

    testWidgets('changing the time reschedules', (tester) async {
      final env = await _pumpSettings(
        tester,
        prefs: {
          AppConstants.prefNotificationsEnabled: true,
          AppConstants.prefReminderHour: 8,
          AppConstants.prefReminderMinute: 0,
        },
      );

      await tester.tap(find.text(_l10n.reminderTimeLabel));
      await _pump(tester);
      await tester.tap(find.text('OK'));
      await _pump(tester);

      expect(env.gateway.scheduled, hasLength(1));
      expect(env.gateway.scheduled.single.first.when.hour, 8);
    });
  });

  group('purchases', () {
    testWidgets('Restore says when a purchase was restored', (tester) async {
      final env = await _pumpSettings(tester);
      env.store.onRestore = () =>
          env.store.purchases.add([purchaseDetails(PurchaseStatus.restored)]);

      await tester.tap(find.text(_l10n.restorePurchasesButton));
      await _pump(tester);

      expect(find.text(_l10n.restoreSuccessMessage), findsOneWidget);
    });

    testWidgets('Restore says when there was nothing to restore', (tester) async {
      await _pumpSettings(tester);

      await tester.tap(find.text(_l10n.restorePurchasesButton));
      await _pump(tester, 800);

      expect(find.text(_l10n.restoreNothingFoundMessage), findsOneWidget);
    });

    testWidgets('Restore says when the store could not be reached', (tester) async {
      final env = await _pumpSettings(tester);
      env.store.restoreThrows = true;

      await tester.tap(find.text(_l10n.restorePurchasesButton));
      await _pump(tester);

      expect(find.text(_l10n.restoreFailedMessage), findsOneWidget);
    });
  });

  group('rate row', () {
    testWidgets('says so when the store page cannot be opened', (tester) async {
      await _pumpSettings(tester);

      await tester.tap(find.text(_l10n.rateAppTitle));
      await _pump(tester);

      expect(find.text(_l10n.openLinkFailedMessage), findsOneWidget);
    });
  });
}
