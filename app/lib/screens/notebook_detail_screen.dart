import 'dart:async';

import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/models/note_model.dart';
import '../core/models/notebook_model.dart';
import '../core/models/paper_style_model.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/notebook_provider.dart';
import '../core/providers/subscription_provider.dart';
import '../core/services/export_service.dart';
import '../core/utils/constants.dart';
import '../core/utils/date_formatter.dart';
import '../core/utils/export_helper.dart';
import '../core/utils/id_generator.dart';
import '../core/utils/quill_content_helper.dart';
import '../platform/interstitial_service.dart';
import '../platform/share_service.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/move_to_notebook_sheet.dart';
import '../widgets/note_actions_menu.dart';
import '../widgets/note_list_item.dart';
import '../widgets/rename_note_dialog.dart';
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
    InterstitialService.instance.recordNoteCreate();
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
    // In the `.editingNote` constructor path, `widget.notebook` is null
    // (only the id override is set), so resolve the name from the provider
    // to keep the AppBar titled instead of blank.
    final title = widget.notebook?.name ??
        widget.notebookProvider.notebooks.value
            .where((n) => n.id == widget._notebookId)
            .map((n) => n.name)
            .firstWhere((_) => true, orElse: () => '');
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final subscriptionProvider = context.read<SubscriptionProvider>();

    return AppScaffold(
      title: title,
      bottomAdSlot: BannerAdWidget(subscriptionProvider: subscriptionProvider),
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
                  color: AppColors.warning.resolve(mode).withValues(alpha: 0.15),
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
            onMore: () => _handleNoteAction(note),
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

  Future<void> _handleNoteAction(NoteModel note) async {
    final action = await showNoteActionsMenu(context);
    if (action == null || !mounted) return;

    switch (action) {
      case NoteAction.rename:
        await _handleRename(note);
        break;
      case NoteAction.moveToNotebook:
        await _handleMoveToNotebook(note);
        break;
      case NoteAction.edit:
        _openNote(note);
        break;
      case NoteAction.export:
        await _handleExport(note);
        break;
      case NoteAction.share:
        await _handleShare(note);
        break;
      case NoteAction.delete:
        await _handleDelete(note);
        break;
    }
  }

  Future<void> _handleRename(NoteModel note) async {
    final newTitle = await showRenameNoteDialog(context, note.title);
    if (newTitle == null || !mounted) return;
    final updated = note.copyWith(title: newTitle, modifiedAt: DateTime.now());
    await widget.noteProvider.saveNote(
      updated,
      plainTextContent: plainTextFromContent(note.content),
    );
  }

  Future<void> _handleMoveToNotebook(NoteModel note) async {
    final target = await showMoveToNotebookSheet(
      context,
      notebooks: widget.notebookProvider.notebooks.value,
      currentNotebookId: note.notebookId,
    );
    if (target == null || !mounted) return;

    final String targetId;
    if (target == kCreateNotebookSentinel) {
      final created = await _promptNewNotebookName();
      if (created == null || !mounted) return;
      targetId = created;
    } else {
      targetId = target;
    }

    final updated = note.copyWith(
      notebookId: targetId,
      modifiedAt: DateTime.now(),
    );
    final saved = await widget.noteProvider.saveNote(
      updated,
      plainTextContent: plainTextFromContent(note.content),
    );
    // The moved note may have left this notebook — reload so it disappears
    // from the list if the target differs from the current one.
    if (saved && mounted) {
      await widget.noteProvider.loadNotebook(widget._notebookId);
    }
  }

  Future<String?> _promptNewNotebookName() async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.newNotebookTitle),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.notebookNameHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(nameController.text),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    nameController.dispose();
    final trimmed = name?.trim();
    if (trimmed == null || trimmed.isEmpty || !mounted) return null;

    final now = DateTime.now();
    final notebook = NotebookModel(
      id: IdGenerator.generate(),
      name: trimmed,
      coverColor: AppColors.accent.light.toARGB32(),
      paperStyleDefault: PaperStyleCatalog.all.first.id,
      sortOrder: widget.notebookProvider.notebooks.value.length,
      createdAt: now,
      modifiedAt: now,
    );
    final succeeded = await widget.notebookProvider.createNotebook(notebook);
    if (!succeeded) return null;
    return notebook.id;
  }

  Future<void> _handleExport(NoteModel note) async {
    final l10n = AppLocalizations.of(context)!;
    final format = await showModalBottomSheet<ExportFormat>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(l10n.exportAsTxt),
              onTap: () => Navigator.pop(context, ExportFormat.txt),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(l10n.exportAsPdf),
              onTap: () => Navigator.pop(context, ExportFormat.pdf),
            ),
          ],
        ),
      ),
    );
    if (format == null || !mounted) return;

    final exportable = _buildExportable(note, l10n);
    const exportService = ExportService();
    final result = format == ExportFormat.txt
        ? await exportService.exportAsTxt(exportable)
        : await exportService.exportAsPdf(exportable);
    if (!mounted) return;

    if (!result.succeeded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? l10n.exportFailedMessage),
        ),
      );
      return;
    }

    const shareService = ShareService();
    final shareResult = await shareService.shareFile(
      result.filePath!,
      subject: exportable.title,
    );
    if (!mounted) return;
    if (shareResult.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.shareFailedMessage)),
      );
    }
    unawaited(InterstitialService.instance.showAfterExport());
  }

  Future<void> _handleShare(NoteModel note) async {
    final l10n = AppLocalizations.of(context)!;
    final exportable = _buildExportable(note, l10n);
    const shareService = ShareService();
    final body = exportable.plainTextContent.isEmpty
        ? exportable.title
        : '${exportable.title}\n\n${exportable.plainTextContent}';
    final result = await shareService.shareText(body, subject: exportable.title);
    if (!mounted) return;
    if (result.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.shareFailedMessage)),
      );
    }
  }

  ExportableNote _buildExportable(NoteModel note, AppLocalizations l10n) {
    return ExportableNote(
      title: note.title.trim().isEmpty ? l10n.untitledNote : note.title,
      plainTextContent: plainTextFromContent(note.content),
      createdAtLabel: DateFormatter.short(
        note.createdAt,
        localeCode: Localizations.localeOf(context).languageCode,
      ),
      verseReferenceLabel: note.verseReference,
    );
  }

  Future<void> _handleDelete(NoteModel note) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await _confirmDeleteNote(context, l10n);
    if (confirmed == true) {
      await widget.noteProvider.deleteNote(note.id);
    }
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
