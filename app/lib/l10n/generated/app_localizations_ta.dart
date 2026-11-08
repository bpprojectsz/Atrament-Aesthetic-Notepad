// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'மீண்டும் முயலவும்';

  @override
  String get errorGeneric => 'ஏதோ தவறு நடந்தது';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get save => 'சேமி';

  @override
  String get delete => 'நீக்கு';

  @override
  String get undo => 'செயல்தவிர்';

  @override
  String get redo => 'மீண்டும் செய்';

  @override
  String get untitledNote => 'தலைப்பில்லாதது';

  @override
  String get deleteConfirmBody => 'இந்தச் செயலைத் திரும்பப் பெற முடியாது.';

  @override
  String get deleteNoteTitle => 'இந்தக் குறிப்பை நீக்கவா?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” ஐ நீக்கவா?';
  }

  @override
  String get saveFailedMessage => 'சேமிக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get exportFailedMessage =>
      'இந்தக் குறிப்பை ஏற்றுமதி செய்ய முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get shareFailedMessage =>
      'பகிர்வு மெனுவைத் திறக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get searchHint => 'குறிப்புகளில் தேடு';

  @override
  String get emptyNotebooksTitle => 'இன்னும் நோட்புக்குகள் இல்லை';

  @override
  String get emptyNotebooksBody =>
      'எழுதத் தொடங்க உங்கள் முதல் நோட்புக்கை உருவாக்குங்கள்.';

  @override
  String get emptySearchTitle => 'முடிவுகள் இல்லை';

  @override
  String get emptySearchBody => 'வேறொரு தேடல் சொல்லை முயலவும்.';

  @override
  String get emptyNotebookTitle => 'இன்னும் குறிப்புகள் இல்லை';

  @override
  String get emptyNotebookBody => 'உங்கள் முதல் குறிப்பை எழுத + ஐத் தட்டவும்.';

  @override
  String get newNotebookTitle => 'புதிய நோட்புக்';

  @override
  String get notebookNameHint => 'நோட்புக் பெயர்';

  @override
  String get newNoteTitle => 'புதிய குறிப்பு';

  @override
  String get sortOptionsTitle => 'வரிசைப்படுத்து';

  @override
  String get sortByModified => 'கடைசியாகத் திருத்தியது';

  @override
  String get sortByCreated => 'உருவாக்கிய தேதி';

  @override
  String get sortByTitle => 'தலைப்பு';

  @override
  String get formatBold => 'தடித்த';

  @override
  String get formatItalic => 'சாய்வு';

  @override
  String get formatUnderline => 'அடிக்கோடு';

  @override
  String get formatHeading => 'தலைப்பு';

  @override
  String get formatBulletList => 'புள்ளிப் பட்டியல்';

  @override
  String get formatChecklist => 'சரிபார்ப்புப் பட்டியல்';

  @override
  String get formatQuote => 'மேற்கோள்';

  @override
  String get formatCodeBlock => 'குறியீட்டுத் தொகுதி';

  @override
  String get penFountainPen => 'ஃபவுண்டன் பேனா';

  @override
  String get penGelPen => 'ஜெல் பேனா';

  @override
  String get penPencil => 'பென்சில்';

  @override
  String get penHighlighter => 'ஹைலைட்டர்';

  @override
  String get penEraser => 'அழிப்பான்';

  @override
  String get penStrokeWidth => 'கோட்டின் தடிமன்';

  @override
  String get toggleHandwritingMode => 'தட்டச்சுக்கும் வரைவதற்கும் இடையே மாறு';

  @override
  String get biometricLockReason => 'குறிப்பைப் பார்க்க பூட்டைத் திறக்கவும்';

  @override
  String get noteLockedMessage => 'இந்தக் குறிப்பு பூட்டப்பட்டுள்ளது';

  @override
  String get unlockButton => 'திற';

  @override
  String get noteLockTurnedOffMessage =>
      'இந்தச் சாதனத்தில் திரைப் பூட்டு அல்லது பயோமெட்ரிக் அமைக்கப்படாததால் குறிப்புப் பூட்டு அணைக்கப்பட்டது.';

  @override
  String get biometricEnableReason =>
      'குறிப்புப் பூட்டை இயக்க உங்கள் அடையாளத்தை உறுதிப்படுத்தவும்';

  @override
  String get biometricDisableReason =>
      'குறிப்புப் பூட்டை அணைக்க உங்கள் அடையாளத்தை உறுதிப்படுத்தவும்';

  @override
  String get biometricShareReason =>
      'இந்தக் குறிப்பைப் பகிர அல்லது ஏற்றுமதி செய்ய பூட்டைத் திறக்கவும்';

  @override
  String get biometricAuthFailedMessage =>
      'உங்கள் அடையாளத்தைச் சரிபார்க்க முடியவில்லை.';

  @override
  String get biometricSetupNeededMessage =>
      'முதலில் சாதன அமைப்புகளில் திரைப் பூட்டு அல்லது கைரேகையை அமைக்கவும்.';

  @override
  String get privacyChoicesTitle => 'தனியுரிமை விருப்பங்கள்';

  @override
  String get purchaseFailedMessage =>
      'வாங்குதலை முடிக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get restoreSuccessMessage => 'உங்கள் வாங்குதல் மீட்டெடுக்கப்பட்டது.';

  @override
  String get restoreNothingFoundMessage =>
      'இந்தக் கணக்கிற்கு முந்தைய வாங்குதல் எதுவும் கிடைக்கவில்லை.';

  @override
  String get restoreFailedMessage =>
      'வாங்குதல்களை மீட்டெடுக்க முடியவில்லை. உங்கள் இணைப்பைச் சரிபார்த்து மீண்டும் முயலவும்.';

  @override
  String get reminderScheduleFailedMessage =>
      'நினைவூட்டலைத் திட்டமிட முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get storageIssueNotebooksLoad =>
      'சில நோட்புக்குகளை ஏற்ற முடியவில்லை. கிடைப்பவை காட்டப்படுகின்றன.';

  @override
  String get storageIssueNotebookSave =>
      'இந்த நோட்புக் சேமிக்கப்படாமல் இருக்கலாம். மீண்டும் முயலவும்.';

  @override
  String get storageIssueNotebookChange =>
      'இந்த மாற்றம் சேமிக்கப்படாமல் இருக்கலாம். மீண்டும் முயலவும்.';

  @override
  String get storageIssueNotebookDelete =>
      'நோட்புக்கை நீக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get storageIssueNotebookOrder =>
      'புதிய வரிசை சேமிக்கப்படாமல் இருக்கலாம். மீண்டும் முயலவும்.';

  @override
  String get storageIssueNotesLoad =>
      'சில குறிப்புகளை ஏற்ற முடியவில்லை. கிடைப்பவை காட்டப்படுகின்றன.';

  @override
  String get storageIssueSearch =>
      'தேடல் முடிவுகள் இப்போது முழுமையற்றதாக இருக்கலாம்.';

  @override
  String get storageIssueNoteSave =>
      'இந்தக் குறிப்பு சேமிக்கப்படாமல் இருக்கலாம். உங்கள் சாதனச் சேமிப்பகத்தைச் சரிபார்க்கவும்.';

  @override
  String get storageIssueNoteDelete =>
      'குறிப்பை நீக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get purchaseUnavailableMessage =>
      'இந்த வாங்குதல் இப்போது கிடைக்கவில்லை. பின்னர் மீண்டும் முயலவும்.';

  @override
  String get exportTitle => 'ஏற்றுமதி';

  @override
  String get exportAsTxt => 'உரையாக ஏற்றுமதி செய்';

  @override
  String get exportAsPdf => 'PDF ஆக ஏற்றுமதி செய்';

  @override
  String get paperStyleSectionTitle => 'காகித நடை';

  @override
  String get paperStyleLined => 'கோடிட்ட';

  @override
  String get paperStyleDotGrid => 'புள்ளியிட்ட';

  @override
  String get paperStyleGrid => 'கட்டமிட்ட';

  @override
  String get paperStyleBlank => 'வெற்று';

  @override
  String get paperStyleCream => 'கிரீம்';

  @override
  String get paperStyleParchment => 'பார்ச்மென்ட்';

  @override
  String get paperStyleVellum => 'வெலம்';

  @override
  String get fontSectionTitle => 'குறிப்பு எழுத்துரு';

  @override
  String get fontSystem => 'சிஸ்டம்';

  @override
  String get fontSerif => 'செரிஃப்';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'தோற்றம்';

  @override
  String get themeLight => 'வெளிர்';

  @override
  String get themeDark => 'அடர்';

  @override
  String get themeParchment => 'பார்ச்மென்ட்';

  @override
  String get themeSystem => 'சிஸ்டம்';

  @override
  String get verseSectionTitle => 'இன்றைய வசனக் காட்சி';

  @override
  String get verseModeWatermark => 'நீர்க்குறி';

  @override
  String get verseModeHeader => 'தலைப்புப் பகுதி';

  @override
  String get verseModeFooter => 'அடிப்பகுதி';

  @override
  String get verseModeOff => 'முடக்கம்';

  @override
  String get notificationsSectionTitle => 'அறிவிப்புகள்';

  @override
  String get dailyReminderToggle => 'தினசரி வசன நினைவூட்டல்';

  @override
  String get reminderTimeLabel => 'நினைவூட்டல் நேரம்';

  @override
  String get notificationPermissionDenied =>
      'சிஸ்டம் அமைப்புகளில் அறிவிப்புகள் அணைக்கப்பட்டுள்ளன.';

  @override
  String get dailyReminderBody => 'உங்கள் இன்றைய வசனம் தயாராக உள்ளது.';

  @override
  String get privacySectionTitle => 'தனியுரிமை';

  @override
  String get biometricLockToggle => 'Face ID / கைரேகையால் குறிப்புகளைப் பூட்டு';

  @override
  String get premiumSectionTitle => 'பிரீமியம்';

  @override
  String get removeAdsTitle => 'விளம்பரங்களை அகற்று';

  @override
  String get restorePurchasesButton => 'வாங்குதல்களை மீட்டெடு';

  @override
  String get proLabel => 'ப்ரோ';

  @override
  String get engagementSectionTitle => 'மேலும்';

  @override
  String get rateAppTitle => 'Atrament ஐ மதிப்பிடுங்கள்';

  @override
  String get rateAppSubtitle =>
      'செயலி பிடித்திருக்கிறதா? ஒரு மதிப்புரை எழுதுங்கள்';

  @override
  String get shareAppTitle => 'Atrament ஐப் பகிருங்கள்';

  @override
  String get shareAppSubtitle => 'நண்பரிடம் சொல்லுங்கள்';

  @override
  String get shareAppMessage =>
      'Atrament ஐ முயன்று பாருங்கள் — காகிதத் தோற்றத்துடன் கவனச்சிதறல் இல்லாத ஒரு குறிப்பேடு.';

  @override
  String get languageSectionTitle => 'மொழி';

  @override
  String get languageFollowsSystem => 'சாதனத்தின் மொழி அமைப்பைப் பின்பற்றும்';

  @override
  String get languageSystem => 'சிஸ்டம் இயல்புநிலை';

  @override
  String get languagePickerTitle => 'மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get premiumScreenTitle => 'விளம்பரங்களை அகற்று';

  @override
  String get premiumHeadline => 'கவனச்சிதறல் இல்லாமல் எழுதுங்கள்';

  @override
  String get premiumBody =>
      'Atrament இலவசம்; ஒரே ஒரு சிறிய விளம்பரப் பட்டையை மட்டுமே காட்டும். விளம்பரங்களை அகற்றுவது ஒருமுறை வாங்கும் வசதி; அது வேறெதையும் திறக்காது — எல்லா அம்சங்களும் ஏற்கெனவே உங்களுடையவை.';

  @override
  String get premiumRestoreButton => 'வாங்குதல்களை மீட்டெடு';

  @override
  String get premiumAlreadyProMessage =>
      'உங்களிடம் ஏற்கெனவே “விளம்பரங்களை அகற்று” உள்ளது. நன்றி!';

  @override
  String get supportSectionTitle => 'ஆதரவு';

  @override
  String get shareDebugLogButton => 'பிழைத்திருத்தப் பதிவைப் பகிர்';

  @override
  String get shareDebugLogSubtitle =>
      'ஏதாவது வேலை செய்யவில்லை என்றால் தொழில்நுட்ப அறிக்கையை அனுப்புங்கள்';

  @override
  String get noDebugLogMessage => 'இன்னும் புகாரளிக்க எதுவும் இல்லை.';

  @override
  String get clearDebugLogButton => 'பிழைத்திருத்தப் பதிவை அழி';

  @override
  String get clearDebugLogTitle => 'பிழைத்திருத்தப் பதிவை அழிக்கவா?';

  @override
  String get clearDebugLogBody =>
      'சேமிக்கப்பட்ட தொழில்நுட்ப அறிக்கை உங்கள் சாதனத்திலிருந்து நீக்கப்படும்.';

  @override
  String get debugLogClearedMessage => 'பிழைத்திருத்தப் பதிவு அழிக்கப்பட்டது.';

  @override
  String get premiumUnlockLabel => 'விளம்பரங்களை நிரந்தரமாக அகற்று';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'அனைத்தும்';

  @override
  String get chipNotebooks => 'நோட்புக்குகள்';

  @override
  String get chipRecent => 'சமீபத்தியவை';

  @override
  String get emptyAllNotesTitle => 'இன்னும் குறிப்புகள் இல்லை';

  @override
  String get emptyAllNotesBody => 'உங்கள் முதல் குறிப்பை எழுத + ஐத் தட்டவும்.';

  @override
  String get emptyRecentNotesTitle => 'சமீபத்தியவை எதுவும் இல்லை';

  @override
  String get emptyRecentNotesBody =>
      'நீங்கள் திருத்தும் குறிப்புகள் இங்கே தோன்றும்.';

  @override
  String get noteActionRename => 'மறுபெயரிடு';

  @override
  String get noteActionMoveToNotebook => 'நோட்புக்கிற்கு நகர்த்து';

  @override
  String get noteActionEdit => 'திருத்து';

  @override
  String get noteActionExport => 'ஏற்றுமதி';

  @override
  String get noteActionShare => 'பகிர்';

  @override
  String get moveToNotebookTitle => 'நோட்புக்கிற்கு நகர்த்து';

  @override
  String get moveToNotebookEmptyBody =>
      'இன்னும் வேறு நோட்புக்குகள் இல்லை. இந்தக் குறிப்பை ஒழுங்கமைக்க ஒன்றை உருவாக்குங்கள்.';

  @override
  String get moveToNotebookCreateRow => 'புதிய நோட்புக்கை உருவாக்கு';

  @override
  String get notebookActionRename => 'மறுபெயரிடு';

  @override
  String get notebookActionChangeCover => 'அட்டையை மாற்று';

  @override
  String get notebookRenameDialogTitle => 'நோட்புக்கை மறுபெயரிடு';

  @override
  String get notebookCoverPickerTitle => 'அட்டை நிறத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'நோட்புக் அதிலுள்ள அனைத்துக் குறிப்புகளுடன் நீக்கப்படும் (மொத்தம்: $count). இந்தச் செயலைத் திரும்பப் பெற முடியாது.';
  }

  @override
  String get legalAndSupportSectionTitle => 'சட்டத் தகவலும் ஆதரவும்';

  @override
  String get privacyPolicyRow => 'தனியுரிமைக் கொள்கை';

  @override
  String get termsOfServiceRow => 'சேவை விதிமுறைகள்';

  @override
  String get supportRow => 'ஆதரவு';

  @override
  String get openLinkFailedMessage =>
      'இணைப்பைத் திறக்க முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get openSourceLicensesRow => 'திறந்த மூல உரிமங்கள்';

  @override
  String get notificationChannelDescription =>
      'உங்கள் விருப்பத்திற்குரிய தினசரி வசன நினைவூட்டல்';
}
