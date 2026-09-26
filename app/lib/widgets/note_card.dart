import 'package:flutter/material.dart';

import '../core/models/paper_style_model.dart';
import '../core/utils/constants.dart';

/// Preview card for the notebook grid on the home screen.
///
/// Cover-first design: the paper texture fills the entire card and the
/// user's chosen `coverColor` is applied as a top-to-bottom gradient tint
/// over the texture. Title and date sit inside a translucent white bar
/// anchored to the bottom of the card. The 3-dot menu sits top-right with
/// no scrim — it relies on the card's own contrast rather than a backing
/// circle.
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

  /// Optional ARGB value applied as a gradient tint over the paper texture.
  /// Notebook cards pass the user's chosen cover colour; note cards pass
  /// nothing and render the plain texture.
  final int? coverColor;

  /// Trailing 3-dot menu, top-right of the card.
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final titleColor = AppColors.textPrimary.resolve(mode);
    final dateColor = AppColors.textTertiary.resolve(mode);

    return Semantics(
      button: true,
      label: '$title, $dateLabel',
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: 1.0,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.card),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.black.withValues(alpha: 0.04),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Texture
                    Image.asset(
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

                    // Cover-color tint overlay
                    if (coverColor != null)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(coverColor!).withValues(alpha: 0.55),
                              Color(coverColor!).withValues(alpha: 0.15),
                            ],
                          ),
                        ),
                      ),

                    // 3-dot, top-right, no scrim
                    if (onMore != null)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Material(
                          color: Colors.transparent,
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
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Bottom text bar, translucent white
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                            const SizedBox(height: 2),
                            Text(
                              dateLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppTypography.footnote.size,
                                color: dateColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
