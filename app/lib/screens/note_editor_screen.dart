import 'dart:async';
import 'dart:convert';

import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/note_model.dart';
import '../core/models/paper_style_model.dart';
import '../core/providers/note_provider.dart';
import '../core/providers/verse_provider.dart';
import '../core/services/engagement_service.dart';
import '../core/services/export_service.dart';
import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';
import '../core/utils/export_helper.dart';
import '../platform/biometric_service.dart';
import '../platform/interstitial_service.dart';
import '../platform/share_service.dart';
import '../widgets/font_selector.dart';
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

class _NoteEditorScreenState extends State<NoteEditorScreen>
    with WidgetsBindingObserver {
  /// Disables the built-in HTML-to-Delta paste path used for rich text
  /// pasted from external sources. That parser is fragile against large
  /// or structurally unusual HTML and either hangs the UI thread or
  /// throws. All three controller creation sites share this config so
  /// no paste path can accidentally re-enable the built-in parser.
  // ignore: experimental_member_use
  static const _quillConfig = quill.QuillControllerConfig(
    // ignore: experimental_member_use
    clipboardConfig: quill.QuillClipboardConfig(
      // ignore: experimental_member_use
      enableExternalRichPaste: false,
    ),
  );

  late TextEditingController _titleController;
  late quill.QuillController _quillController;
  late HandwritingCanvasController _handwritingController;
  late bool _isHandwritingMode;
  late String _paperStyleId;
  NoteFontChoice _fontChoice = NoteFontChoice.system;

  final ExportService _exportService = const ExportService();
  final ShareService _shareService = const ShareService();
  final BiometricService _biometricService = BiometricService();

  bool _locked = false;
  bool _checkingLock = true;

  /// The save currently running, if any. Saves are serialized through this
  /// so an overlapping save (e.g. app backgrounding while the user taps
  /// back) always writes a fresh snapshot instead of being skipped.
  Future<bool>? _inFlightSave;

  /// Fingerprint (title + content + paper) of what is on disk. Null for a
  /// new note that has never been written. Used so autosave never rewrites
  /// an unchanged note, and so unreadable stored content is never replaced
  /// by a blank page.
  String? _lastSavedSignature;

  /// True when the stored content could not be parsed on open. While the
  /// user has not edited, saving is skipped so the original data on disk is
  /// kept instead of being overwritten with an empty note.
  bool _contentUnreadable = false;

  Timer? _autosaveTimer;
  static const Duration _autosaveDelay = Duration(seconds: 2);

  /// Back presses that ended in a failed save; the second one lets the
  /// user leave anyway so they are never trapped on this screen.
  int _failedExitAttempts = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _titleController = TextEditingController(text: widget.note.title);
    _paperStyleId = widget.note.paperStyle;
    _isHandwritingMode = _isHandwritingContent(widget.note.content);
    _loadFontChoice();

    if (_isHandwritingMode) {
      _handwritingController = _buildHandwritingController(widget.note.content);
      _quillController = quill.QuillController.basic(
        config: _quillConfig,
      );
    } else {
      _handwritingController = HandwritingCanvasController();
      _quillController = _buildQuillController(widget.note.content);
    }

    // Existing notes start with their on-disk state as the baseline; a new
    // note has none until its first successful save.
    if (!widget.isNewNote) {
      _lastSavedSignature = _signature();
    }

    _titleController.addListener(_scheduleAutosave);
    _quillController.addListener(_scheduleAutosave);
    _handwritingController.addListener(_scheduleAutosave);

    _checkBiometricLock();
  }

  /// A corrupted stroke payload must not crash the editor on open. The
  /// original content stays on disk untouched until the user edits.
  HandwritingCanvasController _buildHandwritingController(String content) {
    try {
      return HandwritingCanvasController.fromJsonString(
        _unwrapHandwritingStrokes(content),
      );
    } catch (error, stackTrace) {
      _contentUnreadable = true;
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to parse handwriting content, starting blank',
        context: 'note_editor_screen.buildHandwritingController',
        severity: ErrorSeverity.warning,
      );
      return HandwritingCanvasController();
    }
  }

  quill.QuillController _buildQuillController(String content) {
    if (content.trim().isEmpty) {
      return quill.QuillController.basic(config: _quillConfig);
    }
    try {
      final delta = jsonDecode(content) as List<dynamic>;
      return quill.QuillController(
        document: quill.Document.fromJson(delta),
        selection: const TextSelection.collapsed(offset: 0),
        config: _quillConfig,
      );
    } catch (error, stackTrace) {
      _contentUnreadable = true;
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to parse note content, starting blank',
        context: 'note_editor_screen.buildQuillController',
        severity: ErrorSeverity.warning,
      );
      return quill.QuillController.basic(
        config: _quillConfig,
      );
    }
  }

  Future<void> _loadFontChoice() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(AppConstants.prefFontChoice);
      final choice = noteFontChoiceFromString(stored);
      if (mounted) setState(() => _fontChoice = choice);
    } catch (_) {
      // Silently keep the system default on any prefs failure.
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

  /// Whether the note is persisted as handwriting. Only one kind of content
  /// is stored per note, so the visible mode normally wins; but if the
  /// visible mode is empty while the other holds content (e.g. the user
  /// tapped the toggle by accident), the content that exists is kept
  /// rather than being replaced by an empty page.
  bool get _persistAsHandwriting {
    final inkHasContent = _handwritingController.strokes.isNotEmpty;
    final textHasContent =
        _quillController.document.toPlainText().trim().isNotEmpty;
    if (_isHandwritingMode) return inkHasContent || !textHasContent;
    return !textHasContent && inkHasContent;
  }

  String _currentContentJson() {
    if (_persistAsHandwriting) {
      return _wrapHandwritingContent(_handwritingController.toJsonString());
    }
    return jsonEncode(_quillController.document.toDelta().toJson());
  }

  String _signature() =>
      '${_titleController.text.trim()}\u0000${_currentContentJson()}\u0000$_paperStyleId';

  /// True when this is a never-before-saved note that the user hasn't
  /// actually put anything into — no title, no text, no strokes. Used to
  /// avoid silently persisting an empty "Untitled" note every time
  /// someone taps + and backs out without writing anything.
  bool get _isUntouchedNewNote {
    if (!widget.isNewNote) return false;
    // Already written once (e.g. by autosave): from here on every state,
    // including an emptied note, must be saved.
    if (_lastSavedSignature != null) return false;
    if (_titleController.text.trim().isNotEmpty) return false;
    if (_isHandwritingMode) {
      return _handwritingController.strokes.isEmpty;
    }
    return _quillController.document.toPlainText().trim().isEmpty;
  }

  void _scheduleAutosave() {
    if (_locked || _checkingLock) return;
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(_autosaveDelay, () {
      if (!mounted) return;
      unawaited(_save(userInitiated: false, skipIfUnchanged: true));
    });
  }

  /// Saves the note. Concurrent calls queue behind the running save and
  /// then write a fresh snapshot. Returns true when the note is safely on
  /// disk (or there was nothing to write).
  ///
  /// Exit and background saves always write (so opening a note refreshes its
  /// modified time, as before). [skipIfUnchanged] is used by autosave so
  /// merely moving the cursor never rewrites the note.
  Future<bool> _save({
    bool userInitiated = true,
    bool skipIfUnchanged = false,
  }) async {
    while (_inFlightSave != null) {
      try {
        await _inFlightSave;
      } catch (_) {
        // The failed save already reported itself; fall through and retry.
      }
    }
    if (_isUntouchedNewNote) return true;
    final signature = _signature();
    final unchanged = signature == _lastSavedSignature;
    if (unchanged && (skipIfUnchanged || _contentUnreadable)) return true;

    final future = _persist(signature, userInitiated: userInitiated);
    _inFlightSave = future;
    try {
      return await future;
    } finally {
      if (identical(_inFlightSave, future)) _inFlightSave = null;
    }
  }

  Future<bool> _persist(String signature, {required bool userInitiated}) async {
    final asHandwriting = _persistAsHandwriting;
    final updated = widget.note.copyWith(
      title: _titleController.text.trim(),
      content: _currentContentJson(),
      paperStyle: _paperStyleId,
      modifiedAt: DateTime.now(),
    );
    final plainText =
        asHandwriting ? '' : _quillController.document.toPlainText();

    final succeeded = await widget.noteProvider.saveNote(
      updated,
      plainTextContent: plainText,
      countsAsUserSave: userInitiated,
    );

    if (succeeded) {
      _lastSavedSignature = signature;
      _contentUnreadable = false;
      if (userInitiated) {
        unawaited(EngagementService.instance.recordNoteSave());
      }
    }
    return succeeded;
  }

  Future<void> _handlePop() async {
    _autosaveTimer?.cancel();
    final saved = await _save();
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final failureText = AppLocalizations.of(context)!.saveFailedMessage;
    if (!saved && _failedExitAttempts == 0) {
      // First failure: stay, so the user can retry instead of silently
      // losing the note. A second back press leaves regardless.
      _failedExitAttempts = 1;
      messenger.showSnackBar(SnackBar(content: Text(failureText)));
      return;
    }
    Navigator.of(context).pop();
    if (!saved) {
      messenger.showSnackBar(SnackBar(content: Text(failureText)));
    }
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
    unawaited(InterstitialService.instance.showAfterExport());
    unawaited(EngagementService.instance.recordExport());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _autosaveTimer?.cancel();
      // Fire-and-forget: save when the app backgrounds so typed content
      // is not lost if the OS kills the process. Silently no-op when the
      // note is untouched (the _isUntouchedNewNote guard in _save handles
      // that case).
      unawaited(_save());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autosaveTimer?.cancel();
    _titleController.removeListener(_scheduleAutosave);
    _quillController.removeListener(_scheduleAutosave);
    _handwritingController.removeListener(_scheduleAutosave);
    _titleController.dispose();
    _quillController.dispose();
    _handwritingController.dispose();
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
              fontFamily: noteFontFamilyStyle(_fontChoice)?.fontFamily,
              fontSize: AppTypography.title1.size,
              fontWeight: AppTypography.title1.weight,
              color: Color(paperStyle.textColor),
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
                      ? HandwritingCanvas(
                          controller: _handwritingController,
                        )
                      : DefaultTextStyle.merge(
                          style: TextStyle(
                            fontFamily:
                                noteFontFamilyStyle(_fontChoice)?.fontFamily,
                            color: Color(paperStyle.textColor),
                            fontSize: AppTypography.body.size,
                            height: AppTypography.body.height,
                          ),
                          child: quill.QuillEditor.basic(
                            controller: _quillController,
                            config: const quill.QuillEditorConfig(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                            ),
                          ),
                        ),
                ),
                SafeArea(
                  top: false,
                  child: _isHandwritingMode
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
