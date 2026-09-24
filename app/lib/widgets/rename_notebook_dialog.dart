import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Shows a small dialog pre-filled with [currentName] and returns the
/// trimmed new name, or null if the user cancelled. Returns null (no
/// change) if the trimmed result matches [currentName] — avoids a
/// pointless save when nothing changed.
Future<String?> showRenameNotebookDialog(
  BuildContext context,
  String currentName,
) async {
  final l10n = AppLocalizations.of(context)!;
  final controller = TextEditingController(text: currentName);

  final result = await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.notebookRenameDialogTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(hintText: l10n.notebookNameHint),
          onSubmitted: (value) => Navigator.pop(context, value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(l10n.save),
          ),
        ],
      );
    },
  );

  controller.dispose();

  if (result == null) return null;
  final trimmed = result.trim();
  if (trimmed == currentName.trim()) return null;
  return trimmed;
}
