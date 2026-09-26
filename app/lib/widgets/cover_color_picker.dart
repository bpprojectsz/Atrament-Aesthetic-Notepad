import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/utils/constants.dart';
import '../core/utils/notebook_cover_palette.dart';

/// Shows a bottom sheet with a live preview of the notebook card tinted
/// by the currently-tapped swatch, a 4-column grid of the sixteen palette
/// colors, and no custom-color entry. Returns the selected ARGB int, or
/// null if dismissed.
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
      return _PickerBody(
        l10n: l10n,
        mode: mode,
        initialColor: currentColor,
      );
    },
  );
}

class _PickerBody extends StatefulWidget {
  const _PickerBody({
    required this.l10n,
    required this.mode,
    required this.initialColor,
  });

  final AppLocalizations l10n;
  final AppThemeMode mode;
  final int initialColor;

  @override
  State<_PickerBody> createState() => _PickerBodyState();
}

class _PickerBodyState extends State<_PickerBody> {
  late int _previewColor;

  @override
  void initState() {
    super.initState();
    _previewColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.l10n.notebookCoverPickerTitle,
              style: TextStyle(
                fontSize: AppTypography.title2.size,
                fontWeight: AppTypography.title2.weight,
                color: AppColors.textPrimary.resolve(widget.mode),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: _Preview(
                color: _previewColor,
                mode: widget.mode,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                for (final color in NotebookCoverPalette.all)
                  _Swatch(
                    color: color,
                    selected: color == _previewColor,
                    accent: AppColors.accent.resolve(widget.mode),
                    onTap: () => setState(() => _previewColor = color),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => Navigator.pop(context, _previewColor),
              child: Text(widget.l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small live preview of the notebook card, tinted with the currently
/// selected swatch. Reduced to the essential shape — a rounded rectangle
/// with a horizontal colour band, matching how the tint reads on the real
/// card.
class _Preview extends StatelessWidget {
  const _Preview({required this.color, required this.mode});

  final int color;
  final AppThemeMode mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(color).withValues(alpha: 0.75),
                Color(color).withValues(alpha: 0.35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final int color;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: NotebookCoverPalette.nameOf(color),
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: Color(color),
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? accent : Colors.transparent,
              width: 2,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.25),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: selected
              ? const Icon(Icons.check, color: Colors.white, size: 24)
              : null,
        ),
      ),
    );
  }
}
