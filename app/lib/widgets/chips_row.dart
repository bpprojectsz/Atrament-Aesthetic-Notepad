import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/constants.dart';

/// Which chip is selected on the home screen. Determines which body
/// builder is shown when the search field is empty.
enum HomeChip { all, notebooks, recent }

/// iOS-style segmented control for the home screen. One rounded container
/// with three equal-width segments and a sliding selection indicator.
class ChipsRow extends StatelessWidget {
  const ChipsRow({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.allLabel,
    required this.notebooksLabel,
    required this.recentLabel,
  });

  final HomeChip selected;
  final ValueChanged<HomeChip> onSelected;
  final String allLabel;
  final String notebooksLabel;
  final String recentLabel;

  static const double _height = 34;
  static const double _outerRadius = 9;
  static const double _innerRadius = 6;
  static const double _innerPadding = 3;
  static const Duration _animDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final containerFill = AppColors.bgTertiary.resolve(mode);
    final segmentFill = AppColors.bgPrimary.resolve(mode);
    final selectedText = AppColors.textPrimary.resolve(mode);
    final unselectedText = AppColors.textSecondary.resolve(mode);
    final shadow = mode == AppThemeMode.dark
        ? null
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ];

    return SizedBox(
      height: _height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final innerWidth = constraints.maxWidth - 2 * _innerPadding;
          final segmentWidth = innerWidth / 3;
          final selectedIndex = HomeChip.values.indexOf(selected);

          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: containerFill,
                    borderRadius: BorderRadius.circular(_outerRadius),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _animDuration,
                curve: Curves.easeOut,
                left: _innerPadding + selectedIndex * segmentWidth,
                top: _innerPadding,
                bottom: _innerPadding,
                width: segmentWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: segmentFill,
                    borderRadius: BorderRadius.circular(_innerRadius),
                    boxShadow: shadow,
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(_innerPadding),
                  child: Row(
                    children: [
                      _Segment(
                        label: allLabel,
                        isSelected: selected == HomeChip.all,
                        selectedColor: selectedText,
                        unselectedColor: unselectedText,
                        onTap: () => onSelected(HomeChip.all),
                      ),
                      _Segment(
                        label: notebooksLabel,
                        isSelected: selected == HomeChip.notebooks,
                        selectedColor: selectedText,
                        unselectedColor: unselectedText,
                        onTap: () => onSelected(HomeChip.notebooks),
                      ),
                      _Segment(
                        label: recentLabel,
                        isSelected: selected == HomeChip.recent,
                        selectedColor: selectedText,
                        unselectedColor: unselectedText,
                        onTap: () => onSelected(HomeChip.recent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: ChipsRow._animDuration,
            curve: Curves.easeOut,
            style: TextStyle(
              fontSize: AppTypography.footnote.size,
              fontWeight: FontWeight.w500,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
