import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../platform/interstitial_service.dart';
import '../models/note_model.dart';
import '../services/local_storage.dart';
import '../utils/quill_content_helper.dart';

enum NoteSortOrder { modifiedDesc, createdDesc, titleAsc }

/// Owns note CRUD, search, and sort state for whichever notebook (or
/// search scope) is currently active. Talks to [LocalStorage] — no
/// screen or widget touches `sqflite` directly.
class NoteProvider {
  NoteProvider({LocalStorage? storage})
    : _storage = storage ?? LocalStorage.instance;

  final LocalStorage _storage;

  final ValueNotifier<List<NoteModel>> notes = ValueNotifier(const []);
  final ValueNotifier<String> searchQuery = ValueNotifier('');
  final ValueNotifier<NoteSortOrder> sortOrder = ValueNotifier(
    NoteSortOrder.modifiedDesc,
  );
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Set (non-null) when the most recent storage read/write silently fell
  /// back to in-memory data — the UI shows a warning banner while this is
  /// non-null (Section 15).
  final ValueNotifier<String?> persistenceWarning = ValueNotifier(null);

  String? _activeNotebookId;

  /// Loads notes for [notebookId] and makes it the active scope for
  /// subsequent saves. Clears any active search.
  Future<void> loadNotebook(String notebookId) async {
    _activeNotebookId = notebookId;
    searchQuery.value = '';
    isLoading.value = true;

    final result = await _storage.getNotesForNotebook(notebookId);
    notes.value = _sorted(result.data);
    persistenceWarning.value = result.failed
        ? 'Could not load all notes. Showing what\'s available.'
        : null;

    isLoading.value = false;
  }

  /// Loads every note regardless of notebook. Used by the home "All"
  /// and "Recent" chip scopes.
  Future<void> loadAllNotes() async {
    _activeNotebookId = null;
    searchQuery.value = '';
    isLoading.value = true;

    final result = await _storage.getAllNotes();
    notes.value = _sorted(result.data);
    persistenceWarning.value = result.failed
        ? 'Could not load all notes. Showing what\'s available.'
        : null;

    isLoading.value = false;
  }

  /// Runs an indexed full-text search across all notebooks. Passing an
  /// empty string clears search and falls back to the active notebook.
  Future<void> search(String query) async {
    searchQuery.value = query;

    if (query.trim().isEmpty) {
      final notebookId = _activeNotebookId;
      if (notebookId != null) {
        await loadNotebook(notebookId);
      }
      return;
    }

    isLoading.value = true;
    final result = await _storage.searchNotes(query);
    notes.value = _sorted(result.data);
    persistenceWarning.value = result.failed
        ? 'Search results may be incomplete right now.'
        : null;
    isLoading.value = false;
  }

  void setSortOrder(NoteSortOrder order) {
    sortOrder.value = order;
    notes.value = _sorted(notes.value);
  }

  List<NoteModel> _sorted(List<NoteModel> input) {
    final copy = List<NoteModel>.from(input);
    switch (sortOrder.value) {
      case NoteSortOrder.modifiedDesc:
        copy.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
        break;
      case NoteSortOrder.createdDesc:
        copy.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case NoteSortOrder.titleAsc:
        copy.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
    }
    return copy;
  }

  /// Saves [note]. [plainTextContent] is the Quill Delta flattened to
  /// plain text by the caller (the editor screen), used only to update the
  /// search index. Returns `true` on success.
  ///
  /// Auto-titles an untitled note: if [note]'s title is empty after
  /// trimming, the first non-empty line of [plainTextContent] becomes the
  /// title. Fires on every save, regardless of caller (decision F2 = B).
  /// If the content has no text either (e.g. handwriting), the title stays
  /// empty and the display layer falls back to `l10n.untitledNote`.
  Future<bool> saveNote(NoteModel note, {required String plainTextContent}) async {
    final derived = note.title.trim().isEmpty
        ? firstNonEmptyLine(plainTextContent)
        : '';
    final effectiveNote = derived.isEmpty
        ? note
        : note.copyWith(title: derived);

    final succeeded = await _storage.saveNote(
      effectiveNote,
      plainTextContent: plainTextContent,
    );

    if (!succeeded) {
      persistenceWarning.value =
          'This note may not have saved. Please check your storage.';
      // Graceful in-memory fallback: reflect the edit in the current list
      // even though it didn't persist, so the user doesn't lose visible
      // work mid-session.
      _upsertInMemory(effectiveNote);
      return false;
    }

    _upsertInMemory(effectiveNote);
    unawaited(InterstitialService.instance.recordNoteSave());
    return true;
  }

  void _upsertInMemory(NoteModel note) {
    final current = List<NoteModel>.from(notes.value);
    final index = current.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      current[index] = note;
    } else {
      current.add(note);
    }
    notes.value = _sorted(current);
  }

  Future<bool> deleteNote(String id) async {
    final succeeded = await _storage.deleteNote(id);
    if (succeeded) {
      notes.value = notes.value.where((n) => n.id != id).toList();
    } else {
      persistenceWarning.value =
          'Could not delete this note. Please try again.';
    }
    return succeeded;
  }

  void clearWarning() {
    persistenceWarning.value = null;
  }

  void dispose() {
    notes.dispose();
    searchQuery.dispose();
    sortOrder.dispose();
    isLoading.dispose();
    persistenceWarning.dispose();
  }
}
