import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Branded loading spinner. A thin wrapper over [CircularProgressIndicator]
/// that resolves its color from the design tokens instead of the ambient
/// Material theme, so it stays visually consistent across all three
/// theme modes.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.accent.resolve(mode),
        ),
      ),
    );
  }
}
