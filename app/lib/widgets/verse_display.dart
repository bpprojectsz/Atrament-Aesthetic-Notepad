import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// How much of the verse to render — the reference alone, or the full
/// text with reference.
enum VerseDisplayContent { referenceOnly, full }

/// Renders a verse in the bundled Merriweather serif font, sized from
/// [AppTypography.callout] and scaled by [fontScale] (the user's
/// scripture-font-size preference from `verse_provider.dart`).
///
/// This widget only formats text — it has no opinion on placement,
/// opacity, or background; [ScriptureWatermark], [ScriptureHeader], and
/// [ScriptureFooter] each wrap it differently for their own layout.
class VerseDisplay extends StatelessWidget {
  const VerseDisplay({
    super.key,
    required this.reference,
    this.text,
    this.content = VerseDisplayContent.full,
    this.fontScale = 1.0,
    this.color,
    this.textAlign = TextAlign.start,
    this.italic = false,
  });

  final String reference;
  final String? text;
  final VerseDisplayContent content;
  final double fontScale;
  final Color? color;
  final TextAlign textAlign;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.onSurface;
    final baseStyle = TextStyle(
      fontFamily: 'Merriweather',
      fontSize: AppTypography.callout.size * fontScale,
      fontWeight: AppTypography.callout.weight,
      height: AppTypography.callout.height,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: resolvedColor,
    );

    if (content == VerseDisplayContent.referenceOnly || text == null) {
      return Semantics(
        label: reference,
        child: Text(reference, style: baseStyle, textAlign: textAlign),
      );
    }

    return Semantics(
      label: '$text — $reference',
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text!, style: baseStyle, textAlign: textAlign),
          SizedBox(height: AppSpacing.xxs),
          Text(
            reference,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppTypography.footnote.size * fontScale,
            ),
            textAlign: textAlign,
          ),
        ],
      ),
    );
  }
}
