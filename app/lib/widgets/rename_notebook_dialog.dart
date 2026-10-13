import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import 'name_dialog.dart';

/// Shows a small dialog pre-filled with [currentName] and returns the
/// trimmed new name, or null if the user cancelled. Returns null (no
/// change) if the trimmed result matches [currentName] — avoids a
/// pointless save when nothing changed — or if it is empty, because a
/// notebook must always have a name (creating one already requires it).
Future<String?> showRenameNotebookDialog(
  BuildContext context,
  String currentName,
) async {
  final l10n = AppLocalizations.of(context)!;
  final result = await showNameDialog(
    context,
    title: l10n.notebookRenameDialogTitle,
    hint: l10n.notebookNameHint,
    initialText: currentName,
  );

  if (result == null) return null;
  final trimmed = result.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed == currentName.trim()) return null;
  return trimmed;
}
