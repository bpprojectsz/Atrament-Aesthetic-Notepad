import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// The three actions available on any notebook card from the 3-dot button.
enum NotebookAction { rename, changeCover, delete }

/// Shows the bottom-sheet menu for a notebook and returns the chosen
/// action, or null if the user dismisses without picking one.
///
/// Parallel to note_actions_menu.dart but with notebook-specific items —
/// Rename, Change cover, Delete. Move to notebook does not apply;
/// rename's dialog prefills and hints differ from the note equivalent.
Future<NotebookAction?> showNotebookActionsMenu(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final mode = Theme.of(context).brightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;

  return showModalBottomSheet<NotebookAction>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Row(
              icon: Icons.drive_file_rename_outline,
              label: l10n.notebookActionRename,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NotebookAction.rename),
            ),
            _Row(
              icon: Icons.palette_outlined,
              label: l10n.notebookActionChangeCover,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NotebookAction.changeCover),
            ),
            const Divider(height: 1),
            _Row(
              icon: Icons.delete_outline,
              label: l10n.delete,
              color: AppColors.error.resolve(mode),
              onTap: () => Navigator.pop(context, NotebookAction.delete),
            ),
          ],
        ),
      );
    },
  );
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          fontSize: AppTypography.body.size,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }
}
