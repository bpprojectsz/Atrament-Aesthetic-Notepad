import 'package:atrament/core/models/verse_model.dart';
import 'package:atrament/core/providers/locale_provider.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/providers/subscription_provider.dart';
import 'package:atrament/core/providers/theme_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/core/services/app_lock.dart';
import 'package:atrament/core/services/iap_service.dart';
import 'package:atrament/core/services/reminder_scheduler.dart';
import 'package:atrament/core/utils/app_localization_setup.dart';
import 'package:atrament/core/utils/locale_utils.dart';
import 'package:atrament/core/utils/route_observer.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/platform/notification_service.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:atrament/screens/premium_screen.dart';
import 'package:atrament/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FontLoader, rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/controlled_storage.dart';
import 'helpers/fake_biometrics.dart';
import 'helpers/fake_store.dart';

/// Draws the main screens in every language on a narrow phone with enlarged
/// text, and fails on any layout overflow or error. Direction is checked too.
/// This catches long translations that do not fit; it cannot judge how the
/// glyphs look, which needs a real device.

class _FakeNotifications extends NotificationService {
  _FakeNotifications() : super.forTesting();

  @override
  Future<bool> requestPermission() async => true;
}

class _FakeGateway implements ReminderGateway {
  @override
  Future<bool> scheduleReminders(List<ReminderNotification> reminders) async =>
      true;

  @override
  Future<void> cancelReminders() async {}
}

const double _phoneWidth = 360;
const double _textScale = 1.3;

/// The test font draws every character as a full square, about twice as wide
/// as real text. Latin, Cyrillic and Greek use the real bundled Inter font so
/// their widths are right. Scripts the app has no font for fall back to the
/// square font, so their size is scaled by [_fallbackWidthFactor] to
/// approximate real glyph widths (Chinese, Japanese and Korean really are
/// about that wide).
double _fallbackWidthFactor(Locale locale) {
  switch (locale.languageCode) {
    case 'ja':
    case 'zh':
    case 'ko':
      return 1.0;
    case 'ar':
    case 'fa':
    case 'ur':
    case 'he':
    case 'hi':
    case 'mr':
    case 'bn':
    case 'ta':
    case 'te':
    case 'gu':
    case 'th':
      return 0.6;
    default:
      return 1.0;
  }
}

Future<void> _pump(WidgetTester tester, [int ms = 600]) async {
  var elapsed = 0;
  while (elapsed < ms) {
    await tester.pump(const Duration(milliseconds: 50));
    elapsed += 50;
  }
}

Widget _app(Locale locale, Widget home) {
  return MaterialApp(
    theme: ThemeData(fontFamily: 'Inter'),
    locale: locale,
    navigatorObservers: [appRouteObserver],
    localizationsDelegates: appLocalizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(
        textScaler: TextScaler.linear(_textScale * _fallbackWidthFactor(locale)),
      ),
      child: child!,
    ),
    home: home,
  );
}

/// Runs [body] and returns every framework error it raised.
Future<List<String>> _collectErrors(Future<void> Function() body) async {
  final errors = <String>[];
  final previous = FlutterError.onError;
  FlutterError.onError = (details) {
    final text = details.toString();
    final where = RegExp(
      r'(Row|Column|Flex)[^\n]*?(lib/[A-Za-z0-9_/]+\.dart:\d+)',
    ).firstMatch(text)?.group(2);
    errors.add(
      '${details.exceptionAsString().split('\n').first}'
      '${where == null ? '' : ' [$where]'}',
    );
  };
  try {
    await body();
  } finally {
    FlutterError.onError = previous;
  }
  return errors;
}

void _phone(WidgetTester tester, {double height = 740}) {
  tester.view.physicalSize = Size(_phoneWidth * 3, height * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

void main() {
  final languages = pickerLocales(AppLocalizations.supportedLocales);

  setUpAll(() async {
    final loader = FontLoader('Inter')
      ..addFont(rootBundle.load('assets/fonts/Inter-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Inter-Bold.ttf'));
    await loader.load();
  });

  tearDown(() => AppLock.instance = AppLock());

  for (final locale in languages) {
    final tag = localeTag(locale);
    final l10n = lookupAppLocalizations(locale);
    final rtl = rtlLanguageCodes.contains(locale.languageCode);

    group(tag, () {
      testWidgets('Settings fits on a narrow phone', (tester) async {
        SharedPreferences.setMockInitialValues({});
        AppLock.instance = AppLock(biometrics: FakeBiometrics());
        final subscription = SubscriptionProvider(
          iapService: IapService.forTesting(iap: FakeStore(), isAndroid: false),
        );
        await subscription.init();
        ReminderScheduler.instance = ReminderScheduler(
          gateway: _FakeGateway(),
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
        NotificationService.instance = _FakeNotifications();
        _phone(tester, height: 5200); // tall: every row gets built

        final errors = await _collectErrors(() async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<LocaleProvider>.value(value: LocaleProvider()),
                Provider<ThemeProvider>.value(value: ThemeProvider()),
                Provider<VerseProvider>.value(value: VerseProvider()),
                Provider<SubscriptionProvider>.value(value: subscription),
              ],
              child: _app(locale, const SettingsScreen()),
            ),
          );
          await _pump(tester);
        });

        expect(errors, isEmpty, reason: '$tag Settings: $errors');
        expect(find.text(l10n.settingsTitle), findsWidgets);
        final context = tester.element(find.byType(SettingsScreen));
        expect(
          Directionality.of(context),
          rtl ? TextDirection.rtl : TextDirection.ltr,
        );
      });

      testWidgets('Premium fits on a narrow phone', (tester) async {
        SharedPreferences.setMockInitialValues({});
        final subscription = SubscriptionProvider(
          iapService: IapService.forTesting(iap: FakeStore(), isAndroid: false),
        );
        await subscription.init();
        _phone(tester);

        final errors = await _collectErrors(() async {
          await tester.pumpWidget(
            _app(locale, PremiumScreen(subscriptionProvider: subscription)),
          );
          await _pump(tester);
        });

        expect(errors, isEmpty, reason: '$tag Premium: $errors');
        expect(find.text(l10n.premiumScreenTitle), findsWidgets);
      });

      testWidgets('Home fits on a narrow phone', (tester) async {
        SharedPreferences.setMockInitialValues({});
        AppLock.instance = AppLock(biometrics: FakeBiometrics());
        final storage = ControlledStorage()
          ..allNotes = [
            testNote('a', l10n.untitledNote),
            testNote('b', l10n.emptyAllNotesTitle),
          ];
        final notes = NoteProvider(storage: storage);
        final notebooks = NotebookProvider(storage: storage);
        final subscription = SubscriptionProvider();
        _phone(tester);

        final errors = await _collectErrors(() async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<VerseProvider>.value(value: VerseProvider()),
                Provider<SubscriptionProvider>.value(value: subscription),
              ],
              child: _app(
                locale,
                HomeScreen(
                  notebookProvider: notebooks,
                  noteProvider: notes,
                  subscriptionProvider: subscription,
                ),
              ),
            ),
          );
          await _pump(tester);
        });

        expect(errors, isEmpty, reason: '$tag Home: $errors');
        expect(find.text(l10n.chipAll), findsWidgets);
        expect(find.text(l10n.chipNotebooks), findsWidgets);
        expect(find.text(l10n.chipRecent), findsWidgets);
      });
    });
  }
}
