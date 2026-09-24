import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Dense list tile used in `notebook_detail_screen.dart`. Trades the
/// thumbnail image in [NoteCard] for a compact single-line layout suited
/// to scanning many notes quickly.
class NoteListItem extends StatelessWidget {
  const NoteListItem({
    super.key,
    required this.title,
    required this.previewText,
    required this.dateLabel,
    required this.onTap,
    this.onLongPress,
    this.onDelete,
    this.deleteTooltip,
    this.onMore,
    this.moreTooltip,
  });

  final String title;
  final String previewText;
  final String dateLabel;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Explicit, always-visible delete action — shown as a trailing icon
  /// button when provided, alongside (not instead of) any swipe-to-delete
  /// gesture the caller wraps this widget in. Swipe alone has no visual
  /// affordance hinting it exists, which makes deletion easy to miss
  /// entirely; this gives every user a discoverable way to delete a note
  /// regardless of whether they'd ever try swiping.
  final VoidCallback? onDelete;
  final String? deleteTooltip;

  /// Trailing 3-dot button. When non-null, renders an icon button in the
  /// trailing position, next to the delete icon if both are provided.
  final VoidCallback? onMore;
  final String? moreTooltip;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final titleColor = AppColors.textPrimary.resolve(mode);
    final previewColor = AppColors.textSecondary.resolve(mode);
    final dateColor = AppColors.textTertiary.resolve(mode);
    final borderColor = AppColors.borderSubtle.resolve(mode);

    final displayTitle = title.trim().isEmpty ? '' : title;

    return Semantics(
      button: true,
      label: '$displayTitle, $dateLabel',
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppElevation.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.body.size,
                        fontWeight: FontWeight.w600,
                        height: AppTypography.body.height,
                        color: titleColor,
                      ),
                    ),
                    if (previewText.trim().isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        previewText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppTypography.footnote.size,
                          height: AppTypography.footnote.height,
                          color: previewColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                dateLabel,
                style: TextStyle(
                  fontSize: AppTypography.caption.size,
                  color: dateColor,
                ),
              ),
              if (onMore != null)
                Semantics(
                  button: true,
                  label: moreTooltip,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    iconSize: 20,
                    color: dateColor,
                    tooltip: moreTooltip,
                    onPressed: onMore,
                  ),
                ),
              if (onDelete != null)
                Semantics(
                  button: true,
                  label: deleteTooltip,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    iconSize: 20,
                    color: dateColor,
                    tooltip: deleteTooltip,
                    onPressed: onDelete,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
