import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import 'name_dialog.dart';

/// Shows a small dialog pre-filled with [currentTitle] and returns the
/// trimmed new title, or null if the user cancelled. Returns null (no
/// change) if the trimmed result matches [currentTitle] — avoids a
/// pointless save when nothing changed. An empty title is allowed: the note
/// then shows its first line as the title.
Future<String?> showRenameNoteDialog(
  BuildContext context,
  String currentTitle,
) async {
  final l10n = AppLocalizations.of(context)!;
  final result = await showNameDialog(
    context,
    title: l10n.noteActionRename,
    hint: l10n.untitledNote,
    initialText: currentTitle,
  );

  if (result == null) return null;
  final trimmed = result.trim();
  if (trimmed == currentTitle.trim()) return null;
  return trimmed;
}
