import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Reusable destructive-action confirmation (delete note, delete
/// notebook). Labels are passed in already-localized by the caller.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.body,
    required this.cancelLabel,
    required this.confirmLabel,
  });

  final String title;
  final String body;
  final String cancelLabel;
  final String confirmLabel;

  /// Shows the dialog and returns `true` if the destructive action was
  /// confirmed, `false` or `null` otherwise.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    required String cancelLabel,
    required String confirmLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        body: body,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return AlertDialog(
      backgroundColor: AppColors.bgSecondary.resolve(mode),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.dialog),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppTypography.title2.size,
          fontWeight: AppTypography.title2.weight,
          color: AppColors.textPrimary.resolve(mode),
        ),
      ),
      content: Text(
        body,
        style: TextStyle(
          fontSize: AppTypography.body.size,
          color: AppColors.textSecondary.resolve(mode),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelLabel,
            style: TextStyle(color: AppColors.textSecondary.resolve(mode)),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmLabel,
            style: TextStyle(
              color: AppColors.error.resolve(mode),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
