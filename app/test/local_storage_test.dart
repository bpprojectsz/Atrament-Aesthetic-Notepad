import 'dart:io';

import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/models/notebook_model.dart';
import 'package:atrament/core/services/local_storage.dart';
import 'package:atrament/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Fakes path_provider's platform channel, which has no implementation
/// under plain `flutter test` and throws MissingPluginException without
/// this — local_storage.dart calls getApplicationDocumentsDirectory() to
/// resolve where the database file lives.
class _FakePathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  final String _tempPath = Directory.systemTemp
      .createTempSync('atrament_test_docs_')
      .path;

  @override
  Future<String?> getApplicationDocumentsPath() async => _tempPath;
}

void main() {
  // sqflite's default implementation talks to a real Android/iOS platform
  // channel that doesn't exist under plain `flutter test`. sqflite_ffi
  // substitutes a real SQLite engine that runs directly on the test VM,
  // so these tests exercise actual SQL rather than a mock.
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    PathProviderPlatform.instance = _FakePathProviderPlatform();
  });

  late LocalStorage storage;

  setUp(() async {
    // Every test must start from a clean database — LocalStorage is a
    // singleton that always opens the same on-disk file, so without this,
    // rows saved by one test would leak into the next test's assertions
    // (e.g. an exact-list-equality check would fail once unrelated
    // notebooks from earlier tests are also present).
    //
    // This must match local_storage.dart's own path resolution exactly
    // (getApplicationDocumentsDirectory(), not getDatabasesPath() — the
    // latter has an unreliable implementation under the ffi factory per
    // sqflite_common_ffi's own documentation, so local_storage.dart
    // doesn't use it).
    final docsPath = await PathProviderPlatform.instance
        .getApplicationDocumentsPath();
    final fullPath = p.join(docsPath!, AppConstants.dbName);
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

  group('getAllNotes', () {
    test('returns notes with null notebookId alongside filed notes', () async {
      await storage.saveNotebook(buildNotebook('nb_all'));
      await storage.saveNote(
        buildNote('note_filed', 'nb_all', title: 'Filed'),
        plainTextContent: 'filed body',
      );

      final nullNote = NoteModel(
        id: 'note_loose',
        title: 'Loose',
        content: '[{"insert":"loose body\\n"}]',
        notebookId: null,
        paperStyle: 'cream',
        createdAt: DateTime(2026, 1, 20),
        modifiedAt: DateTime(2026, 1, 20),
      );
      await storage.saveNote(nullNote, plainTextContent: 'loose body');

      final result = await storage.getAllNotes();
      expect(result.failed, isFalse);
      expect(result.data.length, 2);
      expect(result.data.any((n) => n.id == 'note_filed'), isTrue);
      expect(result.data.any((n) => n.id == 'note_loose'), isTrue);
      expect(
        result.data.firstWhere((n) => n.id == 'note_loose').notebookId,
        isNull,
      );
    });

    test('returns empty list when no notes exist', () async {
      final result = await storage.getAllNotes();
      expect(result.failed, isFalse);
      expect(result.data, isEmpty);
    });
  });

  group('Schema migration v2 to v3', () {
    test('preserves notes and FTS when upgrading from a v2 database', () async {
      final docsPath = await PathProviderPlatform.instance
          .getApplicationDocumentsPath();
      final fullPath = p.join(docsPath!, AppConstants.dbName);

      final v2 = await databaseFactory.openDatabase(
        fullPath,
        options: OpenDatabaseOptions(
          version: 2,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE notebooks (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                coverColor INTEGER NOT NULL,
                paperStyleDefault TEXT NOT NULL,
                sortOrder INTEGER NOT NULL,
                createdAt TEXT NOT NULL,
                modifiedAt TEXT NOT NULL
              )
            ''');
            await db.execute('''
              CREATE TABLE notes (
                id TEXT PRIMARY KEY,
                title TEXT NOT NULL,
                content TEXT NOT NULL,
                notebookId TEXT NOT NULL,
                paperStyle TEXT NOT NULL,
                createdAt TEXT NOT NULL,
                modifiedAt TEXT NOT NULL,
                verseReference TEXT,
                FOREIGN KEY (notebookId) REFERENCES notebooks(id)
                  ON DELETE CASCADE
              )
            ''');
            await db.execute('''
              CREATE VIRTUAL TABLE notes_fts USING fts5(
                id UNINDEXED, title, plainText,
                tokenize='porter unicode61'
              )
            ''');
            await db.execute(
              'CREATE INDEX idx_notes_notebookId ON notes(notebookId)',
            );
          },
        ),
      );

      await v2.insert('notebooks', {
        'id': 'nb_v2',
        'name': 'Legacy Notebook',
        'coverColor': 0xFF8B6914,
        'paperStyleDefault': 'cream',
        'sortOrder': 0,
        'createdAt': DateTime(2026, 1, 1).toIso8601String(),
        'modifiedAt': DateTime(2026, 1, 1).toIso8601String(),
      });
      await v2.insert('notes', {
        'id': 'note_v2',
        'title': 'Legacy Note',
        'content': '[{"insert":"legacy\\n"}]',
        'notebookId': 'nb_v2',
        'paperStyle': 'cream',
        'createdAt': DateTime(2026, 1, 1).toIso8601String(),
        'modifiedAt': DateTime(2026, 1, 1).toIso8601String(),
        'verseReference': null,
      });
      await v2.insert('notes_fts', {
        'id': 'note_v2',
        'title': 'Legacy Note',
        'plainText': 'lighthouse body prose',
      });
      await v2.close();

      final notes = await storage.getNotesForNotebook('nb_v2');
      expect(notes.failed, isFalse);
      expect(notes.data.length, 1);
      expect(notes.data.first.id, 'note_v2');

      final search = await storage.searchNotes('lighthouse');
      expect(search.data.any((n) => n.id == 'note_v2'), isTrue);

      final loose = NoteModel(
        id: 'note_post_migration',
        title: 'Loose',
        content: '[{"insert":"\\n"}]',
        notebookId: null,
        paperStyle: 'cream',
        createdAt: DateTime(2026, 1, 2),
        modifiedAt: DateTime(2026, 1, 2),
      );
      final saved = await storage.saveNote(loose, plainTextContent: 'loose');
      expect(saved, isTrue);
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
