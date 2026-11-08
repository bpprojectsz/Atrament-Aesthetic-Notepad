// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get errorGeneric => 'काहीतरी चुकले';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get save => 'जतन करा';

  @override
  String get delete => 'हटवा';

  @override
  String get undo => 'पूर्ववत करा';

  @override
  String get redo => 'पुन्हा करा';

  @override
  String get untitledNote => 'शीर्षकहीन';

  @override
  String get deleteConfirmBody => 'ही क्रिया पूर्ववत करता येणार नाही.';

  @override
  String get deleteNoteTitle => 'ही नोट हटवायची?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” हटवायचे?';
  }

  @override
  String get saveFailedMessage =>
      'जतन करता आले नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get exportFailedMessage =>
      'ही नोट निर्यात करता आली नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get shareFailedMessage =>
      'शेअर मेनू उघडता आला नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get searchHint => 'नोट्समध्ये शोधा';

  @override
  String get emptyNotebooksTitle => 'अजून नोटबुक नाहीत';

  @override
  String get emptyNotebooksBody =>
      'लिहिण्यास सुरुवात करण्यासाठी तुमचे पहिले नोटबुक तयार करा.';

  @override
  String get emptySearchTitle => 'निकाल नाहीत';

  @override
  String get emptySearchBody => 'दुसरा शोध शब्द वापरून पहा.';

  @override
  String get emptyNotebookTitle => 'अजून नोट्स नाहीत';

  @override
  String get emptyNotebookBody => 'तुमची पहिली नोट लिहिण्यासाठी + वर टॅप करा.';

  @override
  String get newNotebookTitle => 'नवीन नोटबुक';

  @override
  String get notebookNameHint => 'नोटबुकचे नाव';

  @override
  String get newNoteTitle => 'नवीन नोट';

  @override
  String get sortOptionsTitle => 'क्रमवारी लावा';

  @override
  String get sortByModified => 'शेवटचे संपादित';

  @override
  String get sortByCreated => 'तयार केल्याची तारीख';

  @override
  String get sortByTitle => 'शीर्षक';

  @override
  String get formatBold => 'ठळक';

  @override
  String get formatItalic => 'तिरपे';

  @override
  String get formatUnderline => 'अधोरेखित';

  @override
  String get formatHeading => 'मथळा';

  @override
  String get formatBulletList => 'बुलेट यादी';

  @override
  String get formatChecklist => 'चेकलिस्ट';

  @override
  String get formatQuote => 'अवतरण';

  @override
  String get formatCodeBlock => 'कोड ब्लॉक';

  @override
  String get penFountainPen => 'फाउंटन पेन';

  @override
  String get penGelPen => 'जेल पेन';

  @override
  String get penPencil => 'पेन्सिल';

  @override
  String get penHighlighter => 'हायलायटर';

  @override
  String get penEraser => 'खोडरबर';

  @override
  String get penStrokeWidth => 'रेषेची जाडी';

  @override
  String get toggleHandwritingMode => 'टायपिंग आणि रेखाटन यांच्यात बदला';

  @override
  String get biometricLockReason => 'नोट पाहण्यासाठी अनलॉक करा';

  @override
  String get noteLockedMessage => 'ही नोट लॉक केलेली आहे';

  @override
  String get unlockButton => 'अनलॉक करा';

  @override
  String get noteLockTurnedOffMessage =>
      'या डिव्हाइसवर स्क्रीन लॉक किंवा बायोमेट्रिक सेट केलेले नसल्याने नोट लॉक बंद केले आहे.';

  @override
  String get biometricEnableReason =>
      'नोट लॉक चालू करण्यासाठी तुमची ओळख निश्चित करा';

  @override
  String get biometricDisableReason =>
      'नोट लॉक बंद करण्यासाठी तुमची ओळख निश्चित करा';

  @override
  String get biometricShareReason =>
      'ही नोट शेअर किंवा निर्यात करण्यासाठी अनलॉक करा';

  @override
  String get biometricAuthFailedMessage => 'तुमची ओळख पडताळता आली नाही.';

  @override
  String get biometricSetupNeededMessage =>
      'आधी डिव्हाइस सेटिंग्जमध्ये स्क्रीन लॉक किंवा फिंगरप्रिंट सेट करा.';

  @override
  String get privacyChoicesTitle => 'गोपनीयता पर्याय';

  @override
  String get purchaseFailedMessage =>
      'खरेदी पूर्ण करता आली नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get restoreSuccessMessage => 'तुमची खरेदी पुनर्संचयित केली.';

  @override
  String get restoreNothingFoundMessage =>
      'या खात्यासाठी मागील खरेदी आढळली नाही.';

  @override
  String get restoreFailedMessage =>
      'खरेदी पुनर्संचयित करता आल्या नाहीत. तुमचे कनेक्शन तपासा आणि पुन्हा प्रयत्न करा.';

  @override
  String get reminderScheduleFailedMessage =>
      'स्मरणपत्र शेड्यूल करता आले नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get storageIssueNotebooksLoad =>
      'काही नोटबुक लोड करता आली नाहीत. उपलब्ध ते दाखवले जात आहे.';

  @override
  String get storageIssueNotebookSave =>
      'हे नोटबुक कदाचित जतन झाले नसेल. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get storageIssueNotebookChange =>
      'हा बदल कदाचित जतन झाला नसेल. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get storageIssueNotebookDelete =>
      'नोटबुक हटवता आले नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get storageIssueNotebookOrder =>
      'नवीन क्रम कदाचित जतन झाला नसेल. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get storageIssueNotesLoad =>
      'काही नोट्स लोड करता आल्या नाहीत. उपलब्ध ते दाखवले जात आहे.';

  @override
  String get storageIssueSearch => 'सध्या शोध निकाल अपूर्ण असू शकतात.';

  @override
  String get storageIssueNoteSave =>
      'ही नोट कदाचित जतन झाली नसेल. तुमच्या डिव्हाइसची स्टोरेज तपासा.';

  @override
  String get storageIssueNoteDelete =>
      'नोट हटवता आली नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get purchaseUnavailableMessage =>
      'ही खरेदी सध्या उपलब्ध नाही. कृपया नंतर पुन्हा प्रयत्न करा.';

  @override
  String get exportTitle => 'निर्यात करा';

  @override
  String get exportAsTxt => 'मजकूर म्हणून निर्यात करा';

  @override
  String get exportAsPdf => 'PDF म्हणून निर्यात करा';

  @override
  String get paperStyleSectionTitle => 'कागदाची शैली';

  @override
  String get paperStyleLined => 'रेषा असलेला';

  @override
  String get paperStyleDotGrid => 'ठिपके असलेला';

  @override
  String get paperStyleGrid => 'चौकटींचा';

  @override
  String get paperStyleBlank => 'कोरा';

  @override
  String get paperStyleCream => 'क्रीम';

  @override
  String get paperStyleParchment => 'पार्चमेंट';

  @override
  String get paperStyleVellum => 'वेलम';

  @override
  String get fontSectionTitle => 'नोटचा फॉन्ट';

  @override
  String get fontSystem => 'सिस्टीम';

  @override
  String get fontSerif => 'सेरिफ';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'स्वरूप';

  @override
  String get themeLight => 'फिकट';

  @override
  String get themeDark => 'गडद';

  @override
  String get themeParchment => 'पार्चमेंट';

  @override
  String get themeSystem => 'सिस्टीम';

  @override
  String get verseSectionTitle => 'आजच्या बायबल वचनाचे प्रदर्शन';

  @override
  String get verseModeWatermark => 'वॉटरमार्क';

  @override
  String get verseModeHeader => 'हेडर';

  @override
  String get verseModeFooter => 'फूटर';

  @override
  String get verseModeOff => 'बंद';

  @override
  String get notificationsSectionTitle => 'सूचना';

  @override
  String get dailyReminderToggle => 'दैनिक बायबल वचन स्मरणपत्र';

  @override
  String get reminderTimeLabel => 'स्मरणपत्राची वेळ';

  @override
  String get notificationPermissionDenied =>
      'सिस्टीम सेटिंग्जमध्ये सूचना बंद आहेत.';

  @override
  String get dailyReminderBody => 'तुमचे आजचे बायबल वचन तयार आहे.';

  @override
  String get privacySectionTitle => 'गोपनीयता';

  @override
  String get biometricLockToggle => 'Face ID / फिंगरप्रिंटने नोट्स लॉक करा';

  @override
  String get premiumSectionTitle => 'प्रीमियम';

  @override
  String get removeAdsTitle => 'जाहिराती काढा';

  @override
  String get restorePurchasesButton => 'खरेदी पुनर्संचयित करा';

  @override
  String get proLabel => 'प्रो';

  @override
  String get engagementSectionTitle => 'अधिक';

  @override
  String get rateAppTitle => 'Atrament ला रेटिंग द्या';

  @override
  String get rateAppSubtitle => 'अ‍ॅप आवडले का? एक पुनरावलोकन लिहा';

  @override
  String get shareAppTitle => 'Atrament शेअर करा';

  @override
  String get shareAppSubtitle => 'मित्राला सांगा';

  @override
  String get shareAppMessage =>
      'Atrament वापरून पहा — कागदाच्या पोताचे, अडथळे नसलेले नोटपॅड.';

  @override
  String get languageSectionTitle => 'भाषा';

  @override
  String get languageFollowsSystem => 'डिव्हाइसच्या भाषा सेटिंगनुसार';

  @override
  String get languageSystem => 'सिस्टीम डिफॉल्ट';

  @override
  String get languagePickerTitle => 'भाषा निवडा';

  @override
  String get premiumScreenTitle => 'जाहिराती काढा';

  @override
  String get premiumHeadline => 'अडथळ्यांशिवाय लिहा';

  @override
  String get premiumBody =>
      'Atrament विनामूल्य आहे आणि फक्त एक लहान जाहिरात बॅनर दाखवते. जाहिराती काढणे ही एकदाची खरेदी आहे जी दुसरे काहीही अनलॉक करत नाही — सर्व वैशिष्ट्ये आधीच तुमची आहेत.';

  @override
  String get premiumRestoreButton => 'खरेदी पुनर्संचयित करा';

  @override
  String get premiumAlreadyProMessage =>
      'तुमच्याकडे आधीच “जाहिराती काढा” आहे. धन्यवाद!';

  @override
  String get supportSectionTitle => 'सहाय्य';

  @override
  String get shareDebugLogButton => 'डीबग लॉग शेअर करा';

  @override
  String get shareDebugLogSubtitle =>
      'काही काम करत नसल्यास तांत्रिक अहवाल पाठवा';

  @override
  String get noDebugLogMessage => 'अजून नोंदवण्यासारखे काही नाही.';

  @override
  String get clearDebugLogButton => 'डीबग लॉग साफ करा';

  @override
  String get clearDebugLogTitle => 'डीबग लॉग साफ करायचा?';

  @override
  String get clearDebugLogBody =>
      'जतन केलेला तांत्रिक अहवाल तुमच्या डिव्हाइसवरून काढला जाईल.';

  @override
  String get debugLogClearedMessage => 'डीबग लॉग साफ केला.';

  @override
  String get premiumUnlockLabel => 'जाहिराती कायमच्या काढा';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'सर्व';

  @override
  String get chipNotebooks => 'नोटबुक';

  @override
  String get chipRecent => 'अलीकडील';

  @override
  String get emptyAllNotesTitle => 'अजून नोट्स नाहीत';

  @override
  String get emptyAllNotesBody => 'तुमची पहिली नोट लिहिण्यासाठी + वर टॅप करा.';

  @override
  String get emptyRecentNotesTitle => 'अलीकडचे काही नाही';

  @override
  String get emptyRecentNotesBody =>
      'तुम्ही संपादित केलेल्या नोट्स येथे दिसतील.';

  @override
  String get noteActionRename => 'नाव बदला';

  @override
  String get noteActionMoveToNotebook => 'नोटबुकमध्ये हलवा';

  @override
  String get noteActionEdit => 'संपादित करा';

  @override
  String get noteActionExport => 'निर्यात करा';

  @override
  String get noteActionShare => 'शेअर करा';

  @override
  String get moveToNotebookTitle => 'नोटबुकमध्ये हलवा';

  @override
  String get moveToNotebookEmptyBody =>
      'अजून इतर नोटबुक नाहीत. ही नोट व्यवस्थित ठेवण्यासाठी एक तयार करा.';

  @override
  String get moveToNotebookCreateRow => 'नवीन नोटबुक तयार करा';

  @override
  String get notebookActionRename => 'नाव बदला';

  @override
  String get notebookActionChangeCover => 'मुखपृष्ठ बदला';

  @override
  String get notebookRenameDialogTitle => 'नोटबुकचे नाव बदला';

  @override
  String get notebookCoverPickerTitle => 'मुखपृष्ठाचा रंग निवडा';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'नोटबुक त्यातील सर्व नोट्ससह हटवले जाईल (एकूण: $count). ही क्रिया पूर्ववत करता येणार नाही.';
  }

  @override
  String get legalAndSupportSectionTitle => 'कायदेशीर माहिती आणि सहाय्य';

  @override
  String get privacyPolicyRow => 'गोपनीयता धोरण';

  @override
  String get termsOfServiceRow => 'सेवा अटी';

  @override
  String get supportRow => 'सहाय्य';

  @override
  String get openLinkFailedMessage =>
      'दुवा उघडता आला नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get openSourceLicensesRow => 'ओपन सोर्स परवाने';

  @override
  String get notificationChannelDescription =>
      'तुमचे ऐच्छिक दैनिक बायबल वचन स्मरणपत्र';
}
