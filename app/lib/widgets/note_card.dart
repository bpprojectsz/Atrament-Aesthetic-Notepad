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
    this.coverColor,
    this.onMore,
  });

  final String title;
  final String dateLabel;
  final PaperStyleModel paperStyle;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Optional ARGB value rendered as a 6px strip across the top edge.
  /// Notebook cards pass the user's chosen cover colour; note cards pass
  /// nothing and render without the strip.
  final int? coverColor;

  /// Optional trailing menu callback. When non-null, renders a 3-dot
  /// button in the top-right corner of the paper thumbnail, floating
  /// over the texture with a translucent scrim for contrast.
  final VoidCallback? onMore;

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
                if (coverColor != null)
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color(coverColor!),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.card),
                      ),
                    ),
                  ),
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.card),
                  ),
                  child: Stack(
                    children: [
                      AspectRatio(
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
                      if (onMore != null)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Material(
                            color: Colors.black.withValues(alpha: 0.35),
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: onMore,
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
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
