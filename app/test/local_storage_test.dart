import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/models/notebook_model.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // sqflite's default implementation talks to a real Android/iOS platform
  // channel that doesn't exist under plain `flutter test`. sqflite_ffi
  // substitutes a real SQLite engine that runs directly on the test VM,
  // so these tests exercise actual SQL rather than a mock.
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late LocalStorage storage;

  setUp(() async {
    // Every test must start from a clean database — LocalStorage is a
    // singleton that always opens the same on-disk file, so without this,
    // rows saved by one test would leak into the next test's assertions
    // (e.g. an exact-list-equality check would fail once unrelated
    // notebooks from earlier tests are also present).
    final dbPath = await databaseFactory.getDatabasesPath();
    final fullPath = p.join(dbPath, AppConstants.dbName);
    await databaseFactory.deleteDatabase(fullPath);

    storage = LocalStorage.instance;
  });

  tearDown(() async {
    await storage.close();
  });

  NotebookModel buildNotebook(String id, {int sortOrder = 0}) {
    return NotebookModel(
      id: id,
      name: 'Notebook $id',
      coverColor: 0xFF8B6914,
      paperStyleDefault: 'cream',
      sortOrder: sortOrder,
      createdAt: DateTime(2026, 1, 1),
      modifiedAt: DateTime(2026, 1, 1),
    );
  }

  NoteModel buildNote(String id, String notebookId, {String title = 'Untitled'}) {
    final now = DateTime(2026, 1, 15);
    return NoteModel(
      id: id,
      title: title,
      content: '[{"insert":"$title body\\n"}]',
      notebookId: notebookId,
      paperStyle: 'cream',
      createdAt: now,
      modifiedAt: now,
    );
  }

  group('Notebook CRUD', () {
    test('saveNotebook then getNotebooks returns it', () async {
      final notebook = buildNotebook('nb_1');
      final saved = await storage.saveNotebook(notebook);
      expect(saved, isTrue);

      final result = await storage.getNotebooks();
      expect(result.failed, isFalse);
      expect(result.data, contains(notebook));
    });

    test('getNotebooks orders by sortOrder ascending', () async {
      await storage.saveNotebook(buildNotebook('nb_b', sortOrder: 2));
      await storage.saveNotebook(buildNotebook('nb_a', sortOrder: 1));
      await storage.saveNotebook(buildNotebook('nb_c', sortOrder: 3));

      final result = await storage.getNotebooks();
      final ids = result.data.map((n) => n.id).toList();

      expect(ids, ['nb_a', 'nb_b', 'nb_c']);
    });

    test('deleteNotebook removes it and cascades to its notes', () async {
      final notebook = buildNotebook('nb_del');
      await storage.saveNotebook(notebook);
      await storage.saveNote(
        buildNote('note_in_deleted_nb', 'nb_del'),
        plainTextContent: 'body',
      );

      final deleted = await storage.deleteNotebook('nb_del');
      expect(deleted, isTrue);

      final notebooks = await storage.getNotebooks();
      expect(notebooks.data.any((n) => n.id == 'nb_del'), isFalse);

      final notes = await storage.getNotesForNotebook('nb_del');
      expect(notes.data, isEmpty);
    });
  });

  group('Note CRUD', () {
    test('saveNote then getNotesForNotebook returns it', () async {
      await storage.saveNotebook(buildNotebook('nb_notes'));
      final note = buildNote('note_1', 'nb_notes', title: 'Grocery List');
      await storage.saveNote(note, plainTextContent: 'milk eggs bread');

      final result = await storage.getNotesForNotebook('nb_notes');
      expect(result.data, contains(note));
    });

    test('saveNote with an existing id overwrites rather than duplicates', () async {
      await storage.saveNotebook(buildNotebook('nb_overwrite'));
      final original = buildNote('note_dup', 'nb_overwrite', title: 'Original');
      await storage.saveNote(original, plainTextContent: 'original text');

      final updated = original.copyWith(title: 'Updated');
      await storage.saveNote(updated, plainTextContent: 'updated text');

      final result = await storage.getNotesForNotebook('nb_overwrite');
      expect(result.data.length, 1);
      expect(result.data.first.title, 'Updated');
    });

    test('deleteNote removes it from the notebook', () async {
      await storage.saveNotebook(buildNotebook('nb_del_note'));
      final note = buildNote('note_to_delete', 'nb_del_note');
      await storage.saveNote(note, plainTextContent: 'text');

      final deleted = await storage.deleteNote('note_to_delete');
      expect(deleted, isTrue);

      final result = await storage.getNotesForNotebook('nb_del_note');
      expect(result.data, isEmpty);
    });
  });

  group('Full-text search', () {
    test('searchNotes finds a note by title', () async {
      await storage.saveNotebook(buildNotebook('nb_search'));
      await storage.saveNote(
        buildNote('note_search_1', 'nb_search', title: 'Quarterly Budget Review'),
        plainTextContent: 'numbers and spreadsheets',
      );

      final result = await storage.searchNotes('Budget');
      expect(result.data.any((n) => n.id == 'note_search_1'), isTrue);
    });

    test('searchNotes finds a note by body content', () async {
      await storage.saveNotebook(buildNotebook('nb_search2'));
      await storage.saveNote(
        buildNote('note_search_2', 'nb_search2', title: 'Untitled'),
        plainTextContent: 'a reminder about the lighthouse trip',
      );

      final result = await storage.searchNotes('lighthouse');
      expect(result.data.any((n) => n.id == 'note_search_2'), isTrue);
    });

    test('searchNotes returns empty for a blank query rather than everything', () async {
      await storage.saveNotebook(buildNotebook('nb_search3'));
      await storage.saveNote(
        buildNote('note_search_3', 'nb_search3'),
        plainTextContent: 'anything at all',
      );

      final result = await storage.searchNotes('   ');
      expect(result.data, isEmpty);
    });

    test('searchNotes with no matches returns an empty, non-failed result', () async {
      await storage.saveNotebook(buildNotebook('nb_search4'));

      final result = await storage.searchNotes('nonexistentxyz123');
      expect(result.failed, isFalse);
      expect(result.data, isEmpty);
    });
  });
}
