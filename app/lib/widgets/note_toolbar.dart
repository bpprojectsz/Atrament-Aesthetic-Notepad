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
    required this.undo,
    required this.redo,
  });

  final String bold;
  final String italic;
  final String underline;
  final String heading;
  final String bulletList;
  final String checklist;
  final String quote;
  final String codeBlock;
  final String undo;
  final String redo;
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

    // Wrapped in ListenableBuilder — previously this whole toolbar was a
    // plain StatelessWidget with nothing listening to `controller`, so
    // neither the format-button "active" highlighting nor (now) the
    // undo/redo enabled state ever actually updated live as the user
    // typed or moved their selection. Every _isActive()/hasUndo/hasRedo
    // read below now happens inside a rebuild triggered by the
    // controller's own change notifications.
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(top: BorderSide(color: borderColor, width: 0.5)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ToolbarButton(
                  icon: Icons.undo,
                  label: labels.undo,
                  onPressed: controller.hasUndo ? controller.undo : null,
                ),
                _ToolbarButton(
                  icon: Icons.redo,
                  label: labels.redo,
                  onPressed: controller.hasRedo ? controller.redo : null,
                ),
                _ToolbarButton(
                  icon: Icons.format_bold,
                  label: labels.bold,
                  isActive: _isActive(Attribute.bold),
                  onPressed: () => _toggle(Attribute.bold),
                ),
                _ToolbarButton(
                  icon: Icons.format_italic,
                  label: labels.italic,
                  isActive: _isActive(Attribute.italic),
                  onPressed: () => _toggle(Attribute.italic),
                ),
                _ToolbarButton(
                  icon: Icons.format_underline,
                  label: labels.underline,
                  isActive: _isActive(Attribute.underline),
                  onPressed: () => _toggle(Attribute.underline),
                ),
                _ToolbarButton(
                  icon: Icons.title,
                  label: labels.heading,
                  isActive: _isActive(Attribute.h2),
                  onPressed: () => _toggle(Attribute.h2),
                ),
                _ToolbarButton(
                  icon: Icons.format_list_bulleted,
                  label: labels.bulletList,
                  isActive: _isActive(Attribute.ul),
                  onPressed: () => _toggle(Attribute.ul),
                ),
                _ToolbarButton(
                  icon: Icons.checklist,
                  label: labels.checklist,
                  isActive: _isActive(Attribute.unchecked),
                  onPressed: () => _toggle(Attribute.unchecked),
                ),
                _ToolbarButton(
                  icon: Icons.format_quote,
                  label: labels.quote,
                  isActive: _isActive(Attribute.blockQuote),
                  onPressed: () => _toggle(Attribute.blockQuote),
                ),
                _ToolbarButton(
                  icon: Icons.code,
                  label: labels.codeBlock,
                  isActive: _isActive(Attribute.codeBlock),
                  onPressed: () => _toggle(Attribute.codeBlock),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final accent = AppColors.accent.resolve(mode);

    return SizedBox(
      width: AppElevation.minTouchTarget,
      height: AppElevation.minTouchTarget,
      child: Semantics(
        button: true,
        selected: isActive,
        label: label,
        child: IconButton(
          icon: Icon(icon),
          style: IconButton.styleFrom(
            foregroundColor: isActive ? accent : accent.withOpacity(0.7),
            disabledForegroundColor: accent.withOpacity(0.35),
            backgroundColor: isActive ? accent.withOpacity(0.15) : null,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
