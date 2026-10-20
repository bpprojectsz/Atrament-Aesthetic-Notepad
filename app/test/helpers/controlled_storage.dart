import 'dart:async';

import 'package:atrament/core/models/note_model.dart';
import 'package:atrament/core/models/notebook_model.dart';
import 'package:atrament/core/services/local_storage.dart';

/// A storage fake whose search answers are released by the test, so tests
/// can make a slow, stale answer arrive after a newer one — something a real
/// database can't be made to do reliably.
class ControlledStorage implements LocalStorage {
  List<NoteModel> allNotes = [];
  final Map<String, List<NoteModel>> notebookNotes = {};

  /// Every query that reached storage, in order.
  final List<String> searchCalls = [];
  final List<Completer<StorageResult<List<NoteModel>>>> searchCompleters = [];

  @override
  Future<StorageResult<List<NoteModel>>> searchNotes(String query) {
    searchCalls.add(query);
    final completer = Completer<StorageResult<List<NoteModel>>>();
    searchCompleters.add(completer);
    return completer.future;
  }

  /// Make the matching kind of operation fail, as a full disk or a broken
  /// database would.
  bool failLoads = false;
  bool failSaves = false;
  bool failDeletes = false;

  @override
  Future<bool> saveNote(
    NoteModel note, {
    required String plainTextContent,
  }) async => !failSaves;

  @override
  Future<bool> deleteNote(String id) async => !failDeletes;

  @override
  Future<bool> saveNotebook(NotebookModel notebook) async => !failSaves;

  @override
  Future<bool> deleteNotebook(String id) async => !failDeletes;

  @override
  Future<StorageResult<List<NoteModel>>> getAllNotes() async => failLoads
      ? const StorageResult.failure([])
      : StorageResult.success(List.of(allNotes));

  @override
  Future<StorageResult<List<NoteModel>>> getNotesForNotebook(
    String notebookId,
  ) async => failLoads
      ? const StorageResult.failure([])
      : StorageResult.success(List.of(notebookNotes[notebookId] ?? []));

  @override
  Future<StorageResult<List<NotebookModel>>> getNotebooks() async => failLoads
      ? const StorageResult.failure([])
      : const StorageResult.success([]);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

NoteModel testNote(String id, String title, {String? notebookId}) => NoteModel(
  id: id,
  title: title,
  content: '[{"insert":"preview of $title\\n"}]',
  notebookId: notebookId,
  paperStyle: 'cream',
  createdAt: DateTime(2026, 1, 1),
  modifiedAt: DateTime(2026, 1, 1),
);
