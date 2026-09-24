import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Shows a small dialog pre-filled with [currentTitle] and returns the
/// trimmed new title, or null if the user cancelled. Returns null (no
/// change) if the trimmed result matches [currentTitle] — avoids a
/// pointless save when nothing changed.
Future<String?> showRenameNoteDialog(
  BuildContext context,
  String currentTitle,
) async {
  final l10n = AppLocalizations.of(context)!;
  final controller = TextEditingController(text: currentTitle);

  final result = await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.noteActionRename),
        content: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(hintText: l10n.untitledNote),
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
  if (trimmed == currentTitle.trim()) return null;
  return trimmed;
}
