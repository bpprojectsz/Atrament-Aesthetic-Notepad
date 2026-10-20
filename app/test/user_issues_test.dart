import 'dart:ui' show Locale;

import 'package:atrament/core/models/notebook_model.dart';
import 'package:atrament/core/providers/note_provider.dart';
import 'package:atrament/core/providers/notebook_provider.dart';
import 'package:atrament/core/services/export_service.dart';
import 'package:atrament/core/services/iap_service.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:atrament/core/utils/user_issues.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:atrament/widgets/user_issue_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'helpers/controlled_storage.dart';

/// A store that is never actually called: with no products loaded the
/// purchase service must refuse before it gets that far.
class _UnusedStore implements InAppPurchase {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

NotebookModel _notebook(String id, int order) => NotebookModel(
  id: id,
  name: id,
  coverColor: 0xFF8B6914,
  paperStyleDefault: 'cream',
  sortOrder: order,
  createdAt: DateTime(2026),
  modifiedAt: DateTime(2026),
);

void main() {
  final english = lookupAppLocalizations(const Locale('en'));

  group('every message exists, in every language', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      final code = locale.languageCode;

      test('storage issues ($code)', () {
        final texts = <String>{};
        for (final issue in StorageIssue.values) {
          final text = storageIssueText(l10n, issue);
          expect(text.trim(), isNotEmpty, reason: '$issue');
          texts.add(text);
          if (code != 'en') {
            expect(text, isNot(storageIssueText(english, issue)),
                reason: '$issue is still the English text in $code');
          }
        }
        expect(texts.length, StorageIssue.values.length,
            reason: 'two different problems must not share one message');
      });

      test('purchase failures ($code)', () {
        for (final failure in PurchaseFailure.values) {
          final text = purchaseFailureText(l10n, failure);
          expect(text.trim(), isNotEmpty, reason: '$failure');
          if (code != 'en') {
            expect(text, isNot(purchaseFailureText(english, failure)),
                reason: '$failure is still the English text in $code');
          }
        }
      });
    }
  });

  group('NoteProvider reports typed storage issues', () {
    late ControlledStorage storage;
    late NoteProvider provider;

    setUp(() {
      storage = ControlledStorage()..allNotes = [testNote('a', 'A')];
      provider = NoteProvider(storage: storage);
    });

    tearDown(() => provider.dispose());

    test('a failed load', () async {
      storage.failLoads = true;
      await provider.loadAllNotes();
      expect(provider.persistenceWarning.value, StorageIssue.notesLoadIncomplete);

      storage.failLoads = false;
      await provider.loadAllNotes();
      expect(provider.persistenceWarning.value, isNull, reason: 'clears on success');
    });

    test('a failed notebook load', () async {
      storage.failLoads = true;
      await provider.loadNotebook('nb');
      expect(provider.persistenceWarning.value, StorageIssue.notesLoadIncomplete);
    });

    test('a failed save, cleared by the next success', () async {
      storage.failSaves = true;
      final failed = await provider.saveNote(testNote('a', 'A'), plainTextContent: 'x');
      expect(failed, isFalse);
      expect(provider.persistenceWarning.value, StorageIssue.noteSaveFailed);

      storage.failSaves = false;
      await provider.saveNote(testNote('a', 'A'), plainTextContent: 'x');
      expect(provider.persistenceWarning.value, isNull);
    });

    test('a failed delete', () async {
      storage.failDeletes = true;
      expect(await provider.deleteNote('a'), isFalse);
      expect(provider.persistenceWarning.value, StorageIssue.noteDeleteFailed);
    });

    test('an incomplete search', () async {
      final search = provider.search('x', debounce: false);
      storage.searchCompleters.single.complete(const StorageResult.failure([]));
      await search;
      expect(provider.persistenceWarning.value, StorageIssue.searchIncomplete);
    });
  });

  group('NotebookProvider reports typed storage issues', () {
    late ControlledStorage storage;
    late NotebookProvider provider;

    setUp(() {
      storage = ControlledStorage();
      provider = NotebookProvider(storage: storage);
    });

    tearDown(() => provider.dispose());

    test('a failed load', () async {
      storage.failLoads = true;
      await provider.loadNotebooks();
      expect(provider.persistenceWarning.value, StorageIssue.notebooksLoadIncomplete);
    });

    test('a failed create', () async {
      storage.failSaves = true;
      await provider.createNotebook(_notebook('n', 0));
      expect(provider.persistenceWarning.value, StorageIssue.notebookSaveFailed);
    });

    test('a failed edit', () async {
      storage.failSaves = true;
      await provider.updateNotebook(_notebook('n', 0));
      expect(provider.persistenceWarning.value, StorageIssue.notebookChangeFailed);
    });

    test('a failed delete', () async {
      storage.failDeletes = true;
      await provider.deleteNotebook('n');
      expect(provider.persistenceWarning.value, StorageIssue.notebookDeleteFailed);
    });

    test('a failed re-order', () async {
      await provider.createNotebook(_notebook('a', 0));
      await provider.createNotebook(_notebook('b', 1));
      storage.failSaves = true;

      await provider.reorder(['b', 'a']);

      expect(provider.persistenceWarning.value, StorageIssue.notebookOrderFailed);
    });
  });

  group('purchases and exports carry no display text', () {
    test('a purchase failure is a typed reason', () {
      const result = PurchaseAttemptResult.failure(PurchaseFailure.productUnavailable);
      expect(result.succeeded, isFalse);
      expect(result.failure, PurchaseFailure.productUnavailable);
      expect(const PurchaseAttemptResult.success().succeeded, isTrue);
      expect(const PurchaseAttemptResult.cancelled().succeeded, isFalse);
    });

    test('buying with no product loaded says the product is unavailable', () async {
      final service = IapService.forTesting(iap: _UnusedStore(), isAndroid: true);

      final result = await service.purchase('com.example.missing');

      expect(result.succeeded, isFalse);
      expect(result.failure, PurchaseFailure.productUnavailable);
    });

    test('an export failure has no file and is not a success', () {
      const failed = ExportResult.failure();
      expect(failed.succeeded, isFalse);
      expect(failed.filePath, isNull);
    });
  });
}
