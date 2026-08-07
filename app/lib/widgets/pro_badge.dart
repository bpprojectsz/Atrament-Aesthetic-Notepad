import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Small gold accent badge indicating premium feature context. Used
/// sparingly in Settings — the app has no feature gating (Section 19), so
/// this never blocks interaction; it's purely informational.
class ProBadge extends StatelessWidget {
  const ProBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final accent = AppColors.accent.resolve(mode);

    return Semantics(
      label: label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.12),
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(color: accent.withOpacity(0.4), width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppTypography.caption.size,
            fontWeight: FontWeight.w600,
            color: accent,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
