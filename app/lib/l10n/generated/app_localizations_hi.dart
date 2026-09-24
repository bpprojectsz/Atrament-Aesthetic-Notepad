// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'एट्रामेंट';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get errorGeneric => 'कुछ गड़बड़ हो गई';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get delete => 'हटाएं';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get redo => 'फिर से करें';

  @override
  String get untitledNote => 'शीर्षकहीन';

  @override
  String get deleteConfirmBody => 'यह पूर्ववत नहीं किया जा सकता।';

  @override
  String get deleteNoteTitle => 'क्या इस नोट को हटाना है?';

  @override
  String deleteNotebookTitle(String name) {
    return 'क्या \"$name\" को हटाना है?';
  }

  @override
  String get saveFailedMessage => 'सहेजा नहीं जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get exportFailedMessage =>
      'इस नोट को निर्यात नहीं किया जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get shareFailedMessage =>
      'शेयर मेनू नहीं खुल सका। कृपया पुनः प्रयास करें।';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get searchHint => 'नोट्स खोजें';

  @override
  String get emptyNotebooksTitle => 'अभी तक कोई नोटबुक नहीं';

  @override
  String get emptyNotebooksBody =>
      'लिखना शुरू करने के लिए अपनी पहली नोटबुक बनाएं।';

  @override
  String get emptySearchTitle => 'कोई परिणाम नहीं';

  @override
  String get emptySearchBody => 'कोई भिन्न खोज शब्द आज़माएं।';

  @override
  String get emptyNotebookTitle => 'अभी तक कोई नोट नहीं';

  @override
  String get emptyNotebookBody => 'अपना पहला नोट लिखने के लिए + बटन दबाएं।';

  @override
  String get newNotebookTitle => 'नई नोटबुक';

  @override
  String get notebookNameHint => 'नोटबुक का नाम';

  @override
  String get newNoteTitle => 'नया नोट';

  @override
  String get sortOptionsTitle => 'क्रमबद्ध करें';

  @override
  String get sortByModified => 'अंतिम संपादन';

  @override
  String get sortByCreated => 'निर्माण तिथि';

  @override
  String get sortByTitle => 'शीर्षक';

  @override
  String get formatBold => 'बोल्ड';

  @override
  String get formatItalic => 'इटैलिक';

  @override
  String get formatUnderline => 'रेखांकित';

  @override
  String get formatHeading => 'शीर्षक';

  @override
  String get formatBulletList => 'बुलेट सूची';

  @override
  String get formatChecklist => 'चेकलिस्ट';

  @override
  String get formatQuote => 'उद्धरण';

  @override
  String get formatCodeBlock => 'कोड ब्लॉक';

  @override
  String get penFountainPen => 'फाउंटेन पेन';

  @override
  String get penGelPen => 'जेल पेन';

  @override
  String get penPencil => 'पेंसिल';

  @override
  String get penHighlighter => 'हाइलाइटर';

  @override
  String get penEraser => 'इरेज़र';

  @override
  String get penStrokeWidth => 'स्ट्रोक चौड़ाई';

  @override
  String get toggleHandwritingMode => 'टाइप करने और बनाने के बीच स्विच करें';

  @override
  String get biometricLockReason => 'इस नोट को देखने के लिए अनलॉक करें';

  @override
  String get noteLockedMessage => 'यह नोट लॉक है';

  @override
  String get unlockButton => 'अनलॉक करें';

  @override
  String get exportTitle => 'निर्यात करें';

  @override
  String get exportAsTxt => 'टेक्स्ट के रूप में निर्यात करें';

  @override
  String get exportAsPdf => 'PDF के रूप में निर्यात करें';

  @override
  String get paperStyleSectionTitle => 'पेपर स्टाइल';

  @override
  String get paperStyleLined => 'लाइन वाला';

  @override
  String get paperStyleDotGrid => 'डॉट ग्रिड';

  @override
  String get paperStyleGrid => 'ग्रिड';

  @override
  String get paperStyleBlank => 'खाली';

  @override
  String get paperStyleCream => 'क्रीम';

  @override
  String get paperStyleParchment => 'पार्चमेंट';

  @override
  String get paperStyleVellum => 'वेलम';

  @override
  String get fontSectionTitle => 'नोट फ़ॉन्ट';

  @override
  String get fontSystem => 'सिस्टम';

  @override
  String get fontSerif => 'सेरिफ़';

  @override
  String get themeSectionTitle => 'रूप-रंग';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get themeParchment => 'पार्चमेंट';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get verseSectionTitle => 'दैनिक वचन प्रदर्शन';

  @override
  String get verseModeWatermark => 'वॉटरमार्क';

  @override
  String get verseModeHeader => 'हेडर';

  @override
  String get verseModeFooter => 'फुटर';

  @override
  String get verseModeOff => 'बंद';

  @override
  String get notificationsSectionTitle => 'सूचनाएं';

  @override
  String get dailyReminderToggle => 'दैनिक वचन अनुस्मारक';

  @override
  String get reminderTimeLabel => 'अनुस्मारक समय';

  @override
  String get notificationPermissionDenied =>
      'सिस्टम सेटिंग्स में सूचनाएं बंद हैं।';

  @override
  String get dailyReminderBody => 'आपका दैनिक वचन तैयार है।';

  @override
  String get privacySectionTitle => 'गोपनीयता';

  @override
  String get biometricLockToggle => 'Face ID / फ़िंगरप्रिंट से नोट्स लॉक करें';

  @override
  String get premiumSectionTitle => 'प्रीमियम';

  @override
  String get removeAdsTitle => 'विज्ञापन हटाएं';

  @override
  String get restorePurchasesButton => 'खरीदारी पुनर्स्थापित करें';

  @override
  String get proLabel => 'प्रो';

  @override
  String get engagementSectionTitle => 'अधिक';

  @override
  String get rateAppTitle => 'Atrament को रेट करें';

  @override
  String get rateAppSubtitle => 'ऐप पसंद आ रहा है? समीक्षा छोड़ें';

  @override
  String get shareAppTitle => 'Atrament शेयर करें';

  @override
  String get shareAppSubtitle => 'किसी दोस्त को बताएँ';

  @override
  String get shareAppMessage =>
      'Atrament आज़माएँ — कागज़ की बनावट वाला बिना ध्यान-भंग नोटपैड।';

  @override
  String get languageSectionTitle => 'भाषा';

  @override
  String get languageFollowsSystem =>
      'आपके डिवाइस की भाषा सेटिंग का अनुसरण करता है';

  @override
  String get languageSystem => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get languagePickerTitle => 'भाषा चुनें';

  @override
  String get premiumScreenTitle => 'विज्ञापन हटाएं';

  @override
  String get premiumHeadline => 'बिना ध्यान भटकाए लिखें';

  @override
  String get premiumBody =>
      'Atrament एक छोटे बैनर विज्ञापन के साथ मुफ़्त है। इसे हटाना एक बार की खरीद है जो और कुछ अनलॉक नहीं करती — हर सुविधा पहले से आपकी है।';

  @override
  String get premiumRestoreButton => 'खरीदारी पुनर्स्थापित करें';

  @override
  String get premiumAlreadyProMessage =>
      'आपके पास पहले से ही विज्ञापन हटाएं सुविधा है। धन्यवाद!';

  @override
  String get supportSectionTitle => 'सहायता';

  @override
  String get shareDebugLogButton => 'डीबग लॉग साझा करें';

  @override
  String get shareDebugLogSubtitle =>
      'अगर कुछ काम नहीं कर रहा है तो तकनीकी रिपोर्ट भेजें';

  @override
  String get noDebugLogMessage => 'अभी तक रिपोर्ट करने के लिए कुछ नहीं है।';

  @override
  String get clearDebugLogButton => 'डीबग लॉग साफ़ करें';

  @override
  String get clearDebugLogTitle => 'क्या डीबग लॉग साफ़ करना है?';

  @override
  String get clearDebugLogBody =>
      'इससे आपके डिवाइस से सहेजी गई तकनीकी रिपोर्ट हट जाएगी।';

  @override
  String get debugLogClearedMessage => 'डीबग लॉग साफ़ कर दिया गया।';

  @override
  String get premiumUnlockLabel => 'विज्ञापन हमेशा के लिए हटाएँ';

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
}
