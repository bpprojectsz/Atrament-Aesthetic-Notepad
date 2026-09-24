import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/utils/constants.dart';
import '../core/utils/notebook_cover_palette.dart';

/// Shows a bottom sheet of the eight palette colors and returns the
/// selected ARGB int, or null if the user dismissed. The currently
/// selected color (if [currentColor] is in the palette) is drawn with
/// a visible check mark so the user sees which one is active.
Future<int?> showCoverColorPicker(
  BuildContext context, {
  required int currentColor,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final mode = Theme.of(context).brightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;

  return showModalBottomSheet<int>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.notebookCoverPickerTitle,
                style: TextStyle(
                  fontSize: AppTypography.title2.size,
                  fontWeight: AppTypography.title2.weight,
                  color: AppColors.textPrimary.resolve(mode),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  for (final color in NotebookCoverPalette.all)
                    _Swatch(
                      color: color,
                      selected: color == currentColor,
                      onTap: () => Navigator.pop(context, color),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      );
    },
  );
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final int color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: NotebookCoverPalette.nameOf(color),
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Color(color),
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? Colors.white : Colors.transparent,
              width: 3,
            ),
          ),
          child: selected
              ? const Icon(Icons.check, color: Colors.white, size: 28)
              : null,
        ),
      ),
    );
  }
}
