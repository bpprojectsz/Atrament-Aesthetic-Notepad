import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/providers/note_provider.dart';
import 'core/providers/notebook_provider.dart';
import 'core/providers/subscription_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/verse_provider.dart';
import 'core/utils/constants.dart';
import 'core/utils/error_handler.dart';
import 'platform/admob_service.dart';
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

  // Fire-and-forget platform SDK initialization. Both services degrade
  // gracefully on failure (Sections 7 and 14), so the app proceeds to
  // runApp regardless of outcome.
  unawaited(AdMobService.instance.initialize());
  unawaited(NotificationService.instance.initialize());

  runApp(const AtramentApp());
}

class AtramentApp extends StatefulWidget {
  const AtramentApp({super.key});

  @override
  State<AtramentApp> createState() => _AtramentAppState();
}

class _AtramentAppState extends State<AtramentApp> {
  late final ThemeProvider _themeProvider;
  late final SubscriptionProvider _subscriptionProvider;
  late final NoteProvider _noteProvider;
  late final NotebookProvider _notebookProvider;
  late final VerseProvider _verseProvider;

  @override
  void initState() {
    super.initState();

    _themeProvider = ThemeProvider()..init();
    _subscriptionProvider = SubscriptionProvider()..init();
    _noteProvider = NoteProvider();
    _notebookProvider = NotebookProvider();
    _verseProvider = VerseProvider()..init();

    // ErrorWidget.builder must be set once, ideally after
    // AppLocalizations is available — but ErrorWidget can render before a
    // Localizations ancestor exists (e.g. very early framework errors),
    // so this falls back to plain English rather than crashing on a null
    // AppLocalizations lookup.
    ErrorWidget.builder = _buildErrorWidget;
  }

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

  @override
  void dispose() {
    _themeProvider.dispose();
    _subscriptionProvider.dispose();
    _noteProvider.dispose();
    _notebookProvider.dispose();
    _verseProvider.dispose();
    super.dispose();
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
        Provider<ThemeProvider>.value(value: _themeProvider),
        Provider<SubscriptionProvider>.value(value: _subscriptionProvider),
        Provider<NoteProvider>.value(value: _noteProvider),
        Provider<NotebookProvider>.value(value: _notebookProvider),
        Provider<VerseProvider>.value(value: _verseProvider),
      ],
      child: ListenableBuilder(
        listenable: _themeProvider.mode,
        builder: (context, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
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
