import 'dart:async' show unawaited;

import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/locale_provider.dart';
import 'core/providers/note_provider.dart';
import 'core/providers/notebook_provider.dart';
import 'core/providers/subscription_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/verse_provider.dart';
import 'core/utils/constants.dart';
import 'core/utils/error_handler.dart';
import 'platform/admob_service.dart';
import 'platform/debug_log_service.dart';
import 'platform/notification_service.dart';
import 'screens/home_screen.dart';

/// Locale codes in [AppLocalizations.supportedLocales] that read
/// right-to-left. Flutter's `MaterialApp` already resolves text direction
/// automatically from the active locale via its internal `Localizations`
/// wrapper, but Section 16 calls for an explicit `Directionality` wrapper
/// as a deliverable — this makes the RTL decision visible and overridable
/// in one place rather than relying entirely on framework defaults.
const Set<String> _rtlLanguageCodes = {'ar', 'he'};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global error boundary — must be installed before anything else can
  // throw (Section 15).
  ErrorHandler.install();

  // Persists every reported error to a local file for later export via
  // Settings → Share Debug Log. ErrorHandler stays platform-agnostic
  // (core/); this hook is the one place that connects it to real file
  // I/O (platform/).
  ErrorHandler.reportHook = DebugLogService.instance.appendToLog;

  // ErrorWidget.builder is a global, app-wide hook — it belongs here at
  // real startup, not inside AtramentApp's initState(). Setting it on a
  // widget's lifecycle means every AtramentApp construction (including
  // in widget tests, which build AtramentApp directly without going
  // through main()) mutates global state the test framework doesn't
  // expect and can't clean up, which fails
  // TestWidgetsFlutterBinding's built-in check that ErrorWidget.builder
  // is unchanged after a test.
  ErrorWidget.builder = _buildErrorWidget;

  // Fire-and-forget platform SDK initialization. Both services degrade
  // gracefully on failure (Sections 7 and 14), so the app proceeds to
  // runApp regardless of outcome.
  unawaited(AdMobService.instance.initialize());
  unawaited(NotificationService.instance.initialize());

  runApp(const AtramentApp());
}

/// Fallback UI for any framework error, installed via [ErrorWidget.builder]
/// in [main]. A top-level function rather than a widget-state method, since
/// it needs no instance state and setting it belongs in `main()` (see the
/// comment there).
Widget _buildErrorWidget(FlutterErrorDetails details) {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: AppSpacing.md),
                Text(l10n?.errorGeneric ?? 'Something went wrong'),
                const SizedBox(height: AppSpacing.md),
                FilledButton(
                  onPressed: () {
                    // A full app restart isn't available from here, but
                    // popping back to the previous route (if any) lets
                    // the user retry without a full relaunch.
                    final navigator = Navigator.maybeOf(context);
                    if (navigator != null && navigator.canPop()) {
                      navigator.pop();
                    }
                  },
                  child: Text(l10n?.retry ?? 'Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class AtramentApp extends StatefulWidget {
  const AtramentApp({super.key});

  @override
  State<AtramentApp> createState() => _AtramentAppState();
}

class _AtramentAppState extends State<AtramentApp>
    with WidgetsBindingObserver {
  late final LocaleProvider _localeProvider;
  late final ThemeProvider _themeProvider;
  late final SubscriptionProvider _subscriptionProvider;
  late final NoteProvider _noteProvider;
  late final NotebookProvider _notebookProvider;
  late final VerseProvider _verseProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _localeProvider = LocaleProvider()..init();
    _themeProvider = ThemeProvider()..init();
    _subscriptionProvider = SubscriptionProvider()..init();
    _noteProvider = NoteProvider();
    _notebookProvider = NotebookProvider();
    _verseProvider = VerseProvider()..init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _localeProvider.dispose();
    _themeProvider.dispose();
    _subscriptionProvider.dispose();
    _noteProvider.dispose();
    _notebookProvider.dispose();
    _verseProvider.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _themeProvider.onSystemBrightnessChanged(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  ThemeData _buildTheme(AppThemeMode mode) {
    final brightness = mode == AppThemeMode.dark
        ? Brightness.dark
        : Brightness.light;

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgPrimary.resolve(mode),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent.resolve(mode),
        brightness: brightness,
      ),
      fontFamily: 'Roboto',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocaleProvider>.value(value: _localeProvider),
        Provider<ThemeProvider>.value(value: _themeProvider),
        Provider<SubscriptionProvider>.value(value: _subscriptionProvider),
        Provider<NoteProvider>.value(value: _noteProvider),
        Provider<NotebookProvider>.value(value: _notebookProvider),
        Provider<VerseProvider>.value(value: _verseProvider),
      ],
      child: ListenableBuilder(
        listenable: Listenable.merge([
          _themeProvider.mode,
          _localeProvider.preference,
        ]),
        builder: (context, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            locale: _localeProvider.preference.value,
            theme: _buildTheme(_themeProvider.mode.value),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              final locale = Localizations.localeOf(context);
              final isRtl = _rtlLanguageCodes.contains(locale.languageCode);
              return Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: HomeScreen(
              notebookProvider: _notebookProvider,
              noteProvider: _noteProvider,
              subscriptionProvider: _subscriptionProvider,
            ),
          );
        },
      ),
    );
  }
}
