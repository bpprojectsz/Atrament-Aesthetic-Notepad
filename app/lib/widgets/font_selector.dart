import 'package:flutter/material.dart';

import '../core/utils/constants.dart';

enum NoteFontChoice { system, serif }

/// Segmented toggle between the system font and the bundled Merriweather
/// serif for note body text (a separate setting from the always-serif
/// scripture elements).
class FontSelector extends StatelessWidget {
  const FontSelector({
    super.key,
    required this.value,
    required this.systemLabel,
    required this.serifLabel,
    required this.onChanged,
  });

  final NoteFontChoice value;
  final String systemLabel;
  final String serifLabel;
  final ValueChanged<NoteFontChoice> onChanged;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return SegmentedButton<NoteFontChoice>(
      segments: [
        ButtonSegment(
          value: NoteFontChoice.system,
          label: Text(systemLabel),
        ),
        ButtonSegment(
          value: NoteFontChoice.serif,
          label: Text(serifLabel, style: const TextStyle(fontFamily: 'Merriweather')),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.first),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent.resolve(mode);
          }
          return AppColors.bgTertiary.resolve(mode);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.textPrimary.resolve(mode);
        }),
      ),
    );
  }
}
