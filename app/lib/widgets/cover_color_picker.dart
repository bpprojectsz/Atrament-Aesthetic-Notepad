import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/utils/constants.dart';
import '../core/utils/notebook_cover_palette.dart';

/// Shows a bottom sheet with a 4×4 grid of the sixteen palette colors.
///
/// Tapping a swatch immediately invokes [onChanged] and the sheet stays
/// open so the user can keep trying colors. Dismiss by swipe-down or
/// tapping outside. There is no Save button and no in-sheet mock preview:
/// the notebook card on the home grid underneath is the preview, updated
/// live through the callback on every tap.
Future<void> showCoverColorPicker(
  BuildContext context, {
  required int currentColor,
  required ValueChanged<int> onChanged,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final mode = Theme.of(context).brightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) => _PickerBody(
      l10n: l10n,
      mode: mode,
      currentColor: currentColor,
      onChanged: onChanged,
    ),
  );
}

class _PickerBody extends StatefulWidget {
  const _PickerBody({
    required this.l10n,
    required this.mode,
    required this.currentColor,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final AppThemeMode mode;
  final int currentColor;
  final ValueChanged<int> onChanged;

  @override
  State<_PickerBody> createState() => _PickerBodyState();
}

class _PickerBodyState extends State<_PickerBody> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentColor;
  }

  void _handleTap(int color) {
    if (color == _selected) return;
    setState(() => _selected = color);
    widget.onChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent.resolve(widget.mode);

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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 56,
              ),
              itemCount: NotebookCoverPalette.all.length,
              itemBuilder: (context, index) {
                final color = NotebookCoverPalette.all[index];
                final selected = color == _selected;
                return Semantics(
                  button: true,
                  label: NotebookCoverPalette.nameOf(color),
                  selected: selected,
                  child: GestureDetector(
                    onTap: () => _handleTap(color),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: _Swatch(
                          color: color,
                          selected: selected,
                          accent: accent,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
  });

  final int color;
  final bool selected;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}
