// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get errorGeneric => 'کچھ غلط ہو گیا';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get undo => 'کالعدم کریں';

  @override
  String get redo => 'دوبارہ کریں';

  @override
  String get untitledNote => 'بغیر عنوان';

  @override
  String get deleteConfirmBody => 'اس عمل کو واپس نہیں کیا جا سکتا۔';

  @override
  String get deleteNoteTitle => 'یہ نوٹ حذف کریں؟';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” حذف کریں؟';
  }

  @override
  String get saveFailedMessage =>
      'محفوظ نہیں کیا جا سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get exportFailedMessage =>
      'یہ نوٹ ایکسپورٹ نہیں کیا جا سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get shareFailedMessage =>
      'شیئر مینو نہیں کھل سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get searchHint => 'نوٹ تلاش کریں';

  @override
  String get emptyNotebooksTitle => 'ابھی کوئی نوٹ بک نہیں ہے';

  @override
  String get emptyNotebooksBody =>
      'لکھنا شروع کرنے کے لیے اپنی پہلی نوٹ بک بنائیں۔';

  @override
  String get emptySearchTitle => 'کوئی نتیجہ نہیں';

  @override
  String get emptySearchBody => 'کوئی اور تلاش کا لفظ آزمائیں۔';

  @override
  String get emptyNotebookTitle => 'ابھی کوئی نوٹ نہیں ہے';

  @override
  String get emptyNotebookBody => 'اپنا پہلا نوٹ لکھنے کے لیے + پر ٹیپ کریں۔';

  @override
  String get newNotebookTitle => 'نئی نوٹ بک';

  @override
  String get notebookNameHint => 'نوٹ بک کا نام';

  @override
  String get newNoteTitle => 'نیا نوٹ';

  @override
  String get sortOptionsTitle => 'ترتیب دیں';

  @override
  String get sortByModified => 'آخری ترمیم';

  @override
  String get sortByCreated => 'تخلیق کی تاریخ';

  @override
  String get sortByTitle => 'عنوان';

  @override
  String get formatBold => 'جلی';

  @override
  String get formatItalic => 'ترچھا';

  @override
  String get formatUnderline => 'خط کشیدہ';

  @override
  String get formatHeading => 'سرخی';

  @override
  String get formatBulletList => 'نشان زد فہرست';

  @override
  String get formatChecklist => 'چیک لسٹ';

  @override
  String get formatQuote => 'اقتباس';

  @override
  String get formatCodeBlock => 'کوڈ بلاک';

  @override
  String get penFountainPen => 'فاؤنٹین پین';

  @override
  String get penGelPen => 'جیل پین';

  @override
  String get penPencil => 'پنسل';

  @override
  String get penHighlighter => 'ہائی لائٹر';

  @override
  String get penEraser => 'ربڑ';

  @override
  String get penStrokeWidth => 'لکیر کی موٹائی';

  @override
  String get toggleHandwritingMode => 'ٹائپنگ اور ڈرائنگ کے درمیان تبدیل کریں';

  @override
  String get biometricLockReason => 'نوٹ دیکھنے کے لیے ان لاک کریں';

  @override
  String get noteLockedMessage => 'یہ نوٹ مقفل ہے';

  @override
  String get unlockButton => 'ان لاک کریں';

  @override
  String get noteLockTurnedOffMessage =>
      'نوٹ لاک بند کر دیا گیا ہے کیونکہ اس آلے پر اسکرین لاک یا بایومیٹرک سیٹ نہیں ہے۔';

  @override
  String get biometricEnableReason =>
      'نوٹ لاک آن کرنے کے لیے اپنی شناخت کی تصدیق کریں';

  @override
  String get biometricDisableReason =>
      'نوٹ لاک بند کرنے کے لیے اپنی شناخت کی تصدیق کریں';

  @override
  String get biometricShareReason =>
      'یہ نوٹ شیئر یا ایکسپورٹ کرنے کے لیے ان لاک کریں';

  @override
  String get biometricAuthFailedMessage => 'آپ کی شناخت کی تصدیق نہیں ہو سکی۔';

  @override
  String get biometricSetupNeededMessage =>
      'پہلے آلے کی ترتیبات میں اسکرین لاک یا فنگر پرنٹ سیٹ کریں۔';

  @override
  String get privacyChoicesTitle => 'رازداری کے اختیارات';

  @override
  String get purchaseFailedMessage =>
      'خریداری مکمل نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get restoreSuccessMessage => 'آپ کی خریداری بحال کر دی گئی ہے۔';

  @override
  String get restoreNothingFoundMessage =>
      'اس اکاؤنٹ کے لیے کوئی سابقہ خریداری نہیں ملی۔';

  @override
  String get restoreFailedMessage =>
      'خریداریاں بحال نہیں ہو سکیں۔ اپنا کنکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get reminderScheduleFailedMessage =>
      'یاد دہانی شیڈول نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get storageIssueNotebooksLoad =>
      'کچھ نوٹ بکس لوڈ نہیں ہو سکیں۔ جو دستیاب ہے وہ دکھایا جا رہا ہے۔';

  @override
  String get storageIssueNotebookSave =>
      'ہو سکتا ہے یہ نوٹ بک محفوظ نہ ہوئی ہو۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get storageIssueNotebookChange =>
      'ہو سکتا ہے یہ تبدیلی محفوظ نہ ہوئی ہو۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get storageIssueNotebookDelete =>
      'نوٹ بک حذف نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get storageIssueNotebookOrder =>
      'ہو سکتا ہے نئی ترتیب محفوظ نہ ہوئی ہو۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get storageIssueNotesLoad =>
      'کچھ نوٹ لوڈ نہیں ہو سکے۔ جو دستیاب ہے وہ دکھایا جا رہا ہے۔';

  @override
  String get storageIssueSearch => 'اس وقت تلاش کے نتائج نامکمل ہو سکتے ہیں۔';

  @override
  String get storageIssueNoteSave =>
      'ہو سکتا ہے یہ نوٹ محفوظ نہ ہوا ہو۔ اپنے آلے کی اسٹوریج چیک کریں۔';

  @override
  String get storageIssueNoteDelete =>
      'نوٹ حذف نہیں ہو سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get purchaseUnavailableMessage =>
      'یہ خریداری اس وقت دستیاب نہیں ہے۔ براہ کرم بعد میں دوبارہ کوشش کریں۔';

  @override
  String get exportTitle => 'ایکسپورٹ کریں';

  @override
  String get exportAsTxt => 'متن کے طور پر ایکسپورٹ کریں';

  @override
  String get exportAsPdf => 'PDF کے طور پر ایکسپورٹ کریں';

  @override
  String get paperStyleSectionTitle => 'کاغذ کا انداز';

  @override
  String get paperStyleLined => 'لکیر دار';

  @override
  String get paperStyleDotGrid => 'نقطہ دار';

  @override
  String get paperStyleGrid => 'گرڈ';

  @override
  String get paperStyleBlank => 'خالی';

  @override
  String get paperStyleCream => 'کریم';

  @override
  String get paperStyleParchment => 'پارچمنٹ';

  @override
  String get paperStyleVellum => 'ویلم';

  @override
  String get fontSectionTitle => 'نوٹ کا فونٹ';

  @override
  String get fontSystem => 'سسٹم';

  @override
  String get fontSerif => 'سیرف';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'ظاہری شکل';

  @override
  String get themeLight => 'ہلکا';

  @override
  String get themeDark => 'گہرا';

  @override
  String get themeParchment => 'پارچمنٹ';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get verseSectionTitle => 'آج کی بائبل آیت کی نمائش';

  @override
  String get verseModeWatermark => 'واٹر مارک';

  @override
  String get verseModeHeader => 'ہیڈر';

  @override
  String get verseModeFooter => 'فوٹر';

  @override
  String get verseModeOff => 'بند';

  @override
  String get notificationsSectionTitle => 'اطلاعات';

  @override
  String get dailyReminderToggle => 'روزانہ بائبل آیت کی یاد دہانی';

  @override
  String get reminderTimeLabel => 'یاد دہانی کا وقت';

  @override
  String get notificationPermissionDenied =>
      'سسٹم کی ترتیبات میں اطلاعات بند ہیں۔';

  @override
  String get dailyReminderBody => 'آپ کی آج کی بائبل آیت تیار ہے۔';

  @override
  String get privacySectionTitle => 'رازداری';

  @override
  String get biometricLockToggle => 'Face ID / فنگر پرنٹ سے نوٹ لاک کریں';

  @override
  String get premiumSectionTitle => 'پریمیم';

  @override
  String get removeAdsTitle => 'اشتہارات ہٹائیں';

  @override
  String get restorePurchasesButton => 'خریداریاں بحال کریں';

  @override
  String get proLabel => 'پرو';

  @override
  String get engagementSectionTitle => 'مزید';

  @override
  String get rateAppTitle => 'Atrament کو ریٹنگ دیں';

  @override
  String get rateAppSubtitle => 'ایپ پسند آئی؟ ایک جائزہ لکھیں';

  @override
  String get shareAppTitle => 'Atrament شیئر کریں';

  @override
  String get shareAppSubtitle => 'کسی دوست کو بتائیں';

  @override
  String get shareAppMessage =>
      'Atrament آزمائیں — کاغذی ساخت کے ساتھ خلل سے پاک نوٹ پیڈ۔';

  @override
  String get languageSectionTitle => 'زبان';

  @override
  String get languageFollowsSystem => 'آلے کی زبان کی ترتیب کی پیروی کرتا ہے';

  @override
  String get languageSystem => 'سسٹم ڈیفالٹ';

  @override
  String get languagePickerTitle => 'زبان منتخب کریں';

  @override
  String get premiumScreenTitle => 'اشتہارات ہٹائیں';

  @override
  String get premiumHeadline => 'خلل کے بغیر لکھیں';

  @override
  String get premiumBody =>
      'Atrament مفت ہے اور صرف ایک چھوٹا اشتہاری بینر دکھاتا ہے۔ اشتہارات ہٹانا ایک بار کی خریداری ہے جو کچھ اور ان لاک نہیں کرتی — تمام فیچرز پہلے ہی آپ کے ہیں۔';

  @override
  String get premiumRestoreButton => 'خریداریاں بحال کریں';

  @override
  String get premiumAlreadyProMessage =>
      'آپ کے پاس پہلے سے “اشتہارات ہٹائیں” موجود ہے۔ شکریہ!';

  @override
  String get supportSectionTitle => 'معاونت';

  @override
  String get shareDebugLogButton => 'ڈیبگ لاگ شیئر کریں';

  @override
  String get shareDebugLogSubtitle =>
      'اگر کچھ کام نہ کر رہا ہو تو تکنیکی رپورٹ بھیجیں';

  @override
  String get noDebugLogMessage => 'ابھی رپورٹ کرنے کے لیے کچھ نہیں ہے۔';

  @override
  String get clearDebugLogButton => 'ڈیبگ لاگ صاف کریں';

  @override
  String get clearDebugLogTitle => 'ڈیبگ لاگ صاف کریں؟';

  @override
  String get clearDebugLogBody =>
      'محفوظ شدہ تکنیکی رپورٹ آپ کے آلے سے ہٹا دی جائے گی۔';

  @override
  String get debugLogClearedMessage => 'ڈیبگ لاگ صاف کر دیا گیا۔';

  @override
  String get premiumUnlockLabel => 'اشتہارات ہمیشہ کے لیے ہٹائیں';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'سب';

  @override
  String get chipNotebooks => 'نوٹ بکس';

  @override
  String get chipRecent => 'حالیہ';

  @override
  String get emptyAllNotesTitle => 'ابھی کوئی نوٹ نہیں ہے';

  @override
  String get emptyAllNotesBody => 'اپنا پہلا نوٹ لکھنے کے لیے + پر ٹیپ کریں۔';

  @override
  String get emptyRecentNotesTitle => 'کچھ حالیہ نہیں';

  @override
  String get emptyRecentNotesBody =>
      'آپ جو نوٹ ایڈٹ کریں گے وہ یہاں نظر آئیں گے۔';

  @override
  String get noteActionRename => 'نام تبدیل کریں';

  @override
  String get noteActionMoveToNotebook => 'نوٹ بک میں منتقل کریں';

  @override
  String get noteActionEdit => 'ترمیم کریں';

  @override
  String get noteActionExport => 'ایکسپورٹ کریں';

  @override
  String get noteActionShare => 'شیئر کریں';

  @override
  String get moveToNotebookTitle => 'نوٹ بک میں منتقل کریں';

  @override
  String get moveToNotebookEmptyBody =>
      'ابھی کوئی دوسری نوٹ بک نہیں ہے۔ اس نوٹ کو ترتیب دینے کے لیے ایک بنائیں۔';

  @override
  String get moveToNotebookCreateRow => 'نئی نوٹ بک بنائیں';

  @override
  String get notebookActionRename => 'نام تبدیل کریں';

  @override
  String get notebookActionChangeCover => 'کور تبدیل کریں';

  @override
  String get notebookRenameDialogTitle => 'نوٹ بک کا نام تبدیل کریں';

  @override
  String get notebookCoverPickerTitle => 'کور کا رنگ منتخب کریں';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'نوٹ بک اپنے تمام نوٹ سمیت حذف ہو جائے گی (کل: $count)۔ اس عمل کو واپس نہیں کیا جا سکتا۔';
  }

  @override
  String get legalAndSupportSectionTitle => 'قانونی معلومات اور معاونت';

  @override
  String get privacyPolicyRow => 'رازداری کی پالیسی';

  @override
  String get termsOfServiceRow => 'سروس کی شرائط';

  @override
  String get supportRow => 'معاونت';

  @override
  String get openLinkFailedMessage =>
      'لنک نہیں کھل سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get openSourceLicensesRow => 'اوپن سورس لائسنسز';

  @override
  String get notificationChannelDescription =>
      'آپ کی اختیاری روزانہ بائبل آیت کی یاد دہانی';
}
