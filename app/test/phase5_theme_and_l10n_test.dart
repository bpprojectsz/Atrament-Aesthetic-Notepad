import 'package:atrament/core/utils/app_localization_setup.dart';
import 'package:atrament/core/utils/app_theme.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;
import 'package:flutter_test/flutter_test.dart';

Future<Color?> _scaffoldColor(WidgetTester tester, AppThemeMode mode) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(mode),
      home: const AppScaffold(body: SizedBox.shrink()),
    ),
  );
  return tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor;
}

void main() {
  group('theme carries the real mode', () {
    test('each mode is built with its own extension', () {
      for (final mode in AppThemeMode.values) {
        expect(buildAppTheme(mode).extension<AtramentTheme>()?.mode, mode);
      }
    });

    test('parchment is a light theme, dark is dark', () {
      expect(buildAppTheme(AppThemeMode.parchment).brightness, Brightness.light);
      expect(buildAppTheme(AppThemeMode.light).brightness, Brightness.light);
      expect(buildAppTheme(AppThemeMode.dark).brightness, Brightness.dark);
    });

    testWidgets('context.appMode reports parchment, not just "light"', (
      tester,
    ) async {
      AppThemeMode? seen;
      await tester.pumpWidget(
        MaterialApp(
          theme: buildAppTheme(AppThemeMode.parchment),
          home: Builder(
            builder: (context) {
              seen = context.appMode;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(seen, AppThemeMode.parchment);
    });

    testWidgets('without the extension it falls back to light/dark', (
      tester,
    ) async {
      AppThemeMode? seen;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: Builder(
            builder: (context) {
              seen = context.appMode;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(seen, AppThemeMode.dark);
    });

    testWidgets('screens actually draw Parchment colors, and Light/Dark are unchanged', (
      tester,
    ) async {
      expect(await _scaffoldColor(tester, AppThemeMode.parchment),
          AppColors.bgPrimary.parchment);
      expect(await _scaffoldColor(tester, AppThemeMode.light),
          AppColors.bgPrimary.light);
      expect(await _scaffoldColor(tester, AppThemeMode.dark),
          AppColors.bgPrimary.dark);
      expect(AppColors.bgPrimary.parchment, isNot(AppColors.bgPrimary.light),
          reason: 'otherwise this test could not tell the themes apart');
    });
  });

  group('localization delegates', () {
    test('include flutter_quill\'s', () {
      expect(appLocalizationsDelegates, contains(FlutterQuillLocalizations.delegate));
      for (final delegate in AppLocalizations.localizationsDelegates) {
        expect(appLocalizationsDelegates, contains(delegate));
      }
    });

    testWidgets('Quill can find its translations in every app language', (
      tester,
    ) async {
      for (final locale in AppLocalizations.supportedLocales) {
        FlutterQuillLocalizations? found;
        await tester.pumpWidget(
          MaterialApp(
            locale: locale,
            localizationsDelegates: appLocalizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) {
                found = FlutterQuillLocalizations.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(found, isNotNull, reason: 'locale ${locale.languageCode}');
      }
    });
  });
}
