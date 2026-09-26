import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/constants.dart';

/// The six actions available on any note row from the 3-dot button.
enum NoteAction { rename, moveToNotebook, edit, export, share, delete }

/// Shows the bottom-sheet menu for a note and returns the chosen action,
/// or null if the user dismisses without picking one.
///
/// Deliberately widget-agnostic — takes no NoteModel and returns only the
/// selected enum value. Callers map the result to their own logic so the
/// same menu can be used from any screen without coupling.
Future<NoteAction?> showNoteActionsMenu(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final mode = Theme.of(context).brightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;

  return showModalBottomSheet<NoteAction>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MenuRow(
              icon: Icons.drive_file_rename_outline,
              label: l10n.noteActionRename,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.rename),
            ),
            _MenuRow(
              icon: Icons.drive_file_move_outline,
              label: l10n.noteActionMoveToNotebook,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.moveToNotebook),
            ),
            _MenuRow(
              icon: Icons.edit_outlined,
              label: l10n.noteActionEdit,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.edit),
            ),
            const Divider(height: 1),
            _MenuRow(
              icon: Icons.file_download_outlined,
              label: l10n.noteActionExport,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.export),
            ),
            _MenuRow(
              icon: Icons.share_outlined,
              label: l10n.noteActionShare,
              color: AppColors.textPrimary.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.share),
            ),
            const Divider(height: 1),
            _MenuRow(
              icon: Icons.delete_outline,
              label: l10n.delete,
              color: AppColors.error.resolve(mode),
              onTap: () => Navigator.pop(context, NoteAction.delete),
            ),
          ],
        ),
      );
    },
  );
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
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
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
    );
  }
}
