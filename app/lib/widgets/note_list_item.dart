import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/constants.dart';

/// Note row used on the home screen and in `notebook_detail_screen.dart`.
/// Layout: title, up to two preview lines, then a small date on its own
/// line. Rows are separated by whitespace only — no dividers. The 3-dot
/// menu is the only trailing control. Delete is reachable through the
/// 3-dot menu and via swipe on notebook detail.
class NoteListItem extends StatelessWidget {
  const NoteListItem({
    super.key,
    required this.title,
    required this.previewText,
    required this.dateLabel,
    required this.onTap,
    this.onLongPress,
    this.onMore,
    this.moreTooltip,
  });

  final String title;
  final String previewText;
  final String dateLabel;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Trailing 3-dot menu. When non-null, renders an icon button aligned to
  /// the top-right of the row, level with the title.
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

    final displayTitle = title.trim().isEmpty ? '' : title;

    return Semantics(
      button: true,
      label: '$displayTitle, $dateLabel',
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        color: titleColor,
                      ),
                    ),
                    if (previewText.trim().isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        previewText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: previewColor,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      dateLabel,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.2,
                        color: dateColor,
                      ),
                    ),
                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
