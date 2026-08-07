import 'package:flutter/material.dart';

import '../core/models/verse_model.dart';
import '../core/utils/constants.dart';
import 'verse_display.dart';

/// Thin verse reference line shown at the bottom of a note page when the
/// user's verse display mode is set to "footer". Shows the reference only
/// — the full text is available via the header or watermark modes.
class ScriptureFooter extends StatelessWidget {
  const ScriptureFooter({
    super.key,
    required this.verse,
    this.fontScale = 1.0,
  });

  final VerseModel verse;
  final double fontScale;

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.textTertiary.resolve(
      Theme.of(context).brightness == Brightness.dark
          ? AppThemeMode.dark
          : AppThemeMode.light,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: VerseDisplay(
        reference: verse.reference,
        content: VerseDisplayContent.referenceOnly,
        fontScale: fontScale * 0.85,
        color: textColor,
        textAlign: TextAlign.center,
        italic: true,
      ),
    );
  }
}
