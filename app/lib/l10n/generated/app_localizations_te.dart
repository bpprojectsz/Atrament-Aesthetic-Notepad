// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get errorGeneric => 'ఏదో తప్పు జరిగింది';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get save => 'సేవ్ చేయండి';

  @override
  String get delete => 'తొలగించండి';

  @override
  String get undo => 'అన్‌డూ';

  @override
  String get redo => 'రీడూ';

  @override
  String get untitledNote => 'పేరు లేనిది';

  @override
  String get deleteConfirmBody => 'ఈ చర్యను వెనక్కి తీసుకోలేరు.';

  @override
  String get deleteNoteTitle => 'ఈ నోట్‌ను తొలగించాలా?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” ను తొలగించాలా?';
  }

  @override
  String get saveFailedMessage =>
      'సేవ్ చేయడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get exportFailedMessage =>
      'ఈ నోట్‌ను ఎగుమతి చేయడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get shareFailedMessage =>
      'షేర్ మెనూను తెరవడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get settingsTitle => 'సెట్టింగ్‌లు';

  @override
  String get searchHint => 'నోట్స్‌లో వెతకండి';

  @override
  String get emptyNotebooksTitle => 'ఇంకా నోట్‌బుక్‌లు లేవు';

  @override
  String get emptyNotebooksBody =>
      'రాయడం ప్రారంభించడానికి మీ మొదటి నోట్‌బుక్‌ను సృష్టించండి.';

  @override
  String get emptySearchTitle => 'ఫలితాలు లేవు';

  @override
  String get emptySearchBody => 'మరో శోధన పదాన్ని ప్రయత్నించండి.';

  @override
  String get emptyNotebookTitle => 'ఇంకా నోట్స్ లేవు';

  @override
  String get emptyNotebookBody => 'మీ మొదటి నోట్ రాయడానికి + నొక్కండి.';

  @override
  String get newNotebookTitle => 'కొత్త నోట్‌బుక్';

  @override
  String get notebookNameHint => 'నోట్‌బుక్ పేరు';

  @override
  String get newNoteTitle => 'కొత్త నోట్';

  @override
  String get sortOptionsTitle => 'క్రమబద్ధీకరించు';

  @override
  String get sortByModified => 'చివరిగా సవరించినది';

  @override
  String get sortByCreated => 'సృష్టించిన తేదీ';

  @override
  String get sortByTitle => 'శీర్షిక';

  @override
  String get formatBold => 'బోల్డ్';

  @override
  String get formatItalic => 'ఇటాలిక్';

  @override
  String get formatUnderline => 'అండర్‌లైన్';

  @override
  String get formatHeading => 'హెడ్డింగ్';

  @override
  String get formatBulletList => 'బుల్లెట్ జాబితా';

  @override
  String get formatChecklist => 'చెక్‌లిస్ట్';

  @override
  String get formatQuote => 'కొటేషన్';

  @override
  String get formatCodeBlock => 'కోడ్ బ్లాక్';

  @override
  String get penFountainPen => 'ఫౌంటెన్ పెన్';

  @override
  String get penGelPen => 'జెల్ పెన్';

  @override
  String get penPencil => 'పెన్సిల్';

  @override
  String get penHighlighter => 'హైలైటర్';

  @override
  String get penEraser => 'ఎరేజర్';

  @override
  String get penStrokeWidth => 'గీత మందం';

  @override
  String get toggleHandwritingMode => 'టైపింగ్ మరియు గీయడం మధ్య మారండి';

  @override
  String get biometricLockReason => 'నోట్‌ను చూడటానికి అన్‌లాక్ చేయండి';

  @override
  String get noteLockedMessage => 'ఈ నోట్ లాక్ చేయబడింది';

  @override
  String get unlockButton => 'అన్‌లాక్';

  @override
  String get noteLockTurnedOffMessage =>
      'ఈ పరికరంలో స్క్రీన్ లాక్ లేదా బయోమెట్రిక్స్ సెటప్ చేయనందున నోట్ లాక్ ఆఫ్ చేయబడింది.';

  @override
  String get biometricEnableReason =>
      'నోట్ లాక్‌ను ఆన్ చేయడానికి మీ గుర్తింపును నిర్ధారించండి';

  @override
  String get biometricDisableReason =>
      'నోట్ లాక్‌ను ఆఫ్ చేయడానికి మీ గుర్తింపును నిర్ధారించండి';

  @override
  String get biometricShareReason =>
      'ఈ నోట్‌ను షేర్ చేయడానికి లేదా ఎగుమతి చేయడానికి అన్‌లాక్ చేయండి';

  @override
  String get biometricAuthFailedMessage =>
      'మీ గుర్తింపును ధృవీకరించడం సాధ్యం కాలేదు.';

  @override
  String get biometricSetupNeededMessage =>
      'ముందుగా పరికర సెట్టింగ్‌లలో స్క్రీన్ లాక్ లేదా వేలిముద్రను సెటప్ చేయండి.';

  @override
  String get privacyChoicesTitle => 'గోప్యతా ఎంపికలు';

  @override
  String get purchaseFailedMessage =>
      'కొనుగోలును పూర్తి చేయడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get restoreSuccessMessage => 'మీ కొనుగోలు పునరుద్ధరించబడింది.';

  @override
  String get restoreNothingFoundMessage =>
      'ఈ ఖాతాకు గతంలో చేసిన కొనుగోళ్లు ఏవీ కనుగొనబడలేదు.';

  @override
  String get restoreFailedMessage =>
      'కొనుగోళ్లను పునరుద్ధరించడం సాధ్యం కాలేదు. మీ కనెక్షన్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get reminderScheduleFailedMessage =>
      'రిమైండర్‌ను షెడ్యూల్ చేయడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get storageIssueNotebooksLoad =>
      'కొన్ని నోట్‌బుక్‌లను లోడ్ చేయడం సాధ్యం కాలేదు. అందుబాటులో ఉన్నవి చూపబడుతున్నాయి.';

  @override
  String get storageIssueNotebookSave =>
      'ఈ నోట్‌బుక్ సేవ్ కాకపోయి ఉండవచ్చు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get storageIssueNotebookChange =>
      'ఈ మార్పు సేవ్ కాకపోయి ఉండవచ్చు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get storageIssueNotebookDelete =>
      'నోట్‌బుక్‌ను తొలగించడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get storageIssueNotebookOrder =>
      'కొత్త క్రమం సేవ్ కాకపోయి ఉండవచ్చు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get storageIssueNotesLoad =>
      'కొన్ని నోట్స్‌ను లోడ్ చేయడం సాధ్యం కాలేదు. అందుబాటులో ఉన్నవి చూపబడుతున్నాయి.';

  @override
  String get storageIssueSearch =>
      'ప్రస్తుతం శోధన ఫలితాలు అసంపూర్ణంగా ఉండవచ్చు.';

  @override
  String get storageIssueNoteSave =>
      'ఈ నోట్ సేవ్ కాకపోయి ఉండవచ్చు. మీ పరికర నిల్వను తనిఖీ చేయండి.';

  @override
  String get storageIssueNoteDelete =>
      'నోట్‌ను తొలగించడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get purchaseUnavailableMessage =>
      'ఈ కొనుగోలు ప్రస్తుతం అందుబాటులో లేదు. దయచేసి తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get exportTitle => 'ఎగుమతి';

  @override
  String get exportAsTxt => 'టెక్స్ట్‌గా ఎగుమతి చేయండి';

  @override
  String get exportAsPdf => 'PDFగా ఎగుమతి చేయండి';

  @override
  String get paperStyleSectionTitle => 'కాగితం శైలి';

  @override
  String get paperStyleLined => 'గీతలతో';

  @override
  String get paperStyleDotGrid => 'చుక్కలతో';

  @override
  String get paperStyleGrid => 'గడులతో';

  @override
  String get paperStyleBlank => 'ఖాళీ';

  @override
  String get paperStyleCream => 'క్రీమ్';

  @override
  String get paperStyleParchment => 'పార్చ్‌మెంట్';

  @override
  String get paperStyleVellum => 'వెల్లం';

  @override
  String get fontSectionTitle => 'నోట్ ఫాంట్';

  @override
  String get fontSystem => 'సిస్టమ్';

  @override
  String get fontSerif => 'సెరిఫ్';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'రూపం';

  @override
  String get themeLight => 'లైట్';

  @override
  String get themeDark => 'డార్క్';

  @override
  String get themeParchment => 'పార్చ్‌మెంట్';

  @override
  String get themeSystem => 'సిస్టమ్';

  @override
  String get verseSectionTitle => 'నేటి బైబిల్ వచన ప్రదర్శన';

  @override
  String get verseModeWatermark => 'వాటర్‌మార్క్';

  @override
  String get verseModeHeader => 'హెడర్';

  @override
  String get verseModeFooter => 'ఫుటర్';

  @override
  String get verseModeOff => 'ఆఫ్';

  @override
  String get notificationsSectionTitle => 'నోటిఫికేషన్‌లు';

  @override
  String get dailyReminderToggle => 'రోజువారీ బైబిల్ వచన రిమైండర్';

  @override
  String get reminderTimeLabel => 'రిమైండర్ సమయం';

  @override
  String get notificationPermissionDenied =>
      'సిస్టమ్ సెట్టింగ్‌లలో నోటిఫికేషన్‌లు ఆఫ్ చేయబడ్డాయి.';

  @override
  String get dailyReminderBody => 'మీ నేటి బైబిల్ వచనం సిద్ధంగా ఉంది.';

  @override
  String get privacySectionTitle => 'గోప్యత';

  @override
  String get biometricLockToggle =>
      'Face ID / వేలిముద్రతో నోట్స్‌ను లాక్ చేయండి';

  @override
  String get premiumSectionTitle => 'ప్రీమియం';

  @override
  String get removeAdsTitle => 'ప్రకటనలను తీసివేయండి';

  @override
  String get restorePurchasesButton => 'కొనుగోళ్లను పునరుద్ధరించండి';

  @override
  String get proLabel => 'ప్రో';

  @override
  String get engagementSectionTitle => 'మరిన్ని';

  @override
  String get rateAppTitle => 'Atrament కు రేటింగ్ ఇవ్వండి';

  @override
  String get rateAppSubtitle => 'యాప్ నచ్చిందా? ఒక సమీక్ష రాయండి';

  @override
  String get shareAppTitle => 'Atrament ను షేర్ చేయండి';

  @override
  String get shareAppSubtitle => 'స్నేహితుడికి చెప్పండి';

  @override
  String get shareAppMessage =>
      'Atrament ను ప్రయత్నించండి — కాగితపు ఆకృతులతో అంతరాయం లేని నోట్‌ప్యాడ్.';

  @override
  String get languageSectionTitle => 'భాష';

  @override
  String get languageFollowsSystem => 'పరికరం భాష సెట్టింగ్‌ను అనుసరిస్తుంది';

  @override
  String get languageSystem => 'సిస్టమ్ డిఫాల్ట్';

  @override
  String get languagePickerTitle => 'భాషను ఎంచుకోండి';

  @override
  String get premiumScreenTitle => 'ప్రకటనలను తీసివేయండి';

  @override
  String get premiumHeadline => 'అంతరాయం లేకుండా రాయండి';

  @override
  String get premiumBody =>
      'Atrament ఉచితం, ఒక చిన్న ప్రకటన బ్యానర్‌ను మాత్రమే చూపుతుంది. ప్రకటనలను తీసివేయడం ఒక్కసారి చేసే కొనుగోలు, ఇది మరేదీ అన్‌లాక్ చేయదు — అన్ని ఫీచర్లు ఇప్పటికే మీవే.';

  @override
  String get premiumRestoreButton => 'కొనుగోళ్లను పునరుద్ధరించండి';

  @override
  String get premiumAlreadyProMessage =>
      'మీ దగ్గర ఇప్పటికే “ప్రకటనలను తీసివేయండి” ఉంది. ధన్యవాదాలు!';

  @override
  String get supportSectionTitle => 'మద్దతు';

  @override
  String get shareDebugLogButton => 'డీబగ్ లాగ్‌ను షేర్ చేయండి';

  @override
  String get shareDebugLogSubtitle =>
      'ఏదైనా పని చేయకపోతే సాంకేతిక నివేదికను పంపండి';

  @override
  String get noDebugLogMessage => 'ఇంకా నివేదించడానికి ఏమీ లేదు.';

  @override
  String get clearDebugLogButton => 'డీబగ్ లాగ్‌ను క్లియర్ చేయండి';

  @override
  String get clearDebugLogTitle => 'డీబగ్ లాగ్‌ను క్లియర్ చేయాలా?';

  @override
  String get clearDebugLogBody =>
      'సేవ్ చేసిన సాంకేతిక నివేదిక మీ పరికరం నుండి తీసివేయబడుతుంది.';

  @override
  String get debugLogClearedMessage => 'డీబగ్ లాగ్ క్లియర్ చేయబడింది.';

  @override
  String get premiumUnlockLabel => 'ప్రకటనలను శాశ్వతంగా తీసివేయండి';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'అన్నీ';

  @override
  String get chipNotebooks => 'నోట్‌బుక్‌లు';

  @override
  String get chipRecent => 'ఇటీవలివి';

  @override
  String get emptyAllNotesTitle => 'ఇంకా నోట్స్ లేవు';

  @override
  String get emptyAllNotesBody => 'మీ మొదటి నోట్ రాయడానికి + నొక్కండి.';

  @override
  String get emptyRecentNotesTitle => 'ఇటీవలివి ఏవీ లేవు';

  @override
  String get emptyRecentNotesBody => 'మీరు సవరించే నోట్స్ ఇక్కడ కనిపిస్తాయి.';

  @override
  String get noteActionRename => 'పేరు మార్చండి';

  @override
  String get noteActionMoveToNotebook => 'నోట్‌బుక్‌కు తరలించండి';

  @override
  String get noteActionEdit => 'సవరించండి';

  @override
  String get noteActionExport => 'ఎగుమతి చేయండి';

  @override
  String get noteActionShare => 'షేర్ చేయండి';

  @override
  String get moveToNotebookTitle => 'నోట్‌బుక్‌కు తరలించండి';

  @override
  String get moveToNotebookEmptyBody =>
      'ఇంకా ఇతర నోట్‌బుక్‌లు లేవు. ఈ నోట్‌ను క్రమబద్ధీకరించడానికి ఒకటి సృష్టించండి.';

  @override
  String get moveToNotebookCreateRow => 'కొత్త నోట్‌బుక్‌ను సృష్టించండి';

  @override
  String get notebookActionRename => 'పేరు మార్చండి';

  @override
  String get notebookActionChangeCover => 'కవర్ మార్చండి';

  @override
  String get notebookRenameDialogTitle => 'నోట్‌బుక్ పేరు మార్చండి';

  @override
  String get notebookCoverPickerTitle => 'కవర్ రంగును ఎంచుకోండి';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'నోట్‌బుక్ దానిలోని అన్ని నోట్స్‌తో పాటు తొలగించబడుతుంది (మొత్తం: $count). ఈ చర్యను వెనక్కి తీసుకోలేరు.';
  }

  @override
  String get legalAndSupportSectionTitle => 'చట్టపరమైన సమాచారం మరియు మద్దతు';

  @override
  String get privacyPolicyRow => 'గోప్యతా విధానం';

  @override
  String get termsOfServiceRow => 'సేవా నిబంధనలు';

  @override
  String get supportRow => 'మద్దతు';

  @override
  String get openLinkFailedMessage =>
      'లింక్‌ను తెరవడం సాధ్యం కాలేదు. దయచేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get openSourceLicensesRow => 'ఓపెన్ సోర్స్ లైసెన్స్‌లు';
}
