import 'package:flutter/material.dart';

import '../core/models/paper_style_model.dart';
import '../core/utils/constants.dart';

/// Preview card for grid views (home screen notebook grid, note grid)
/// showing a title, a relative date label, and a small paper-texture
/// thumbnail strip.
class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.dateLabel,
    required this.paperStyle,
    required this.onTap,
    this.onLongPress,
  });

  final String title;
  final String dateLabel;
  final PaperStyleModel paperStyle;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final borderColor = AppColors.borderSubtle.resolve(mode);
    final bgColor = AppColors.bgSecondary.resolve(mode);
    final titleColor = AppColors.textPrimary.resolve(mode);
    final dateColor = AppColors.textTertiary.resolve(mode);

    return Semantics(
      button: true,
      label: '$title, $dateLabel',
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.card),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            constraints: const BoxConstraints(minHeight: AppElevation.minTouchTarget * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: borderColor,
                width: AppElevation.cardBorderWidth,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.card),
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      paperStyle.assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return ColoredBox(
                          color: paperStyle.isDark
                              ? Colors.black12
                              : Colors.white,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppTypography.title2.size,
                          fontWeight: AppTypography.title2.weight,
                          height: AppTypography.title2.height,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        dateLabel,
                        style: TextStyle(
                          fontSize: AppTypography.footnote.size,
                          fontWeight: AppTypography.footnote.weight,
                          height: AppTypography.footnote.height,
                          color: dateColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
