// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Subukan ulit';

  @override
  String get errorGeneric => 'May nangyaring mali';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get save => 'I-save';

  @override
  String get delete => 'Burahin';

  @override
  String get undo => 'I-undo';

  @override
  String get redo => 'I-redo';

  @override
  String get untitledNote => 'Walang pamagat';

  @override
  String get deleteConfirmBody => 'Hindi na ito mababawi.';

  @override
  String get deleteNoteTitle => 'Burahin ang note na ito?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Burahin ang “$name”?';
  }

  @override
  String get saveFailedMessage => 'Hindi ma-save. Pakisubukan ulit.';

  @override
  String get exportFailedMessage =>
      'Hindi ma-export ang note na ito. Pakisubukan ulit.';

  @override
  String get shareFailedMessage =>
      'Hindi mabuksan ang menu ng pagbabahagi. Pakisubukan ulit.';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get searchHint => 'Maghanap sa mga note';

  @override
  String get emptyNotebooksTitle => 'Wala pang notebook';

  @override
  String get emptyNotebooksBody =>
      'Gawin ang una mong notebook para magsimulang magsulat.';

  @override
  String get emptySearchTitle => 'Walang resulta';

  @override
  String get emptySearchBody => 'Subukan ang ibang salita sa paghahanap.';

  @override
  String get emptyNotebookTitle => 'Wala pang note';

  @override
  String get emptyNotebookBody => 'I-tap ang + para isulat ang una mong note.';

  @override
  String get newNotebookTitle => 'Bagong notebook';

  @override
  String get notebookNameHint => 'Pangalan ng notebook';

  @override
  String get newNoteTitle => 'Bagong note';

  @override
  String get sortOptionsTitle => 'I-sort';

  @override
  String get sortByModified => 'Huling na-edit';

  @override
  String get sortByCreated => 'Petsa ng paggawa';

  @override
  String get sortByTitle => 'Pamagat';

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
  String get formatQuote => 'Sipi';

  @override
  String get formatCodeBlock => 'Code block';

  @override
  String get penFountainPen => 'Fountain pen';

  @override
  String get penGelPen => 'Gel pen';

  @override
  String get penPencil => 'Lapis';

  @override
  String get penHighlighter => 'Highlighter';

  @override
  String get penEraser => 'Pambura';

  @override
  String get penStrokeWidth => 'Kapal ng guhit';

  @override
  String get toggleHandwritingMode =>
      'Magpalit sa pagitan ng pag-type at pagguhit';

  @override
  String get biometricLockReason => 'I-unlock para makita ang note';

  @override
  String get noteLockedMessage => 'Naka-lock ang note na ito';

  @override
  String get unlockButton => 'I-unlock';

  @override
  String get noteLockTurnedOffMessage =>
      'Naka-off ang lock ng note dahil walang naka-set up na screen lock o biometrics ang device na ito.';

  @override
  String get biometricEnableReason =>
      'Kumpirmahin ang pagkakakilanlan mo para i-on ang lock ng note';

  @override
  String get biometricDisableReason =>
      'Kumpirmahin ang pagkakakilanlan mo para i-off ang lock ng note';

  @override
  String get biometricShareReason =>
      'I-unlock para ibahagi o i-export ang note na ito';

  @override
  String get biometricAuthFailedMessage =>
      'Hindi makumpirma ang pagkakakilanlan mo.';

  @override
  String get biometricSetupNeededMessage =>
      'Mag-set up muna ng screen lock o fingerprint sa mga setting ng device.';

  @override
  String get privacyChoicesTitle => 'Mga pagpipilian sa privacy';

  @override
  String get purchaseFailedMessage =>
      'Hindi makumpleto ang pagbili. Pakisubukan ulit.';

  @override
  String get restoreSuccessMessage => 'Na-restore na ang binili mo.';

  @override
  String get restoreNothingFoundMessage =>
      'Walang nakitang nakaraang pagbili para sa account na ito.';

  @override
  String get restoreFailedMessage =>
      'Hindi ma-restore ang mga pagbili. Tingnan ang koneksyon mo at subukan ulit.';

  @override
  String get reminderScheduleFailedMessage =>
      'Hindi ma-schedule ang paalala. Pakisubukan ulit.';

  @override
  String get storageIssueNotebooksLoad =>
      'Hindi ma-load ang ilang notebook. Ipinapakita ang mga available.';

  @override
  String get storageIssueNotebookSave =>
      'Posibleng hindi na-save ang notebook na ito. Pakisubukan ulit.';

  @override
  String get storageIssueNotebookChange =>
      'Posibleng hindi na-save ang pagbabagong ito. Pakisubukan ulit.';

  @override
  String get storageIssueNotebookDelete =>
      'Hindi mabura ang notebook. Pakisubukan ulit.';

  @override
  String get storageIssueNotebookOrder =>
      'Posibleng hindi na-save ang bagong pagkakasunod-sunod. Pakisubukan ulit.';

  @override
  String get storageIssueNotesLoad =>
      'Hindi ma-load ang ilang note. Ipinapakita ang mga available.';

  @override
  String get storageIssueSearch =>
      'Maaaring hindi kumpleto ang mga resulta ng paghahanap ngayon.';

  @override
  String get storageIssueNoteSave =>
      'Posibleng hindi na-save ang note na ito. Tingnan ang storage ng device mo.';

  @override
  String get storageIssueNoteDelete =>
      'Hindi mabura ang note. Pakisubukan ulit.';

  @override
  String get purchaseUnavailableMessage =>
      'Hindi available ang pagbiling ito ngayon. Pakisubukan ulit mamaya.';

  @override
  String get exportTitle => 'I-export';

  @override
  String get exportAsTxt => 'I-export bilang teksto';

  @override
  String get exportAsPdf => 'I-export bilang PDF';

  @override
  String get paperStyleSectionTitle => 'Istilo ng papel';

  @override
  String get paperStyleLined => 'May guhit';

  @override
  String get paperStyleDotGrid => 'May tuldok';

  @override
  String get paperStyleGrid => 'May kuwadrado';

  @override
  String get paperStyleBlank => 'Blangko';

  @override
  String get paperStyleCream => 'Krema';

  @override
  String get paperStyleParchment => 'Pergamino';

  @override
  String get paperStyleVellum => 'Vellum';

  @override
  String get fontSectionTitle => 'Font ng mga note';

  @override
  String get fontSystem => 'System';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Hitsura';

  @override
  String get themeLight => 'Maliwanag';

  @override
  String get themeDark => 'Madilim';

  @override
  String get themeParchment => 'Pergamino';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Pagpapakita ng pang-araw-araw na talata';

  @override
  String get verseModeWatermark => 'Watermark';

  @override
  String get verseModeHeader => 'Header';

  @override
  String get verseModeFooter => 'Footer';

  @override
  String get verseModeOff => 'Naka-off';

  @override
  String get notificationsSectionTitle => 'Mga notification';

  @override
  String get dailyReminderToggle => 'Pang-araw-araw na paalala ng talata';

  @override
  String get reminderTimeLabel => 'Oras ng paalala';

  @override
  String get notificationPermissionDenied =>
      'Naka-off ang mga notification sa mga setting ng system.';

  @override
  String get dailyReminderBody => 'Handa na ang talata mo sa araw na ito.';

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get biometricLockToggle =>
      'I-lock ang mga note gamit ang Face ID / fingerprint';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Alisin ang mga ad';

  @override
  String get restorePurchasesButton => 'I-restore ang mga pagbili';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Higit pa';

  @override
  String get rateAppTitle => 'I-rate ang Atrament';

  @override
  String get rateAppSubtitle => 'Gusto mo ba ang app? Mag-iwan ng review';

  @override
  String get shareAppTitle => 'Ibahagi ang Atrament';

  @override
  String get shareAppSubtitle => 'Sabihin sa kaibigan';

  @override
  String get shareAppMessage =>
      'Subukan ang Atrament, isang notepad na walang distraksyon na may texture ng papel.';

  @override
  String get languageSectionTitle => 'Wika';

  @override
  String get languageFollowsSystem => 'Sumusunod sa wika ng device';

  @override
  String get languageSystem => 'Default ng system';

  @override
  String get languagePickerTitle => 'Pumili ng wika';

  @override
  String get premiumScreenTitle => 'Alisin ang mga ad';

  @override
  String get premiumHeadline => 'Magsulat nang walang distraksyon';

  @override
  String get premiumBody =>
      'Libre ang Atrament at nagpapakita lang ng isang maliit na ad banner. Ang pag-alis ng mga ad ay isang beses na pagbili na walang ibang bubuksan: sa iyo na ang lahat ng feature.';

  @override
  String get premiumRestoreButton => 'I-restore ang mga pagbili';

  @override
  String get premiumAlreadyProMessage =>
      'Mayroon ka na ng “Alisin ang mga ad”. Salamat!';

  @override
  String get supportSectionTitle => 'Suporta';

  @override
  String get shareDebugLogButton => 'Ibahagi ang debug log';

  @override
  String get shareDebugLogSubtitle =>
      'Magpadala ng teknikal na ulat kung may hindi gumagana';

  @override
  String get noDebugLogMessage => 'Wala pang ire-report.';

  @override
  String get clearDebugLogButton => 'I-clear ang debug log';

  @override
  String get clearDebugLogTitle => 'I-clear ang debug log?';

  @override
  String get clearDebugLogBody =>
      'Aalisin sa device mo ang naka-save na teknikal na ulat.';

  @override
  String get debugLogClearedMessage => 'Na-clear na ang debug log.';

  @override
  String get premiumUnlockLabel => 'Alisin ang mga ad magpakailanman';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Lahat';

  @override
  String get chipNotebooks => 'Mga notebook';

  @override
  String get chipRecent => 'Kamakailan';

  @override
  String get emptyAllNotesTitle => 'Wala pang note';

  @override
  String get emptyAllNotesBody => 'I-tap ang + para isulat ang una mong note.';

  @override
  String get emptyRecentNotesTitle => 'Walang kamakailan';

  @override
  String get emptyRecentNotesBody =>
      'Lalabas dito ang mga note na ine-edit mo.';

  @override
  String get noteActionRename => 'Palitan ang pangalan';

  @override
  String get noteActionMoveToNotebook => 'Ilipat sa notebook';

  @override
  String get noteActionEdit => 'I-edit';

  @override
  String get noteActionExport => 'I-export';

  @override
  String get noteActionShare => 'Ibahagi';

  @override
  String get moveToNotebookTitle => 'Ilipat sa notebook';

  @override
  String get moveToNotebookEmptyBody =>
      'Wala pang ibang notebook. Gumawa ng isa para ayusin ang note na ito.';

  @override
  String get moveToNotebookCreateRow => 'Gumawa ng bagong notebook';

  @override
  String get notebookActionRename => 'Palitan ang pangalan';

  @override
  String get notebookActionChangeCover => 'Palitan ang pabalat';

  @override
  String get notebookRenameDialogTitle => 'Palitan ang pangalan ng notebook';

  @override
  String get notebookCoverPickerTitle => 'Pumili ng kulay ng pabalat';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Buburahin ang notebook kasama ang lahat ng note nito (kabuuan: $count). Hindi na ito mababawi.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Legal at suporta';

  @override
  String get privacyPolicyRow => 'Patakaran sa Privacy';

  @override
  String get termsOfServiceRow => 'Mga Tuntunin ng Serbisyo';

  @override
  String get supportRow => 'Suporta';

  @override
  String get openLinkFailedMessage =>
      'Hindi mabuksan ang link. Pakisubukan ulit.';

  @override
  String get openSourceLicensesRow => 'Mga lisensya ng open source';
}
