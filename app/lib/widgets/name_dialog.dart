import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

/// A small one-field dialog that owns its [TextEditingController].
///
/// The controller lives in this widget's State and is disposed with it, so it
/// is never disposed while the dialog is still animating out (which happens
/// if the caller disposes right after `showDialog` returns).
///
/// Returns the raw text on Save (or when submitted from the keyboard), or
/// null on Cancel.
Future<String?> showNameDialog(
  BuildContext context, {
  required String title,
  required String hint,
  String initialText = '',
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _NameDialog(title: title, hint: hint, initialText: initialText),
  );
}

class _NameDialog extends StatefulWidget {
  const _NameDialog({
    required this.title,
    required this.hint,
    required this.initialText,
  });

  final String title;
  final String hint;
  final String initialText;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialText,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(hintText: widget.hint),
        onSubmitted: (value) => Navigator.of(context).pop(value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
