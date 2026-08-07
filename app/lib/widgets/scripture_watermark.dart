import 'package:flutter/material.dart';

import '../core/models/verse_model.dart';
import 'verse_display.dart';

/// Faint verse overlay (~8% opacity) rendered behind editor content.
/// Positioned centered or bottom-right per [alignment].
class ScriptureWatermark extends StatelessWidget {
  const ScriptureWatermark({
    super.key,
    required this.verse,
    this.fontScale = 1.0,
    this.alignment = Alignment.bottomRight,
  });

  final VerseModel verse;
  final double fontScale;

  /// Typically [Alignment.center] or [Alignment.bottomRight] per the
  /// design spec.
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    // Watermarks must never intercept touches meant for the editor
    // underneath, and are excluded from the semantics tree since they're
    // decorative, not primary content (the same verse text is available
    // through the header/footer toggle when the user wants it announced).
    return Positioned.fill(
      child: IgnorePointer(
        child: ExcludeSemantics(
          child: Align(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Opacity(
                opacity: 0.08,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 260),
                  child: VerseDisplay(
                    reference: verse.reference,
                    text: verse.text,
                    fontScale: fontScale * 1.3,
                    textAlign: alignment == Alignment.center
                        ? TextAlign.center
                        : TextAlign.right,
                    italic: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
