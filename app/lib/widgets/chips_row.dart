import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

/// Which chip is selected on the home screen. Determines which body
/// builder is shown when the search field is empty.
enum HomeChip { all, notebooks, recent }

/// Horizontal row of three filter chips shown below the search field on
/// the home screen. Selected chip uses the accent color; unselected chips
/// use the secondary background with a subtle border.
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Chip(
          label: allLabel,
          isSelected: selected == HomeChip.all,
          onTap: () => onSelected(HomeChip.all),
        ),
        const SizedBox(width: AppSpacing.sm),
        _Chip(
          label: notebooksLabel,
          isSelected: selected == HomeChip.notebooks,
          onTap: () => onSelected(HomeChip.notebooks),
        ),
        const SizedBox(width: AppSpacing.sm),
        _Chip(
          label: recentLabel,
          isSelected: selected == HomeChip.recent,
          onTap: () => onSelected(HomeChip.recent),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final bg = isSelected
        ? AppColors.accent.resolve(mode)
        : AppColors.bgSecondary.resolve(mode);
    final fg = isSelected
        ? AppColors.bgPrimary.resolve(mode)
        : AppColors.textPrimary.resolve(mode);
    final border = isSelected
        ? const Color(0x00000000)
        : AppColors.borderSubtle.resolve(mode);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.button),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(color: border, width: 0.5),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppTypography.footnote.size,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
