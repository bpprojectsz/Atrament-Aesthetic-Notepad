import 'dart:async';

import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/note_model.dart';
import '../core/models/notebook_model.dart';
import '../core/models/paper_style_model.dart';
import '../core/providers/locale_provider.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/notebook_provider.dart';
import '../core/providers/subscription_provider.dart';
import '../core/providers/theme_provider.dart';
import '../core/services/export_service.dart';
import '../core/utils/constants.dart';
import '../core/utils/date_formatter.dart';
import '../core/utils/export_helper.dart';
import '../core/utils/id_generator.dart';
import '../core/utils/quill_content_helper.dart';
import '../core/utils/route_observer.dart';
import '../platform/interstitial_service.dart';
import '../platform/share_service.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/chips_row.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/cover_color_picker.dart';
import '../widgets/empty_state.dart';
import '../widgets/language_picker.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/move_to_notebook_sheet.dart';
import '../widgets/note_actions_menu.dart';
import '../widgets/note_card.dart';
import '../widgets/note_list_item.dart';
import '../widgets/notebook_actions_menu.dart';
import '../widgets/rename_note_dialog.dart';
import '../widgets/rename_notebook_dialog.dart';
import 'note_editor_screen.dart';
import 'notebook_detail_screen.dart';
import 'settings_screen.dart';

/// Notebook grid dashboard — the app's landing screen. A search field
/// switches the body between the notebook grid and full-text note search
/// results; an FAB creates a new notebook; a banner ad renders at the
/// bottom for free-tier users.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.notebookProvider,
    required this.noteProvider,
    required this.subscriptionProvider,
  });

  final NotebookProvider notebookProvider;
  final NoteProvider noteProvider;
  final SubscriptionProvider subscriptionProvider;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();
  HomeChip _selected = HomeChip.all;

  bool _routeObserverSubscribed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_routeObserverSubscribed) {
      final route = ModalRoute.of(context);
      if (route is PageRoute) {
        appRouteObserver.subscribe(this, route);
        _routeObserverSubscribed = true;
      }
    }
  }

  /// Reloads all notes when the user pops back to home. Screens pushed on
  /// top of home (notebook detail, editor) call `noteProvider.loadNotebook`
  /// which narrows the provider's `notes` to that notebook's subset.
  /// Without this hook the home list would stay collapsed to that subset
  /// until the next cold start.
  @override
  void didPopNext() {
    widget.noteProvider.loadAllNotes();
  }

  @override
  void initState() {
    super.initState();
    widget.notebookProvider.loadNotebooks();
    widget.noteProvider.loadAllNotes();
  }

  @override
  void dispose() {
    if (_routeObserverSubscribed) {
      appRouteObserver.unsubscribe(this);
    }
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _createNotebook() async {
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
    if (trimmed == null || trimmed.isEmpty || !mounted) return;

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
    if (!mounted) return;
    if (succeeded) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotebookDetailScreen(
            notebook: notebook,
            notebookProvider: widget.notebookProvider,
            noteProvider: widget.noteProvider,
          ),
        ),
      );
    } else {
      _showSnackBar(l10n.saveFailedMessage);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return AppScaffold(
      title: l10n.appName,
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          tooltip: l10n.themeSectionTitle,
          onPressed: _cycleTheme,
        ),
        IconButton(
          icon: const Icon(Icons.translate),
          tooltip: l10n.languageSectionTitle,
          onPressed: () => showLanguagePicker(
            context,
            context.read<LocaleProvider>(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.note_add),
          tooltip: l10n.newNotebookTitle,
          onPressed: _createNotebook,
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: l10n.settingsTitle,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        tooltip: l10n.newNoteTitle,
        child: const Icon(Icons.add),
      ),
      bottomAdSlot: ListenableBuilder(
        listenable: widget.subscriptionProvider.status,
        builder: (context, _) {
          if (!widget.subscriptionProvider.shouldShowAds) {
            return const SizedBox.shrink();
          }
          return BannerAdWidget(subscriptionProvider: widget.subscriptionProvider);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _searchController,
              onChanged: widget.noteProvider.search,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.bgTertiary.resolve(mode),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.textInput),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ChipsRow(
              selected: _selected,
              onSelected: (chip) => setState(() => _selected = chip),
              allLabel: l10n.chipAll,
              notebooksLabel: l10n.chipNotebooks,
              recentLabel: l10n.chipRecent,
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.noteProvider.searchQuery,
                builder: (context, _) {
                  final isSearching =
                      widget.noteProvider.searchQuery.value.trim().isNotEmpty;
                  return isSearching ? _buildSearchResults() : _buildBodyForChip();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cycleTheme() {
    final provider = context.read<ThemeProvider>();
    const order = [
      ThemePreference.system,
      ThemePreference.light,
      ThemePreference.dark,
      ThemePreference.parchment,
    ];
    final current = provider.preference.value;
    final next = order[(order.indexOf(current) + 1) % order.length];
    provider.setPreference(next);
  }

  Future<void> _createNote() async {
    final prefs = await SharedPreferences.getInstance();
    final paperStyle =
        prefs.getString(AppConstants.prefPaperStyleDefault) ?? 'cream';
    final now = DateTime.now();
    final note = NoteModel(
      id: IdGenerator.generate(),
      title: '',
      content: '[{"insert":"\\n"}]',
      notebookId: null,
      paperStyle: paperStyle,
      createdAt: now,
      modifiedAt: now,
    );
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          note: note,
          noteProvider: widget.noteProvider,
          isNewNote: true,
        ),
      ),
    );
  }

  Future<void> _handleNotebookAction(NotebookModel notebook) async {
    final action = await showNotebookActionsMenu(context);
    if (action == null || !mounted) return;

    switch (action) {
      case NotebookAction.rename:
        await _handleNotebookRename(notebook);
        break;
      case NotebookAction.changeCover:
        await _handleNotebookChangeCover(notebook);
        break;
      case NotebookAction.delete:
        await _handleNotebookDelete(notebook);
        break;
    }
  }

  Future<void> _handleNotebookRename(NotebookModel notebook) async {
    final newName = await showRenameNotebookDialog(context, notebook.name);
    if (newName == null || !mounted) return;
    await widget.notebookProvider.updateNotebook(
      notebook.copyWith(name: newName),
    );
  }

  Future<void> _handleNotebookChangeCover(NotebookModel notebook) async {
    final picked = await showCoverColorPicker(
      context,
      currentColor: notebook.coverColor,
    );
    if (picked == null || !mounted) return;
    if (picked == notebook.coverColor) return;
    await widget.notebookProvider.updateNotebook(
      notebook.copyWith(coverColor: picked),
    );
  }

  Future<void> _handleNotebookDelete(NotebookModel notebook) async {
    final l10n = AppLocalizations.of(context)!;
    final count = await widget.noteProvider.countNotesIn(notebook.id);
    if (!mounted) return;
    final body = count > 0
        ? l10n.deleteNotebookWithCountBody(count)
        : l10n.deleteConfirmBody;
    final confirmed = await ConfirmationDialog.show(
      context,
      title: l10n.deleteNotebookTitle(notebook.name),
      body: body,
      cancelLabel: l10n.cancel,
      confirmLabel: l10n.delete,
    );
    if (confirmed == true) {
      await widget.notebookProvider.deleteNotebook(notebook.id);
    }
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
        _openNoteForEdit(note);
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
    await widget.noteProvider.saveNote(
      updated,
      plainTextContent: plainTextFromContent(note.content),
    );
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

  void _openNoteForEdit(NoteModel note) {
    final notebookId = note.notebookId;
    if (notebookId == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteEditorScreen(
            note: note,
            noteProvider: widget.noteProvider,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotebookDetailScreen.editingNote(
            noteId: note.id,
            notebookId: notebookId,
            notebookProvider: widget.notebookProvider,
            noteProvider: widget.noteProvider,
          ),
        ),
      );
    }
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
    final confirmed = await ConfirmationDialog.show(
      context,
      title: l10n.deleteNoteTitle,
      body: l10n.deleteConfirmBody,
      cancelLabel: l10n.cancel,
      confirmLabel: l10n.delete,
    );
    if (confirmed == true) {
      await widget.noteProvider.deleteNote(note.id);
    }
  }

  Widget _buildBodyForChip() {
    switch (_selected) {
      case HomeChip.all:
        return _buildAllNotes();
      case HomeChip.notebooks:
        return _buildNotebookGrid();
      case HomeChip.recent:
        return _buildRecentNotes();
    }
  }

  Widget _buildAllNotes() {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.noteProvider.notes,
        widget.noteProvider.isLoading,
      ]),
      builder: (context, _) {
        if (widget.noteProvider.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }
        final notes = widget.noteProvider.notes.value;
        if (notes.isEmpty) {
          return EmptyState(
            icon: Icons.note_outlined,
            title: l10n.emptyAllNotesTitle,
            body: l10n.emptyAllNotesBody,
          );
        }
        return _buildNoteList(notes);
      },
    );
  }

  Widget _buildRecentNotes() {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.noteProvider.notes,
        widget.noteProvider.isLoading,
      ]),
      builder: (context, _) {
        if (widget.noteProvider.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }
        final notes = widget.noteProvider.notes.value;
        if (notes.isEmpty) {
          return EmptyState(
            icon: Icons.history,
            title: l10n.emptyRecentNotesTitle,
            body: l10n.emptyRecentNotesBody,
          );
        }
        return _buildNoteList(notes);
      },
    );
  }

  Widget _buildNoteList(List<NoteModel> notes) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteListItem(
          title: note.title.trim().isEmpty ? l10n.untitledNote : note.title,
          previewText: '',
          dateLabel: DateFormatter.short(
            note.modifiedAt,
            localeCode: Localizations.localeOf(context).languageCode,
          ),
          onTap: () {
            final notebookId = note.notebookId;
            if (notebookId == null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                    note: note,
                    noteProvider: widget.noteProvider,
                  ),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotebookDetailScreen.editingNote(
                    noteId: note.id,
                    notebookId: notebookId,
                    notebookProvider: widget.notebookProvider,
                    noteProvider: widget.noteProvider,
                  ),
                ),
              );
            }
          },
          onMore: () => _handleNoteAction(note),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.noteProvider.notes,
        widget.noteProvider.isLoading,
      ]),
      builder: (context, _) {
        if (widget.noteProvider.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }
        final results = widget.noteProvider.notes.value;
        if (results.isEmpty) {
          return EmptyState(
            icon: Icons.search_off,
            title: l10n.emptySearchTitle,
            body: l10n.emptySearchBody,
          );
        }
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final note = results[index];
            return NoteListItem(
              title: note.title.trim().isEmpty ? l10n.untitledNote : note.title,
              previewText: '',
              dateLabel: DateFormatter.short(
                note.modifiedAt,
                localeCode: Localizations.localeOf(context).languageCode,
              ),
              onTap: () {
                final notebookId = note.notebookId;
                if (notebookId == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteEditorScreen(
                        note: note,
                        noteProvider: widget.noteProvider,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotebookDetailScreen.editingNote(
                        noteId: note.id,
                        notebookId: notebookId,
                        notebookProvider: widget.notebookProvider,
                        noteProvider: widget.noteProvider,
                      ),
                    ),
                  );
                }
              },
              onMore: () => _handleNoteAction(note),
            );
          },
        );
      },
    );
  }

  Widget _buildNotebookGrid() {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.notebookProvider.notebooks,
        widget.notebookProvider.isLoading,
      ]),
      builder: (context, _) {
        if (widget.notebookProvider.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }
        final notebooks = widget.notebookProvider.notebooks.value;
        if (notebooks.isEmpty) {
          return EmptyState(
            icon: Icons.menu_book_outlined,
            title: l10n.emptyNotebooksTitle,
            body: l10n.emptyNotebooksBody,
            action: FilledButton(
              onPressed: _createNotebook,
              child: Text(l10n.newNotebookTitle),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: notebooks.length,
          itemBuilder: (context, index) {
            final notebook = notebooks[index];
            return NoteCard(
              title: notebook.name,
              dateLabel: DateFormatter.short(
                notebook.modifiedAt,
                localeCode: Localizations.localeOf(context).languageCode,
              ),
              paperStyle: PaperStyleCatalog.byId(notebook.paperStyleDefault),
              coverColor: notebook.coverColor,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotebookDetailScreen(
                      notebook: notebook,
                      notebookProvider: widget.notebookProvider,
                      noteProvider: widget.noteProvider,
                    ),
                  ),
                );
              },
              onLongPress: () => _handleNotebookDelete(notebook),
              onMore: () => _handleNotebookAction(notebook),
            );
          },
        );
      },
    );
  }
}
