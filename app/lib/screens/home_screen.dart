import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/models/notebook_model.dart';
import '../core/models/paper_style_model.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/notebook_provider.dart';
import '../core/providers/subscription_provider.dart';
import '../core/utils/constants.dart';
import '../core/utils/date_formatter.dart';
import '../core/utils/id_generator.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/note_card.dart';
import '../widgets/note_list_item.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.notebookProvider.loadNotebooks();
  }

  @override
  void dispose() {
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
        onPressed: _createNotebook,
        tooltip: l10n.newNotebookTitle,
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
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.noteProvider.searchQuery,
                builder: (context, _) {
                  final isSearching =
                      widget.noteProvider.searchQuery.value.trim().isNotEmpty;
                  return isSearching ? _buildSearchResults() : _buildNotebookGrid();
                },
              ),
            ),
          ],
        ),
      ),
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
              title: note.title,
              previewText: '',
              dateLabel: DateFormatter.short(
                note.modifiedAt,
                localeCode: Localizations.localeOf(context).languageCode,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotebookDetailScreen.editingNote(
                      noteId: note.id,
                      notebookId: note.notebookId,
                      notebookProvider: widget.notebookProvider,
                      noteProvider: widget.noteProvider,
                    ),
                  ),
                );
              },
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
              onLongPress: () async {
                final confirmed = await ConfirmationDialog.show(
                  context,
                  title: l10n.deleteNotebookTitle(notebook.name),
                  body: l10n.deleteConfirmBody,
                  cancelLabel: l10n.cancel,
                  confirmLabel: l10n.delete,
                );
                if (confirmed == true) {
                  await widget.notebookProvider.deleteNotebook(notebook.id);
                }
              },
            );
          },
        );
      },
    );
  }
}
