import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import 'name_dialog.dart';

/// Asks for a new notebook's name. Returns the trimmed name, or null if the
/// user cancelled or left it empty.
Future<String?> showNewNotebookDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final result = await showNameDialog(
    context,
    title: l10n.newNotebookTitle,
    hint: l10n.notebookNameHint,
  );
  final trimmed = result?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}
