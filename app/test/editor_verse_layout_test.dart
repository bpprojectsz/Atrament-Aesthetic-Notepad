import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/models/verse_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/verse_provider.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/note_editor_screen.dart';
import 'package:atrament/widgets/note_toolbar.dart';
import 'package:atrament/widgets/scripture_footer.dart';
import 'package:atrament/widgets/scripture_header.dart';
import 'package:atrament/widgets/scripture_watermark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _NoopProvider extends NoteProvider {
  @override
  Future<bool> saveNote(
    NoteModel note, {
    required String plainTextContent,
    bool countsAsUserSave = true,
  }) async => true;
}

Future<void> _openEditor(WidgetTester tester, VerseProvider verse) async {
  final now = DateTime(2026, 1, 1);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: NoteEditorScreen(
        note: NoteModel(
          id: 'n',
          title: 'Title',
          content: r'[{"insert":"Body\n"}]',
          paperStyle: 'cream',
          createdAt: now,
          modifiedAt: now,
        ),
        noteProvider: _NoopProvider(),
        verseProvider: verse,
      ),
    ),
  );
  for (var i = 0; i < 15; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

VerseProvider _verseProvider(VerseDisplayMode mode) {
  final provider = VerseProvider();
  provider.todaysVerse.value = const VerseModel(
    reference: 'Psalm 23:1',
    text: 'The Lord is my shepherd; I shall not want.',
    translation: 'KJV',
    themeCategory: 'comfort',
  );
  provider.displayMode.value = mode;
  return provider;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('header mode puts the verse above the writing area', (tester) async {
    await _openEditor(tester, _verseProvider(VerseDisplayMode.header));

    expect(find.byType(ScriptureHeader), findsOneWidget);
    expect(find.byType(ScriptureFooter), findsNothing);
    expect(find.byType(ScriptureWatermark), findsNothing);

    final header = tester.getRect(find.byType(ScriptureHeader));
    final editor = tester.getRect(find.byType(quill.QuillEditor));
    expect(header.bottom, lessThanOrEqualTo(editor.top + 0.5),
        reason: 'the header must not overlap the text');
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('footer mode puts the verse between the text and the toolbar', (
    tester,
  ) async {
    await _openEditor(tester, _verseProvider(VerseDisplayMode.footer));

    expect(find.byType(ScriptureFooter), findsOneWidget);
    expect(find.byType(ScriptureHeader), findsNothing);

    final footer = tester.getRect(find.byType(ScriptureFooter));
    final editor = tester.getRect(find.byType(quill.QuillEditor));
    final toolbar = tester.getRect(find.byType(NoteToolbar));
    expect(footer.top, greaterThanOrEqualTo(editor.bottom - 0.5),
        reason: 'the footer must not overlap the text');
    expect(toolbar.top, greaterThanOrEqualTo(footer.bottom - 0.5),
        reason: 'the footer must not hide behind the toolbar');
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('watermark mode stays behind the page, with no header or footer', (
    tester,
  ) async {
    await _openEditor(tester, _verseProvider(VerseDisplayMode.watermark));

    expect(find.byType(ScriptureWatermark), findsOneWidget);
    expect(find.byType(ScriptureHeader), findsNothing);
    expect(find.byType(ScriptureFooter), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('off mode shows no verse at all', (tester) async {
    await _openEditor(tester, _verseProvider(VerseDisplayMode.off));

    expect(find.byType(ScriptureWatermark), findsNothing);
    expect(find.byType(ScriptureHeader), findsNothing);
    expect(find.byType(ScriptureFooter), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
