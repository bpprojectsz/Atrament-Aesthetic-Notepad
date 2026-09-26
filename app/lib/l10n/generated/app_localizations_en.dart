// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get untitledNote => 'Untitled';

  @override
  String get deleteConfirmBody => 'This can\'t be undone.';

  @override
  String get deleteNoteTitle => 'Delete this note?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get saveFailedMessage => 'Couldn\'t save. Please try again.';

  @override
  String get exportFailedMessage =>
      'Couldn\'t export this note. Please try again.';

  @override
  String get shareFailedMessage =>
      'Couldn\'t open the share sheet. Please try again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get searchHint => 'Search notes';

  @override
  String get emptyNotebooksTitle => 'No notebooks yet';

  @override
  String get emptyNotebooksBody =>
      'Create your first notebook to start writing.';

  @override
  String get emptySearchTitle => 'No results';

  @override
  String get emptySearchBody => 'Try a different search term.';

  @override
  String get emptyNotebookTitle => 'No notes yet';

  @override
  String get emptyNotebookBody => 'Tap the + button to write your first note.';

  @override
  String get newNotebookTitle => 'New Notebook';

  @override
  String get notebookNameHint => 'Notebook name';

  @override
  String get newNoteTitle => 'New Note';

  @override
  String get sortOptionsTitle => 'Sort';

  @override
  String get sortByModified => 'Last edited';

  @override
  String get sortByCreated => 'Date created';

  @override
  String get sortByTitle => 'Title';

  @override
  String get formatBold => 'Bold';

  @override
  String get formatItalic => 'Italic';

  @override
  String get formatUnderline => 'Underline';

  @override
  String get formatHeading => 'Heading';

  @override
  String get formatBulletList => 'Bullet list';

  @override
  String get formatChecklist => 'Checklist';

  @override
  String get formatQuote => 'Quote';

  @override
  String get formatCodeBlock => 'Code block';

  @override
  String get penFountainPen => 'Fountain Pen';

  @override
  String get penGelPen => 'Gel Pen';

  @override
  String get penPencil => 'Pencil';

  @override
  String get penHighlighter => 'Highlighter';

  @override
  String get penEraser => 'Eraser';

  @override
  String get penStrokeWidth => 'Stroke width';

  @override
  String get toggleHandwritingMode => 'Switch between typing and drawing';

  @override
  String get biometricLockReason => 'Unlock to view this note';

  @override
  String get noteLockedMessage => 'This note is locked';

  @override
  String get unlockButton => 'Unlock';

  @override
  String get exportTitle => 'Export';

  @override
  String get exportAsTxt => 'Export as Text';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get paperStyleSectionTitle => 'Paper Style';

  @override
  String get paperStyleLined => 'Lined';

  @override
  String get paperStyleDotGrid => 'Dot Grid';

  @override
  String get paperStyleGrid => 'Grid';

  @override
  String get paperStyleBlank => 'Blank';

  @override
  String get paperStyleCream => 'Cream';

  @override
  String get paperStyleParchment => 'Parchment';

  @override
  String get paperStyleVellum => 'Vellum';

  @override
  String get fontSectionTitle => 'Note Font';

  @override
  String get fontSystem => 'System';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeParchment => 'Parchment';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Daily Verse Display';

  @override
  String get verseModeWatermark => 'Watermark';

  @override
  String get verseModeHeader => 'Header';

  @override
  String get verseModeFooter => 'Footer';

  @override
  String get verseModeOff => 'Off';

  @override
  String get notificationsSectionTitle => 'Notifications';

  @override
  String get dailyReminderToggle => 'Daily verse reminder';

  @override
  String get reminderTimeLabel => 'Reminder time';

  @override
  String get notificationPermissionDenied =>
      'Notifications are turned off in system settings.';

  @override
  String get dailyReminderBody => 'Your daily verse is ready.';

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get biometricLockToggle => 'Lock notes with Face ID / fingerprint';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Remove Ads';

  @override
  String get restorePurchasesButton => 'Restore Purchases';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'More';

  @override
  String get rateAppTitle => 'Rate Atrament';

  @override
  String get rateAppSubtitle => 'Enjoying the app? Leave a review';

  @override
  String get shareAppTitle => 'Share Atrament';

  @override
  String get shareAppSubtitle => 'Tell a friend';

  @override
  String get shareAppMessage =>
      'Try Atrament — a distraction-free notepad with paper textures.';

  @override
  String get languageSectionTitle => 'Language';

  @override
  String get languageFollowsSystem => 'Follows your device language setting';

  @override
  String get languageSystem => 'System default';

  @override
  String get languagePickerTitle => 'Choose language';

  @override
  String get premiumScreenTitle => 'Remove Ads';

  @override
  String get premiumHeadline => 'Write without distraction';

  @override
  String get premiumBody =>
      'Atrament is free with one small banner ad. Removing it is a one-time purchase that doesn\'t unlock anything else — every feature is already yours.';

  @override
  String get premiumRestoreButton => 'Restore Purchases';

  @override
  String get premiumAlreadyProMessage =>
      'You already have Remove Ads. Thank you!';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get shareDebugLogButton => 'Share Debug Log';

  @override
  String get shareDebugLogSubtitle =>
      'Send a technical report if something isn\'t working';

  @override
  String get noDebugLogMessage => 'No issues to report yet.';

  @override
  String get clearDebugLogButton => 'Clear Debug Log';

  @override
  String get clearDebugLogTitle => 'Clear the debug log?';

  @override
  String get clearDebugLogBody =>
      'This removes the saved technical report from your device.';

  @override
  String get debugLogClearedMessage => 'Debug log cleared.';

  @override
  String get premiumUnlockLabel => 'Remove Ads Forever';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'All';

  @override
  String get chipNotebooks => 'Notebooks';

  @override
  String get chipRecent => 'Recent';

  @override
  String get emptyAllNotesTitle => 'No notes yet';

  @override
  String get emptyAllNotesBody => 'Tap the + button to write your first note.';

  @override
  String get emptyRecentNotesTitle => 'Nothing recent';

  @override
  String get emptyRecentNotesBody => 'Notes you edit will show up here.';

  @override
  String get noteActionRename => 'Rename';

  @override
  String get noteActionMoveToNotebook => 'Move to Notebook';

  @override
  String get noteActionEdit => 'Edit';

  @override
  String get noteActionExport => 'Export';

  @override
  String get noteActionShare => 'Share';

  @override
  String get moveToNotebookTitle => 'Move to Notebook';

  @override
  String get moveToNotebookEmptyBody =>
      'No other notebooks yet. Create one to organise this note.';

  @override
  String get moveToNotebookCreateRow => 'Create new notebook';

  @override
  String get notebookActionRename => 'Rename';

  @override
  String get notebookActionChangeCover => 'Change cover';

  @override
  String get notebookRenameDialogTitle => 'Rename Notebook';

  @override
  String get notebookCoverPickerTitle => 'Choose a cover color';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'This will delete the notebook and its $count notes. This can\'t be undone.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Legal & Support';

  @override
  String get privacyPolicyRow => 'Privacy Policy';

  @override
  String get termsOfServiceRow => 'Terms of Service';

  @override
  String get supportRow => 'Support';

  @override
  String get openLinkFailedMessage =>
      'Couldn\'t open the link. Please try again.';

  @override
  String get openSourceLicensesRow => 'Open-source licenses';
}
