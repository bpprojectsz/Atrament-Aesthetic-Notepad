import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/models/note_model.dart';
import '../core/models/notebook_model.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/notebook_provider.dart';
import '../core/utils/constants.dart';
import '../core/utils/date_formatter.dart';
import '../core/utils/id_generator.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/note_list_item.dart';
import 'note_editor_screen.dart';

/// Lists the notes within a single notebook, with sort options, an empty
/// state, and a new-note FAB.
class NotebookDetailScreen extends StatefulWidget {
  const NotebookDetailScreen({
    super.key,
    required this.notebook,
    required this.notebookProvider,
    required this.noteProvider,
  }) : initialNoteId = null,
       _notebookIdOverride = null;

  /// Opens directly into [NoteEditorScreen] for [initialNoteId] once the
  /// notebook's notes have loaded — used when navigating here from a
  /// global search result rather than by tapping a notebook card.
  const NotebookDetailScreen.editingNote({
    super.key,
    required String noteId,
    required String notebookId,
    required this.notebookProvider,
    required this.noteProvider,
  }) : initialNoteId = noteId,
       notebook = null,
       _notebookIdOverride = notebookId;

  final NotebookModel? notebook;
  final String? initialNoteId;
  final String? _notebookIdOverride;
  final NotebookProvider notebookProvider;
  final NoteProvider noteProvider;

  String get _notebookId => notebook?.id ?? _notebookIdOverride!;

  @override
  State<NotebookDetailScreen> createState() => _NotebookDetailScreenState();
}

class _NotebookDetailScreenState extends State<NotebookDetailScreen> {
  bool _hasOpenedInitialNote = false;

  @override
  void initState() {
    super.initState();
    widget.noteProvider.loadNotebook(widget._notebookId).then((_) {
      _maybeOpenInitialNote();
    });
  }

  void _maybeOpenInitialNote() {
    if (_hasOpenedInitialNote || widget.initialNoteId == null || !mounted) {
      return;
    }
    final match = widget.noteProvider.notes.value
        .where((n) => n.id == widget.initialNoteId)
        .toList();
    if (match.isEmpty) return;
    _hasOpenedInitialNote = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _openNote(match.first);
    });
  }

  Future<void> _createNote() async {
    final notebookId = widget._notebookId;
    final now = DateTime.now();
    final defaultPaperStyle =
        widget.notebook?.paperStyleDefault ?? 'cream';

    final note = NoteModel(
      id: IdGenerator.generate(),
      title: '',
      content: '[{"insert":"\\n"}]',
      notebookId: notebookId,
      paperStyle: defaultPaperStyle,
      createdAt: now,
      modifiedAt: now,
    );

    if (!mounted) return;
    _openNote(note, isNewNote: true);
  }

  void _openNote(NoteModel note, {bool isNewNote = false}) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => NoteEditorScreen(
              note: note,
              isNewNote: isNewNote,
              noteProvider: widget.noteProvider,
            ),
          ),
        )
        .then((_) {
          // Refresh in case the note was edited or deleted.
          if (mounted) widget.noteProvider.loadNotebook(widget._notebookId);
        });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = widget.notebook?.name ?? '';
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return AppScaffold(
      title: title,
      actions: [
        ListenableBuilder(
          listenable: widget.noteProvider.sortOrder,
          builder: (context, _) {
            return PopupMenuButton<NoteSortOrder>(
              icon: const Icon(Icons.sort),
              tooltip: l10n.sortOptionsTitle,
              onSelected: widget.noteProvider.setSortOrder,
              itemBuilder: (context) => [
                CheckedPopupMenuItem(
                  value: NoteSortOrder.modifiedDesc,
                  checked: widget.noteProvider.sortOrder.value ==
                      NoteSortOrder.modifiedDesc,
                  child: Text(l10n.sortByModified),
                ),
                CheckedPopupMenuItem(
                  value: NoteSortOrder.createdDesc,
                  checked: widget.noteProvider.sortOrder.value ==
                      NoteSortOrder.createdDesc,
                  child: Text(l10n.sortByCreated),
                ),
                CheckedPopupMenuItem(
                  value: NoteSortOrder.titleAsc,
                  checked: widget.noteProvider.sortOrder.value ==
                      NoteSortOrder.titleAsc,
                  child: Text(l10n.sortByTitle),
                ),
              ],
            );
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        tooltip: l10n.newNoteTitle,
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget.noteProvider.notes,
          widget.noteProvider.isLoading,
          widget.noteProvider.persistenceWarning,
        ]),
        builder: (context, _) {
          final warning = widget.noteProvider.persistenceWarning.value;
          return Column(
            children: [
              if (warning != null)
                Container(
                  width: double.infinity,
                  color: AppColors.warning.resolve(mode).withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    warning,
                    style: TextStyle(
                      color: AppColors.warning.resolve(mode),
                      fontSize: AppTypography.footnote.size,
                    ),
                  ),
                ),
              Expanded(child: _buildBody(context, l10n, mode)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n, AppThemeMode mode) {
    if (widget.noteProvider.isLoading.value) {
      return const Center(child: LoadingIndicator());
    }

    final notes = widget.noteProvider.notes.value;
    if (notes.isEmpty) {
      return EmptyState(
        icon: Icons.note_add_outlined,
        title: l10n.emptyNotebookTitle,
        body: l10n.emptyNotebookBody,
        action: FilledButton(
          onPressed: _createNote,
          child: Text(l10n.newNoteTitle),
        ),
      );
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
          key: ValueKey(note.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: AppColors.error.resolve(mode),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
          confirmDismiss: (_) => _confirmDeleteNote(context, l10n),
          onDismissed: (_) => widget.noteProvider.deleteNote(note.id),
          child: NoteListItem(
            title: note.title.trim().isEmpty ? l10n.untitledNote : note.title,
            previewText: '',
            dateLabel: DateFormatter.short(
              note.modifiedAt,
              localeCode: Localizations.localeOf(context).languageCode,
            ),
            onTap: () => _openNote(note),
            deleteTooltip: l10n.delete,
            onDelete: () async {
              final confirmed = await _confirmDeleteNote(context, l10n);
              if (confirmed == true) {
                await widget.noteProvider.deleteNote(note.id);
              }
            },
          ),
        );
      },
    );
  }

  /// Shared by both the swipe-to-delete gesture and the explicit delete
  /// icon button, so there's exactly one confirmation dialog to keep in
  /// sync rather than two copies drifting apart.
  Future<bool?> _confirmDeleteNote(BuildContext context, AppLocalizations l10n) {
    return ConfirmationDialog.show(
      context,
      title: l10n.deleteNoteTitle,
      body: l10n.deleteConfirmBody,
      cancelLabel: l10n.cancel,
      confirmLabel: l10n.delete,
    );
  }
}
