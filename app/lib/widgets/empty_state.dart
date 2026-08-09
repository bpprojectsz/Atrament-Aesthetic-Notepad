import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Empty state used for zero-notebook home screens, zero-note notebooks,
/// and zero search results. Icon-based rather than a bundled illustration
/// asset, so it needs no image asset dependency.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final iconColor = AppColors.textTertiary.resolve(mode);
    final titleColor = AppColors.textPrimary.resolve(mode);
    final bodyColor = AppColors.textSecondary.resolve(mode);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: iconColor),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTypography.title1.size,
                fontWeight: AppTypography.title1.weight,
                height: AppTypography.title1.height,
                color: titleColor,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTypography.body.size,
                height: AppTypography.body.height,
                color: bodyColor,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
