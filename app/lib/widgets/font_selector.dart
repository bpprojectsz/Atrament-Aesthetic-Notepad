import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/constants.dart';

enum NoteFontChoice { system, serif, inter, lora }

/// Maps a persisted font-choice string (as written to and read from
/// SharedPreferences) to a [NoteFontChoice]. Unknown values fall back to
/// [NoteFontChoice.system], so legacy prefs written before this enum was
/// extended continue to load.
NoteFontChoice noteFontChoiceFromString(String? stored) {
  if (stored == null) return NoteFontChoice.system;
  return NoteFontChoice.values.firstWhere(
    (c) => c.name == stored,
    orElse: () => NoteFontChoice.system,
  );
}

/// A [TextStyle] carrying only the family for [choice], or null for the
/// system default. Callers merge this into their own TextStyle. Merriweather
/// is bundled; Inter and Lora are loaded lazily by `google_fonts` on first
/// use and cached in app storage afterward.
TextStyle? noteFontFamilyStyle(NoteFontChoice choice) {
  switch (choice) {
    case NoteFontChoice.system:
      return null;
    case NoteFontChoice.serif:
      return const TextStyle(fontFamily: 'Merriweather');
    case NoteFontChoice.inter:
      return GoogleFonts.inter();
    case NoteFontChoice.lora:
      return GoogleFonts.lora();
  }
}

/// Segmented toggle between the system font and the bundled Merriweather
/// serif for note body text (a separate setting from the always-serif
/// scripture elements).
class FontSelector extends StatelessWidget {
  const FontSelector({
    super.key,
    required this.value,
    required this.systemLabel,
    required this.serifLabel,
    required this.interLabel,
    required this.loraLabel,
    required this.onChanged,
  });

  final NoteFontChoice value;
  final String systemLabel;
  final String serifLabel;
  final String interLabel;
  final String loraLabel;
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
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(systemLabel, maxLines: 1, softWrap: false),
          ),
        ),
        ButtonSegment(
          value: NoteFontChoice.serif,
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              serifLabel,
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(fontFamily: 'Merriweather'),
            ),
          ),
        ),
        ButtonSegment(
          value: NoteFontChoice.inter,
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              interLabel,
              maxLines: 1,
              softWrap: false,
              style: GoogleFonts.inter(),
            ),
          ),
        ),
        ButtonSegment(
          value: NoteFontChoice.lora,
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              loraLabel,
              maxLines: 1,
              softWrap: false,
              style: GoogleFonts.lora(),
            ),
          ),
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
