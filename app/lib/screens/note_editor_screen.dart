import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/note_model.dart';
import '../core/models/paper_style_model.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/verse_provider.dart';
import '../core/services/export_service.dart';
import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';
import '../core/utils/export_helper.dart';
import '../platform/biometric_service.dart';
import '../platform/share_service.dart';
import '../widgets/handwriting_canvas.dart';
import '../widgets/note_toolbar.dart';
import '../widgets/paper_background.dart';
import '../widgets/paper_selector.dart';
import '../widgets/pen_toolbar.dart';
import '../widgets/scripture_footer.dart';
import '../widgets/scripture_header.dart';
import '../widgets/scripture_watermark.dart';

/// Detects whether a note's stored `content` is a handwriting stroke
/// payload or a Quill Delta, without needing a dedicated schema field.
/// Handwriting content is wrapped as `{"type":"handwriting","strokes":[...]}`;
/// Quill Delta content is always a raw JSON array, so the two are
/// unambiguous to distinguish by top-level JSON shape.
bool _isHandwritingContent(String raw) {
  if (raw.trim().isEmpty) return false;
  try {
    final decoded = jsonDecode(raw);
    return decoded is Map && decoded['type'] == 'handwriting';
  } catch (_) {
    return false;
  }
}

String _wrapHandwritingContent(String strokesJson) {
  return jsonEncode({'type': 'handwriting', 'strokes': jsonDecode(strokesJson)});
}

String _unwrapHandwritingStrokes(String raw) {
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  return jsonEncode(decoded['strokes']);
}

enum ExportFormat { txt, pdf }

/// Primary writing canvas. Supports rich text (via `flutter_quill`) and
/// freehand handwriting as two switchable modes on the same note, a paper
/// background, the user's chosen scripture display mode, formatting
/// toolbars, export/share actions, and an optional biometric lock gate.
class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({
    super.key,
    required this.note,
    required this.noteProvider,
    this.verseProvider,
    this.isNewNote = false,
  });

  final NoteModel note;
  final NoteProvider noteProvider;

  /// Optional override, used by tests to inject a specific instance
  /// without needing a full Provider tree. In real app usage this is
  /// never passed — the screens between the home screen and here
  /// (NotebookDetailScreen, etc.) never had a verseProvider parameter to
  /// thread it through, which meant this was always null in production
  /// and the scripture overlay never rendered at all. Resolving it from
  /// the ambient Provider tree instead (see `_buildVerseOverlay`) removes
  /// the need for every screen in the chain to know about it.
  final VerseProvider? verseProvider;
  final bool isNewNote;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late quill.QuillController _quillController;
  late HandwritingCanvasController _handwritingController;
  late bool _isHandwritingMode;
  late String _paperStyleId;

  final ExportService _exportService = const ExportService();
  final ShareService _shareService = const ShareService();
  final BiometricService _biometricService = BiometricService();

  bool _locked = false;
  bool _checkingLock = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _paperStyleId = widget.note.paperStyle;
    _isHandwritingMode = _isHandwritingContent(widget.note.content);

    if (_isHandwritingMode) {
      _handwritingController = HandwritingCanvasController.fromJsonString(
        _unwrapHandwritingStrokes(widget.note.content),
      );
      _quillController = quill.QuillController.basic();
    } else {
      _handwritingController = HandwritingCanvasController();
      _quillController = _buildQuillController(widget.note.content);
    }

    _checkBiometricLock();
  }

  quill.QuillController _buildQuillController(String content) {
    try {
      final delta = jsonDecode(content) as List<dynamic>;
      return quill.QuillController(
        document: quill.Document.fromJson(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to parse note content, starting blank',
        context: 'note_editor_screen.buildQuillController',
        severity: ErrorSeverity.warning,
      );
      return quill.QuillController.basic();
    }
  }

  Future<void> _checkBiometricLock() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled =
          prefs.getBool(AppConstants.prefBiometricLockEnabled) ?? false;
      if (!enabled) {
        if (mounted) setState(() => _checkingLock = false);
        return;
      }
      if (mounted) setState(() => _locked = true);
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      final result = await _biometricService.authenticate(
        reason: l10n.biometricLockReason,
      );
      if (!mounted) return;
      setState(() {
        _locked = result != BiometricAuthResult.success;
        _checkingLock = false;
      });
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Biometric lock check failed',
        context: 'note_editor_screen.checkBiometricLock',
        severity: ErrorSeverity.warning,
      );
      if (mounted) setState(() => _checkingLock = false);
    }
  }

  String _currentContentJson() {
    if (_isHandwritingMode) {
      return _wrapHandwritingContent(_handwritingController.toJsonString());
    }
    return jsonEncode(_quillController.document.toDelta().toJson());
  }

  /// True when this is a never-before-saved note that the user hasn't
  /// actually put anything into — no title, no text, no strokes. Used to
  /// avoid silently persisting an empty "Untitled" note every time
  /// someone taps + and backs out without writing anything.
  bool get _isUntouchedNewNote {
    if (!widget.isNewNote) return false;
    if (_titleController.text.trim().isNotEmpty) return false;
    if (_isHandwritingMode) {
      return _handwritingController.strokes.isEmpty;
    }
    return _quillController.document.toPlainText().trim().isEmpty;
  }

  Future<bool> _save() async {
    if (_isSaving) return true;
    if (_isUntouchedNewNote) return true;
    _isSaving = true;

    final updated = widget.note.copyWith(
      title: _titleController.text.trim(),
      content: _currentContentJson(),
      paperStyle: _paperStyleId,
      modifiedAt: DateTime.now(),
    );

    final plainText = _isHandwritingMode
        ? ''
        : _quillController.document.toPlainText();

    final succeeded = await widget.noteProvider.saveNote(
      updated,
      plainTextContent: plainText,
    );

    _isSaving = false;
    return succeeded;
  }

  Future<void> _handlePop() async {
    await _save();
    if (mounted) Navigator.of(context).pop();
  }

  ExportableNote _buildExportableNote(AppLocalizations l10n) {
    return ExportableNote(
      title: _titleController.text.trim().isEmpty
          ? l10n.untitledNote
          : _titleController.text.trim(),
      plainTextContent: _isHandwritingMode
          ? ''
          : _quillController.document.toPlainText(),
      createdAtLabel: widget.note.createdAt.toIso8601String(),
      verseReferenceLabel: widget.note.verseReference,
    );
  }

  Future<void> _exportAs(ExportFormat format) async {
    final l10n = AppLocalizations.of(context)!;
    final exportable = _buildExportableNote(l10n);

    final result = format == ExportFormat.txt
        ? await _exportService.exportAsTxt(exportable)
        : await _exportService.exportAsPdf(exportable);

    if (!mounted) return;

    if (!result.succeeded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.errorMessage ?? l10n.exportFailedMessage)),
      );
      return;
    }

    final shareResult = await _shareService.shareFile(
      result.filePath!,
      subject: exportable.title,
    );
    if (!mounted) return;
    if (shareResult.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.shareFailedMessage)),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_checkingLock) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_locked) {
      return _buildLockScreen(context, l10n);
    }

    final paperStyle = PaperStyleCatalog.byId(_paperStyleId);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        await _handlePop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _titleController,
            style: TextStyle(
              fontSize: AppTypography.title1.size,
              fontWeight: AppTypography.title1.weight,
            ),
            decoration: InputDecoration(
              hintText: l10n.untitledNote,
              border: InputBorder.none,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isHandwritingMode ? Icons.edit_note : Icons.draw),
              tooltip: l10n.toggleHandwritingMode,
              onPressed: () {
                setState(() => _isHandwritingMode = !_isHandwritingMode);
              },
            ),
            IconButton(
              icon: const Icon(Icons.style_outlined),
              tooltip: l10n.paperStyleSectionTitle,
              onPressed: () => PaperSelector.show(
                context,
                selectedId: _paperStyleId,
                sectionTitle: l10n.paperStyleSectionTitle,
                styleLabels: {
                  'lined': l10n.paperStyleLined,
                  'dot_grid': l10n.paperStyleDotGrid,
                  'grid': l10n.paperStyleGrid,
                  'blank': l10n.paperStyleBlank,
                  'cream': l10n.paperStyleCream,
                  'parchment': l10n.paperStyleParchment,
                  'vellum': l10n.paperStyleVellum,
                },
                onSelected: (id) => setState(() => _paperStyleId = id),
              ),
            ),
            PopupMenuButton<ExportFormat>(
              icon: const Icon(Icons.ios_share),
              tooltip: l10n.exportTitle,
              onSelected: _exportAs,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: ExportFormat.txt,
                  child: Text(l10n.exportAsTxt),
                ),
                PopupMenuItem(
                  value: ExportFormat.pdf,
                  child: Text(l10n.exportAsPdf),
                ),
              ],
            ),
          ],
        ),
        body: Stack(
          children: [
            PaperBackground(style: paperStyle),
            _buildVerseOverlay(context),
            Column(
              children: [
                Expanded(
                  child: _isHandwritingMode
                      ? HandwritingCanvas(controller: _handwritingController)
                      : quill.QuillEditor.basic(
                          controller: _quillController,
                          config: const quill.QuillEditorConfig(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.md,
                            ),
                          ),
                        ),
                ),
                _isHandwritingMode
                    ? PenToolbar(
                        controller: _handwritingController,
                        labels: PenToolbarLabels(
                          penNames: {
                            'fountain_pen': l10n.penFountainPen,
                            'gel_pen': l10n.penGelPen,
                            'pencil': l10n.penPencil,
                            'highlighter_yellow': l10n.penHighlighter,
                          },
                          eraser: l10n.penEraser,
                          strokeWidth: l10n.penStrokeWidth,
                          undo: l10n.undo,
                          redo: l10n.redo,
                        ),
                        onStrokeWidthChanged: (width) =>
                            _handwritingController.setActivePenStrokeWidth(
                              width,
                            ),
                      )
                    : NoteToolbar(
                        controller: _quillController,
                        labels: NoteToolbarLabels(
                          bold: l10n.formatBold,
                          italic: l10n.formatItalic,
                          underline: l10n.formatUnderline,
                          heading: l10n.formatHeading,
                          bulletList: l10n.formatBulletList,
                          checklist: l10n.formatChecklist,
                          quote: l10n.formatQuote,
                          codeBlock: l10n.formatCodeBlock,
                          undo: l10n.undo,
                          redo: l10n.redo,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerseOverlay(BuildContext context) {
    // Falls back to the ambient Provider tree when no explicit override
    // was passed — see the doc comment on widget.verseProvider for why
    // this fallback is the actual production path, not an edge case.
    final verseProvider = widget.verseProvider ?? context.read<VerseProvider>();

    return ListenableBuilder(
      listenable: Listenable.merge([
        verseProvider.displayMode,
        verseProvider.todaysVerse,
        verseProvider.scriptureFontScale,
      ]),
      builder: (context, _) {
        final verse = verseProvider.todaysVerse.value;
        if (verse == null) return const SizedBox.shrink();
        final scale = verseProvider.scriptureFontScale.value;

        switch (verseProvider.displayMode.value) {
          case VerseDisplayMode.watermark:
            return ScriptureWatermark(verse: verse, fontScale: scale);
          case VerseDisplayMode.header:
            return Align(
              alignment: Alignment.topCenter,
              child: ScriptureHeader(verse: verse, fontScale: scale),
            );
          case VerseDisplayMode.footer:
            return Align(
              alignment: Alignment.bottomCenter,
              child: ScriptureFooter(verse: verse, fontScale: scale),
            );
          case VerseDisplayMode.off:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLockScreen(BuildContext context, AppLocalizations l10n) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 48,
              color: AppColors.accent.resolve(mode),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.noteLockedMessage),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: _checkBiometricLock,
              child: Text(l10n.unlockButton),
            ),
          ],
        ),
      ),
    );
  }
}
