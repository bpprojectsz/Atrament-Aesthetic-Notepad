import 'package:flutter/material.dart';

import '../core/models/paper_style_model.dart';
import '../core/utils/constants.dart';

/// Bottom sheet grid for choosing a paper texture. Labels are passed in
/// already-localized, keyed by [PaperStyleModel.id].
class PaperSelector extends StatelessWidget {
  const PaperSelector({
    super.key,
    required this.selectedId,
    required this.sectionTitle,
    required this.styleLabels,
    required this.onSelected,
  });

  final String selectedId;
  final String sectionTitle;
  final Map<String, String> styleLabels;
  final ValueChanged<String> onSelected;

  /// Presents this selector as a modal bottom sheet with the standard
  /// top-only rounded corners (Section 17 shape tokens).
  static Future<void> show(
    BuildContext context, {
    required String selectedId,
    required String sectionTitle,
    required Map<String, String> styleLabels,
    required ValueChanged<String> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.bottomSheetTop),
        ),
      ),
      builder: (context) => PaperSelector(
        selectedId: selectedId,
        sectionTitle: sectionTitle,
        styleLabels: styleLabels,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: AppTypography.title1.size,
                fontWeight: AppTypography.title1.weight,
                color: AppColors.textPrimary.resolve(mode),
              ),
            ),
            SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              children: [
                for (final style in PaperStyleCatalog.all)
                  _PaperTile(
                    style: style,
                    label: styleLabels[style.id] ?? style.name,
                    isSelected: style.id == selectedId,
                    onTap: () {
                      onSelected(style.id);
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaperTile extends StatelessWidget {
  const _PaperTile({
    required this.style,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final PaperStyleModel style;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final accent = AppColors.accent.resolve(mode);
    final borderColor = AppColors.borderSubtle.resolve(mode);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: isSelected ? accent : borderColor,
              width: isSelected ? 2 : AppElevation.cardBorderWidth,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.card - 2),
                  ),
                  child: Image.asset(
                    style.assetPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return ColoredBox(
                        color: style.isDark ? Colors.black12 : Colors.white,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppTypography.caption.size,
                    color: AppColors.textSecondary.resolve(mode),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
