import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Reusable scaffold used by every screen. Wraps [Scaffold] with themed
/// background/app-bar colors resolved from the design tokens, a safe
/// area, and an optional bottom slot for [BannerAdWidget] (passed in by
/// the caller so this widget doesn't need to know about subscription
/// state itself).
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomAdSlot,
    this.leading,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  /// Typically a [BannerAdWidget] — rendered above the safe-area bottom
  /// inset, collapsing to nothing when ads are hidden.
  final Widget? bottomAdSlot;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final bgColor = AppColors.bgPrimary.resolve(mode);
    final titleColor = AppColors.textPrimary.resolve(mode);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: title == null
          ? null
          : AppBar(
              backgroundColor: bgColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: leading,
              title: Text(
                title!,
                style: TextStyle(
                  fontSize: AppTypography.headline.size,
                  fontWeight: AppTypography.headline.weight,
                  color: titleColor,
                ),
              ),
              actions: actions,
            ),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: body),
            if (bottomAdSlot != null) bottomAdSlot!,
          ],
        ),
      ),
    );
  }
}
