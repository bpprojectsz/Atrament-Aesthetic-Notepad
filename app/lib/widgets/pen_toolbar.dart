import 'package:flutter/material.dart';

import '../core/models/pen_style_model.dart';
import '../core/utils/constants.dart';
import 'handwriting_canvas.dart';

/// Tool selector for the handwriting canvas: pen/pencil/highlighter,
/// eraser, and a stroke-width slider for the active pen. Labels are
/// passed in already-localized, matching the pattern used by
/// `note_toolbar.dart`.
class PenToolbarLabels {
  const PenToolbarLabels({
    required this.penNames,
    required this.eraser,
    required this.strokeWidth,
    required this.undo,
    required this.redo,
  });

  /// Display name per pen id, e.g. {'fountain_pen': 'Fountain Pen'}.
  final Map<String, String> penNames;
  final String eraser;
  final String strokeWidth;
  final String undo;
  final String redo;
}

class PenToolbar extends StatelessWidget {
  const PenToolbar({
    super.key,
    required this.controller,
    required this.labels,
    required this.onStrokeWidthChanged,
  });

  final HandwritingCanvasController controller;
  final PenToolbarLabels labels;

  /// Called when the user adjusts stroke width for the active pen. This
  /// widget doesn't own pen catalog mutation — the screen decides how a
  /// custom stroke width is stored (e.g. as a per-note override).
  final ValueChanged<double> onStrokeWidthChanged;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final bgColor = AppColors.bgSecondary.resolve(mode);
    final borderColor = AppColors.borderSubtle.resolve(mode);
    final accent = AppColors.accent.resolve(mode);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(top: BorderSide(color: borderColor, width: 0.5)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  for (final pen in PenStyleCatalog.all)
                    _PenButton(
                      pen: pen,
                      label: labels.penNames[pen.id] ?? pen.name,
                      isSelected:
                          !controller.isErasing &&
                          controller.activePen.id == pen.id,
                      onTap: () => controller.setActivePen(pen),
                    ),
                  _EraserButton(
                    label: labels.eraser,
                    isSelected: controller.isErasing,
                    onTap: () => controller.setErasing(!controller.isErasing),
                    accentColor: accent,
                  ),
                  const Spacer(),
                  Semantics(
                    button: true,
                    label: labels.undo,
                    child: IconButton(
                      icon: const Icon(Icons.undo),
                      color: accent,
                      onPressed: controller.canUndo ? controller.undo : null,
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: labels.redo,
                    child: IconButton(
                      icon: const Icon(Icons.redo),
                      color: accent,
                      onPressed: controller.canRedo ? controller.redo : null,
                    ),
                  ),
                ],
              ),
              if (!controller.isErasing)
                Row(
                  children: [
                    Text(
                      labels.strokeWidth,
                      style: TextStyle(
                        fontSize: AppTypography.footnote.size,
                        color: AppColors.textSecondary.resolve(mode),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: controller.activePen.strokeWidth
                            .clamp(1, 24)
                            .toDouble(),
                        min: 1,
                        max: 24,
                        activeColor: accent,
                        onChanged: onStrokeWidthChanged,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _PenButton extends StatelessWidget {
  const _PenButton({
    required this.pen,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final PenStyleModel pen;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Container(
          width: AppElevation.minTouchTarget,
          height: AppElevation.minTouchTarget,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Color(pen.color) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(pen.color),
            ),
          ),
        ),
      ),
    );
  }
}

class _EraserButton extends StatelessWidget {
  const _EraserButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.accentColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Container(
          width: AppElevation.minTouchTarget,
          height: AppElevation.minTouchTarget,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? accentColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.auto_fix_off,
            color: isSelected ? accentColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
