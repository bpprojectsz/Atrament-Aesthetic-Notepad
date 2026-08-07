import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' show QuillController, Attribute;

import '../core/utils/constants.dart';

/// Rich text formatting bar: bold, italic, underline, heading, bullet
/// list, checkbox list, quote, code block.
///
/// Built directly on `flutter_quill`'s [Attribute] constants rather than
/// the package's prebuilt toolbar widget — [Attribute] is a stable,
/// version-independent API surface, whereas the prebuilt toolbar widget
/// classes have changed shape across `flutter_quill` releases.
///
/// This widget takes its button labels as already-localized strings
/// ([NoteToolbarLabels]) rather than calling `AppLocalizations.of(context)`
/// itself, so it stays a simple, independently testable leaf widget. The
/// caller (`note_editor_screen.dart`) resolves the labels once via
/// `AppLocalizations` and passes them down.
class NoteToolbarLabels {
  const NoteToolbarLabels({
    required this.bold,
    required this.italic,
    required this.underline,
    required this.heading,
    required this.bulletList,
    required this.checklist,
    required this.quote,
    required this.codeBlock,
  });

  final String bold;
  final String italic;
  final String underline;
  final String heading;
  final String bulletList;
  final String checklist;
  final String quote;
  final String codeBlock;
}

class NoteToolbar extends StatelessWidget {
  const NoteToolbar({
    super.key,
    required this.controller,
    required this.labels,
  });

  final QuillController controller;
  final NoteToolbarLabels labels;

  bool _isActive(Attribute attribute) {
    final current = controller.getSelectionStyle().attributes[attribute.key];
    if (attribute.value == null) {
      return current != null;
    }
    return current?.value == attribute.value;
  }

  void _toggle(Attribute attribute) {
    final isActive = _isActive(attribute);
    controller.formatSelection(
      isActive ? Attribute.clone(attribute, null) : attribute,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final bgColor = AppColors.bgSecondary.resolve(mode);
    final borderColor = AppColors.borderSubtle.resolve(mode);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _ToolbarButton(
              icon: Icons.format_bold,
              label: labels.bold,
              onPressed: () => _toggle(Attribute.bold),
            ),
            _ToolbarButton(
              icon: Icons.format_italic,
              label: labels.italic,
              onPressed: () => _toggle(Attribute.italic),
            ),
            _ToolbarButton(
              icon: Icons.format_underline,
              label: labels.underline,
              onPressed: () => _toggle(Attribute.underline),
            ),
            _ToolbarButton(
              icon: Icons.title,
              label: labels.heading,
              onPressed: () => _toggle(Attribute.h2),
            ),
            _ToolbarButton(
              icon: Icons.format_list_bulleted,
              label: labels.bulletList,
              onPressed: () => _toggle(Attribute.ul),
            ),
            _ToolbarButton(
              icon: Icons.checklist,
              label: labels.checklist,
              onPressed: () => _toggle(Attribute.unchecked),
            ),
            _ToolbarButton(
              icon: Icons.format_quote,
              label: labels.quote,
              onPressed: () => _toggle(Attribute.blockQuote),
            ),
            _ToolbarButton(
              icon: Icons.code,
              label: labels.codeBlock,
              onPressed: () => _toggle(Attribute.codeBlock),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return SizedBox(
      width: AppElevation.minTouchTarget,
      height: AppElevation.minTouchTarget,
      child: Semantics(
        button: true,
        label: label,
        child: IconButton(
          icon: Icon(icon, color: AppColors.accent.resolve(mode)),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
