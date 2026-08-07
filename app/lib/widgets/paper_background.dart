import 'package:flutter/material.dart';

import '../core/models/paper_style_model.dart';

/// Renders the selected paper texture as a full-bleed background. Falls
/// back to a solid color if the texture asset ever fails to load, so a
/// missing/corrupt asset degrades to a plain background rather than a
/// broken-image icon.
class PaperBackground extends StatelessWidget {
  const PaperBackground({
    super.key,
    required this.style,
    this.child,
  });

  final PaperStyleModel style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          style.assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: style.isDark ? Colors.black : Colors.white,
            );
          },
        ),
        if (child != null) child!,
      ],
    );
  }
}
