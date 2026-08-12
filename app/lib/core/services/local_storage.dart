import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/note_model.dart';
import '../models/notebook_model.dart';
import '../utils/constants.dart';
import '../utils/error_handler.dart';

/// Result wrapper so callers (providers) can distinguish "empty on purpose"
/// from "failed and fell back to empty," which matters for the visible
/// warning banner required by Section 15.
class StorageResult<T> {
  const StorageResult.success(this.data) : failed = false;
  const StorageResult.failure(this.data) : failed = true;

  final T data;
  final bool failed;
}

/// SQLite-backed persistence for notes and notebooks, including an FTS5
/// virtual table for indexed note search (Section 11: "never linear scan").
///
/// This is the only file that touches `sqflite` directly — providers call
/// through this service rather than opening the database themselves.
class LocalStorage {
  LocalStorage._internal();

  static final LocalStorage instance = LocalStorage._internal();

  Database? _db;
  bool _ffiInitialized = false;

  Future<Database> get _database async {
    final existing = _db;
    if (existing != null) return existing;
    final opened = await _open();
    _db = opened;
    return opened;
  }

  Future<Database> _open() async {
    // sqflite's default Android backend calls into
    // android.database.sqlite.SQLiteDatabase — an OS framework class, not
    // a loadable library an app can override. The device's system SQLite
    // isn't guaranteed to include FTS5 (several Android builds omit it),
    // and bundling sqlite3_flutter_libs alone doesn't help, since that
    // only supplies a native library for Dart's direct FFI bindings.
    // Explicitly switching to databaseFactoryFfi routes every call
    // through those FFI bindings instead, which do use the bundled
    // modern SQLite (with FTS5) rather than the OS-provided one.
    if (!_ffiInitialized) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      _ffiInitialized = true;
    }

    // getDatabasesPath() has an unreliable implementation under the ffi
    // factory (per sqflite_common_ffi's own documentation) — resolving
    // the path via path_provider instead, as that documentation itself
    // recommends.
    final dir = await getApplicationDocumentsDirectory();
    final fullPath = p.join(dir.path, AppConstants.dbName);

    return openDatabase(
      fullPath,
      version: AppConstants.dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${AppConstants.tableNotebooks} (
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
          CREATE TABLE ${AppConstants.tableNotes} (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            notebookId TEXT NOT NULL,
            paperStyle TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            modifiedAt TEXT NOT NULL,
            verseReference TEXT,
            FOREIGN KEY (notebookId) REFERENCES ${AppConstants.tableNotebooks}(id)
              ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE VIRTUAL TABLE ${AppConstants.tableNotesFts} USING fts5(
            id UNINDEXED,
            title,
            plainText,
            tokenize='porter unicode61'
          )
        ''');

        await db.execute(
          'CREATE INDEX idx_notes_notebookId ON '
          '${AppConstants.tableNotes}(notebookId)',
        );
      },
      onUpgrade: _migrate,
    );
  }

  /// Migration chain for schema version bumps. Each version adds a case
  /// here — never remove or renumber past cases, since a device could be
  /// upgrading from any older version to the current one in one jump.
  Future<void> _migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // v2: added notebooks.modifiedAt (Section 15 — notebooks previously
      // only tracked creation time, not last-edited time, unlike notes).
      // SQLite requires a DEFAULT when adding a NOT NULL column to a
      // table that may already have rows; backfilling with each row's
      // own createdAt is the only sensible default, since we have no
      // record of when an existing notebook was actually last edited.
      await db.execute('''
        ALTER TABLE ${AppConstants.tableNotebooks}
        ADD COLUMN modifiedAt TEXT NOT NULL DEFAULT ''
      ''');
      await db.execute('''
        UPDATE ${AppConstants.tableNotebooks}
        SET modifiedAt = createdAt
        WHERE modifiedAt = ''
      ''');
    }
  }

  Future<T> _guarded<T>(
    Future<T> Function() action, {
    required String context,
    required T fallback,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Local storage operation failed',
        context: context,
        severity: ErrorSeverity.warning,
      );
      return fallback;
    }
  }

  // ---------------------------------------------------------------------
  // Notebooks
  // ---------------------------------------------------------------------

  Future<StorageResult<List<NotebookModel>>> getNotebooks() async {
    final rows = await _guarded<List<Map<String, Object?>>?>(
      () async {
        final db = await _database;
        return db.query(
          AppConstants.tableNotebooks,
          orderBy: 'sortOrder ASC',
        );
      },
      context: 'local_storage.getNotebooks',
      fallback: null,
    );

    if (rows == null) return const StorageResult.failure([]);

    final notebooks = rows
        .map((row) => NotebookModel.fromJson(Map<String, dynamic>.from(row)))
        .toList();
    return StorageResult.success(notebooks);
  }

  Future<bool> saveNotebook(NotebookModel notebook) async {
    final result = await _guarded<bool>(
      () async {
        final db = await _database;
        await db.insert(
          AppConstants.tableNotebooks,
          notebook.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        return true;
      },
      context: 'local_storage.saveNotebook',
      fallback: false,
    );
    return result;
  }

  Future<bool> deleteNotebook(String id) async {
    final result = await _guarded<bool>(
      () async {
        final db = await _database;
        await db.delete(
          AppConstants.tableNotes,
          where: 'notebookId = ?',
          whereArgs: [id],
        );
        await db.delete(
          AppConstants.tableNotebooks,
          where: 'id = ?',
          whereArgs: [id],
        );
        return true;
      },
      context: 'local_storage.deleteNotebook',
      fallback: false,
    );
    return result;
  }

  // ---------------------------------------------------------------------
  // Notes
  // ---------------------------------------------------------------------

  Future<StorageResult<List<NoteModel>>> getNotesForNotebook(
    String notebookId,
  ) async {
    final rows = await _guarded<List<Map<String, Object?>>?>(
      () async {
        final db = await _database;
        return db.query(
          AppConstants.tableNotes,
          where: 'notebookId = ?',
          whereArgs: [notebookId],
          orderBy: 'modifiedAt DESC',
        );
      },
      context: 'local_storage.getNotesForNotebook',
      fallback: null,
    );

    if (rows == null) return const StorageResult.failure([]);

    final notes = rows
        .map((row) => NoteModel.fromJson(Map<String, dynamic>.from(row)))
        .toList();
    return StorageResult.success(notes);
  }

  /// Saves [note] and keeps the FTS index in sync. [plainTextContent] is
  /// the Quill Delta flattened to searchable plain text — computed by the
  /// caller (note_provider) since delta-to-plaintext conversion is a
  /// presentation concern, not a storage concern.
  Future<bool> saveNote(NoteModel note, {required String plainTextContent}) async {
    final result = await _guarded<bool>(
      () async {
        final db = await _database;
        await db.transaction((txn) async {
          await txn.insert(
            AppConstants.tableNotes,
            note.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await txn.delete(
            AppConstants.tableNotesFts,
            where: 'id = ?',
            whereArgs: [note.id],
          );
          await txn.insert(AppConstants.tableNotesFts, {
            'id': note.id,
            'title': note.title,
            'plainText': plainTextContent,
          });
        });
        return true;
      },
      context: 'local_storage.saveNote',
      fallback: false,
    );
    return result;
  }

  Future<bool> deleteNote(String id) async {
    final result = await _guarded<bool>(
      () async {
        final db = await _database;
        await db.transaction((txn) async {
          await txn.delete(
            AppConstants.tableNotes,
            where: 'id = ?',
            whereArgs: [id],
          );
          await txn.delete(
            AppConstants.tableNotesFts,
            where: 'id = ?',
            whereArgs: [id],
          );
        });
        return true;
      },
      context: 'local_storage.deleteNote',
      fallback: false,
    );
    return result;
  }

  /// Indexed full-text search across all notes' titles and content via
  /// FTS5 — never a linear Dart-side scan (Section 11 requirement).
  Future<StorageResult<List<NoteModel>>> searchNotes(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const StorageResult.success([]);

    final rows = await _guarded<List<Map<String, Object?>>?>(
      () async {
        final db = await _database;
        // FTS5 prefix match on each token for responsive as-you-type search.
        final ftsQuery = trimmed
            .split(RegExp(r'\s+'))
            .where((t) => t.isNotEmpty)
            .map((t) => '$t*')
            .join(' ');

        return db.rawQuery(
          '''
          SELECT notes.* FROM ${AppConstants.tableNotes} AS notes
          INNER JOIN ${AppConstants.tableNotesFts} AS fts
            ON notes.id = fts.id
          WHERE ${AppConstants.tableNotesFts} MATCH ?
          ORDER BY notes.modifiedAt DESC
          ''',
          [ftsQuery],
        );
      },
      context: 'local_storage.searchNotes',
      fallback: null,
    );

    if (rows == null) return const StorageResult.failure([]);

    final notes = rows
        .map((row) => NoteModel.fromJson(Map<String, dynamic>.from(row)))
        .toList();
    return StorageResult.success(notes);
  }

  /// Closes the database — used by tests to reset state between cases.
  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }
}
