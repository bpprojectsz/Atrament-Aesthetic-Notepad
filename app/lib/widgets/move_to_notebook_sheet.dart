import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/models/notebook_model.dart';
import '../core/utils/constants.dart';

/// Sentinel returned by [showMoveToNotebookSheet] when the user chooses
/// the "Create new notebook" row. A literal id is never equal to this
/// string, so callers can safely check `if (result == kCreateNotebookSentinel)`
/// before treating the result as a notebook id.
const String kCreateNotebookSentinel = '__create__';

/// Shows a bottom sheet listing the user's notebooks as move targets.
/// Returns the selected notebook id, [kCreateNotebookSentinel] if the user
/// tapped "Create new notebook", or null if dismissed.
///
/// The [currentNotebookId] target (if the note already belongs to one) is
/// omitted from the list — moving a note into its own notebook is a no-op
/// the user cannot want. If the only notebook in [notebooks] is the current
/// one, the list is empty and only the "Create new notebook" row appears,
/// which matches decision A3.
Future<String?> showMoveToNotebookSheet(
  BuildContext context, {
  required List<NotebookModel> notebooks,
  required String? currentNotebookId,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final mode = Theme.of(context).brightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;
  final targets = notebooks
      .where((n) => n.id != currentNotebookId)
      .toList(growable: false);

  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: Text(
                  l10n.moveToNotebookTitle,
                  style: TextStyle(
                    fontSize: AppTypography.title2.size,
                    fontWeight: AppTypography.title2.weight,
                    color: AppColors.textPrimary.resolve(mode),
                  ),
                ),
              ),
              const Divider(height: 1),
              for (final notebook in targets)
                ListTile(
                  leading: Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.textSecondary.resolve(mode),
                  ),
                  title: Text(notebook.name),
                  onTap: () => Navigator.pop(context, notebook.id),
                ),
              if (targets.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    l10n.moveToNotebookEmptyBody,
                    style: TextStyle(
                      fontSize: AppTypography.footnote.size,
                      color: AppColors.textTertiary.resolve(mode),
                    ),
                  ),
                ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(
                  Icons.create_new_folder_outlined,
                  color: AppColors.accent.resolve(mode),
                ),
                title: Text(
                  l10n.moveToNotebookCreateRow,
                  style: TextStyle(
                    color: AppColors.accent.resolve(mode),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => Navigator.pop(context, kCreateNotebookSentinel),
              ),
            ],
          ),
        ),
      );
    },
  );
}
