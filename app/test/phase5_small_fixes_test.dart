import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:atrament/core/utils/date_formatter.dart';
import 'package:atrament/core/utils/paper_default.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/screens/home_screen.dart';
import 'package:atrament/widgets/new_notebook_dialog.dart';
import 'package:atrament/widgets/rename_note_dialog.dart';
import 'package:atrament/widgets/rename_notebook_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

NoteModel _noteEdited(String id, DateTime modifiedAt) => NoteModel(
  id: id,
  title: id,
  content: '[]',
  paperStyle: 'cream',
  createdAt: DateTime(2020),
  modifiedAt: modifiedAt,
);

/// Opens [open] from a button, so the dialog is shown over a real route and
/// its result can be read.
Future<T?> _runDialog<T>(
  WidgetTester tester,
  Future<T?> Function(BuildContext context) open,
  Future<void> Function() interact,
) async {
  T? result;
  var finished = false;
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async {
              result = await open(context);
              finished = true;
            },
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  await interact();
  await tester.pumpAndSettle();
  expect(finished, isTrue, reason: 'the dialog must have closed');
  expect(tester.takeException(), isNull,
      reason: 'closing the dialog must not touch a disposed controller');
  return result;
}

void main() {
  group('Recent chip', () {
    final now = DateTime(2026, 10, 12, 12);

    test('keeps notes edited in the last 7 days and drops older ones', () {
      final notes = [
        _noteEdited('today', now),
        _noteEdited('six_days', now.subtract(const Duration(days: 6))),
        _noteEdited('eight_days', now.subtract(const Duration(days: 8))),
        _noteEdited('long_ago', DateTime(2025)),
      ];

      final recent = filterRecentNotes(notes, now);

      expect(recent.map((n) => n.id), ['today', 'six_days']);
    });

    test('is empty when nothing was edited recently', () {
      expect(
        filterRecentNotes([_noteEdited('old', DateTime(2024))], now),
        isEmpty,
      );
    });

    test('a note edited exactly 7 days ago is no longer recent', () {
      final edge = _noteEdited('edge', now.subtract(recentNotesWindow));
      expect(filterRecentNotes([edge], now), isEmpty);
    });
  });

  group('relativeBucket', () {
    final now = DateTime(2026, 3, 15, 0, 30);

    test('classifies by calendar day', () {
      RelativeDateBucket at(DateTime d) =>
          DateFormatter.relativeBucket(d, now: now);

      expect(at(DateTime(2026, 3, 15, 23, 59)), RelativeDateBucket.today);
      expect(at(DateTime(2026, 3, 14, 23, 59)), RelativeDateBucket.yesterday);
      expect(at(DateTime(2026, 3, 14, 0, 0)), RelativeDateBucket.yesterday);
      expect(at(DateTime(2026, 3, 13)), RelativeDateBucket.thisWeek);
      expect(at(DateTime(2026, 3, 9)), RelativeDateBucket.thisWeek);
      expect(at(DateTime(2026, 3, 8)), RelativeDateBucket.older);
    });

    test('works across month and year boundaries', () {
      final newYear = DateTime(2026, 1, 1, 8);
      expect(
        DateFormatter.relativeBucket(DateTime(2025, 12, 31), now: newYear),
        RelativeDateBucket.yesterday,
      );
      expect(
        DateFormatter.relativeBucket(DateTime(2025, 12, 28), now: newYear),
        RelativeDateBucket.thisWeek,
      );
    });
  });

  group('default paper', () {
    test('is cream until the user chooses another', () async {
      SharedPreferences.setMockInitialValues({});
      expect(await loadDefaultPaperStyleId(), 'cream');
    });

    test('follows the choice made in Settings', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.prefPaperStyleDefault: 'lined',
      });
      expect(await loadDefaultPaperStyleId(), 'lined');
    });
  });

  group('name dialogs', () {
    testWidgets('new notebook: returns the trimmed name', (tester) async {
      final result = await _runDialog<String>(
        tester,
        showNewNotebookDialog,
        () async {
          await tester.enterText(find.byType(TextField), '  Work  ');
          await tester.tap(find.text('Save'));
        },
      );
      expect(result, 'Work');
    });

    testWidgets('new notebook: an empty name returns nothing', (tester) async {
      final result = await _runDialog<String>(
        tester,
        showNewNotebookDialog,
        () async => tester.tap(find.text('Save')),
      );
      expect(result, isNull);
    });

    testWidgets('new notebook: cancel returns nothing', (tester) async {
      final result = await _runDialog<String>(
        tester,
        showNewNotebookDialog,
        () async {
          await tester.enterText(find.byType(TextField), 'Ignored');
          await tester.tap(find.text('Cancel'));
        },
      );
      expect(result, isNull);
    });

    testWidgets('rename notebook: a new name is returned trimmed', (tester) async {
      final result = await _runDialog<String>(
        tester,
        (context) => showRenameNotebookDialog(context, 'Old'),
        () async {
          await tester.enterText(find.byType(TextField), ' Fresh ');
          await tester.tap(find.text('Save'));
        },
      );
      expect(result, 'Fresh');
    });

    testWidgets('rename notebook: an empty name is rejected (keeps the old one)', (
      tester,
    ) async {
      final result = await _runDialog<String>(
        tester,
        (context) => showRenameNotebookDialog(context, 'Old'),
        () async {
          await tester.enterText(find.byType(TextField), '   ');
          await tester.tap(find.text('Save'));
        },
      );
      expect(result, isNull);
    });

    testWidgets('rename notebook: an unchanged name returns nothing', (
      tester,
    ) async {
      final result = await _runDialog<String>(
        tester,
        (context) => showRenameNotebookDialog(context, 'Same'),
        () async => tester.tap(find.text('Save')),
      );
      expect(result, isNull);
    });

    testWidgets('rename note: an empty title is allowed', (tester) async {
      final result = await _runDialog<String>(
        tester,
        (context) => showRenameNoteDialog(context, 'Had a title'),
        () async {
          await tester.enterText(find.byType(TextField), '');
          await tester.tap(find.text('Save'));
        },
      );
      expect(result, '', reason: 'an empty title falls back to the first line');
    });

    testWidgets('rename note: submitting from the keyboard works too', (
      tester,
    ) async {
      final result = await _runDialog<String>(
        tester,
        (context) => showRenameNoteDialog(context, 'A'),
        () async {
          await tester.enterText(find.byType(TextField), 'B');
          await tester.testTextInput.receiveAction(TextInputAction.done);
        },
      );
      expect(result, 'B');
    });
  });
}
