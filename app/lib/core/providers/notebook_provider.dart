import 'package:flutter/foundation.dart';

import '../models/notebook_model.dart';
import '../services/local_storage.dart';

/// Owns notebook (folder) CRUD, ordering, and which notebook is currently
/// selected. Talks to [LocalStorage] — no screen or widget touches
/// `sqflite` directly.
class NotebookProvider {
  NotebookProvider({LocalStorage? storage})
    : _storage = storage ?? LocalStorage.instance;

  final LocalStorage _storage;

  final ValueNotifier<List<NotebookModel>> notebooks = ValueNotifier(const []);
  final ValueNotifier<String?> activeNotebookId = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> persistenceWarning = ValueNotifier(null);

  Future<void> loadNotebooks() async {
    isLoading.value = true;
    final result = await _storage.getNotebooks();
    notebooks.value = result.data;
    persistenceWarning.value = result.failed
        ? 'Could not load all notebooks. Showing what\'s available.'
        : null;
    isLoading.value = false;

    if (activeNotebookId.value == null && result.data.isNotEmpty) {
      activeNotebookId.value = result.data.first.id;
    }
  }

  void selectNotebook(String id) {
    activeNotebookId.value = id;
  }

  Future<bool> createNotebook(NotebookModel notebook) async {
    final succeeded = await _storage.saveNotebook(notebook);
    if (succeeded) {
      notebooks.value = [...notebooks.value, notebook];
      activeNotebookId.value = notebook.id;
    } else {
      persistenceWarning.value =
          'This notebook may not have saved. Please try again.';
    }
    return succeeded;
  }

  Future<bool> updateNotebook(NotebookModel notebook) async {
    final succeeded = await _storage.saveNotebook(notebook);
    final current = List<NotebookModel>.from(notebooks.value);
    final index = current.indexWhere((n) => n.id == notebook.id);
    if (index >= 0) {
      current[index] = notebook;
      notebooks.value = current;
    }
    if (!succeeded) {
      persistenceWarning.value =
          'This change may not have saved. Please try again.';
    }
    return succeeded;
  }

  Future<bool> deleteNotebook(String id) async {
    final succeeded = await _storage.deleteNotebook(id);
    if (succeeded) {
      notebooks.value = notebooks.value.where((n) => n.id != id).toList();
      if (activeNotebookId.value == id) {
        activeNotebookId.value = notebooks.value.isNotEmpty
            ? notebooks.value.first.id
            : null;
      }
    } else {
      persistenceWarning.value =
          'Could not delete this notebook. Please try again.';
    }
    return succeeded;
  }

  /// Persists a new manual ordering. [orderedIds] must contain every
  /// notebook id currently loaded, in the desired display order.
  Future<void> reorder(List<String> orderedIds) async {
    final byId = {for (final n in notebooks.value) n.id: n};
    final reordered = <NotebookModel>[];
    var anyFailed = false;

    for (var i = 0; i < orderedIds.length; i++) {
      final existing = byId[orderedIds[i]];
      if (existing == null) continue;
      final updated = existing.copyWith(sortOrder: i);
      reordered.add(updated);
      final succeeded = await _storage.saveNotebook(updated);
      if (!succeeded) anyFailed = true;
    }

    notebooks.value = reordered;
    persistenceWarning.value = anyFailed
        ? 'The new order may not have saved. Please try again.'
        : null;
  }

  void clearWarning() {
    persistenceWarning.value = null;
  }

  void dispose() {
    notebooks.dispose();
    activeNotebookId.dispose();
    isLoading.dispose();
    persistenceWarning.dispose();
  }
}
