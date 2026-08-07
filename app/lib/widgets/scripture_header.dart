import 'package:flutter/material.dart';

import '../core/models/verse_model.dart';
import '../core/utils/constants.dart';
import 'verse_display.dart';

/// Thin small-caps-style verse line shown at the top of a note page when
/// the user's verse display mode is set to "header".
class ScriptureHeader extends StatelessWidget {
  const ScriptureHeader({
    super.key,
    required this.verse,
    this.fontScale = 1.0,
  });

  final VerseModel verse;
  final double fontScale;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.borderSubtle.resolve(
      Theme.of(context).brightness == Brightness.dark
          ? AppThemeMode.dark
          : AppThemeMode.light,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: VerseDisplay(
        reference: verse.reference,
        text: verse.text,
        content: VerseDisplayContent.full,
        fontScale: fontScale * 0.9,
        textAlign: TextAlign.center,
      ),
    );
  }
}
