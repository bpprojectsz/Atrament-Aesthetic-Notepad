// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get errorGeneric => 'কিছু ভুল হয়েছে';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get undo => 'পূর্বাবস্থায় ফেরান';

  @override
  String get redo => 'আবার করুন';

  @override
  String get untitledNote => 'শিরোনামহীন';

  @override
  String get deleteConfirmBody => 'এই কাজটি আর ফেরানো যাবে না।';

  @override
  String get deleteNoteTitle => 'এই নোটটি মুছবেন?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” মুছবেন?';
  }

  @override
  String get saveFailedMessage =>
      'সংরক্ষণ করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get exportFailedMessage =>
      'এই নোটটি এক্সপোর্ট করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get shareFailedMessage =>
      'শেয়ার মেনু খোলা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get searchHint => 'নোট খুঁজুন';

  @override
  String get emptyNotebooksTitle => 'এখনো কোনো নোটবুক নেই';

  @override
  String get emptyNotebooksBody =>
      'লেখা শুরু করতে আপনার প্রথম নোটবুক তৈরি করুন।';

  @override
  String get emptySearchTitle => 'কোনো ফলাফল নেই';

  @override
  String get emptySearchBody => 'অন্য কোনো শব্দ দিয়ে খুঁজে দেখুন।';

  @override
  String get emptyNotebookTitle => 'এখনো কোনো নোট নেই';

  @override
  String get emptyNotebookBody => 'আপনার প্রথম নোট লিখতে + ট্যাপ করুন।';

  @override
  String get newNotebookTitle => 'নতুন নোটবুক';

  @override
  String get notebookNameHint => 'নোটবুকের নাম';

  @override
  String get newNoteTitle => 'নতুন নোট';

  @override
  String get sortOptionsTitle => 'সাজান';

  @override
  String get sortByModified => 'সর্বশেষ সম্পাদিত';

  @override
  String get sortByCreated => 'তৈরির তারিখ';

  @override
  String get sortByTitle => 'শিরোনাম';

  @override
  String get formatBold => 'বোল্ড';

  @override
  String get formatItalic => 'ইটালিক';

  @override
  String get formatUnderline => 'আন্ডারলাইন';

  @override
  String get formatHeading => 'হেডিং';

  @override
  String get formatBulletList => 'বুলেট তালিকা';

  @override
  String get formatChecklist => 'চেকলিস্ট';

  @override
  String get formatQuote => 'উদ্ধৃতি';

  @override
  String get formatCodeBlock => 'কোড ব্লক';

  @override
  String get penFountainPen => 'ফাউন্টেন পেন';

  @override
  String get penGelPen => 'জেল পেন';

  @override
  String get penPencil => 'পেন্সিল';

  @override
  String get penHighlighter => 'হাইলাইটার';

  @override
  String get penEraser => 'ইরেজার';

  @override
  String get penStrokeWidth => 'রেখার পুরুত্ব';

  @override
  String get toggleHandwritingMode => 'টাইপ করা ও আঁকার মধ্যে পরিবর্তন করুন';

  @override
  String get biometricLockReason => 'নোটটি দেখতে আনলক করুন';

  @override
  String get noteLockedMessage => 'এই নোটটি লক করা আছে';

  @override
  String get unlockButton => 'আনলক করুন';

  @override
  String get noteLockTurnedOffMessage =>
      'নোট লক বন্ধ করা হয়েছে, কারণ এই ডিভাইসে স্ক্রিন লক বা বায়োমেট্রিক সেট করা নেই।';

  @override
  String get biometricEnableReason =>
      'নোট লক চালু করতে আপনার পরিচয় নিশ্চিত করুন';

  @override
  String get biometricDisableReason =>
      'নোট লক বন্ধ করতে আপনার পরিচয় নিশ্চিত করুন';

  @override
  String get biometricShareReason =>
      'এই নোটটি শেয়ার বা এক্সপোর্ট করতে আনলক করুন';

  @override
  String get biometricAuthFailedMessage => 'আপনার পরিচয় যাচাই করা যায়নি।';

  @override
  String get biometricSetupNeededMessage =>
      'প্রথমে ডিভাইসের সেটিংসে স্ক্রিন লক বা ফিঙ্গারপ্রিন্ট সেট করুন।';

  @override
  String get privacyChoicesTitle => 'গোপনীয়তার বিকল্প';

  @override
  String get purchaseFailedMessage =>
      'কেনাকাটা সম্পূর্ণ করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get restoreSuccessMessage => 'আপনার কেনাকাটা পুনরুদ্ধার করা হয়েছে।';

  @override
  String get restoreNothingFoundMessage =>
      'এই অ্যাকাউন্টের জন্য আগের কোনো কেনাকাটা পাওয়া যায়নি।';

  @override
  String get restoreFailedMessage =>
      'কেনাকাটা পুনরুদ্ধার করা যায়নি। আপনার সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।';

  @override
  String get reminderScheduleFailedMessage =>
      'রিমাইন্ডার শিডিউল করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get storageIssueNotebooksLoad =>
      'কিছু নোটবুক লোড করা যায়নি। যা পাওয়া গেছে তা দেখানো হচ্ছে।';

  @override
  String get storageIssueNotebookSave =>
      'এই নোটবুক হয়তো সংরক্ষিত হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get storageIssueNotebookChange =>
      'এই পরিবর্তন হয়তো সংরক্ষিত হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get storageIssueNotebookDelete =>
      'নোটবুক মোছা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get storageIssueNotebookOrder =>
      'নতুন ক্রম হয়তো সংরক্ষিত হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get storageIssueNotesLoad =>
      'কিছু নোট লোড করা যায়নি। যা পাওয়া গেছে তা দেখানো হচ্ছে।';

  @override
  String get storageIssueSearch =>
      'এই মুহূর্তে অনুসন্ধানের ফলাফল অসম্পূর্ণ হতে পারে।';

  @override
  String get storageIssueNoteSave =>
      'এই নোট হয়তো সংরক্ষিত হয়নি। আপনার ডিভাইসের স্টোরেজ পরীক্ষা করুন।';

  @override
  String get storageIssueNoteDelete =>
      'নোট মোছা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get purchaseUnavailableMessage =>
      'এই কেনাকাটা এখন উপলব্ধ নয়। অনুগ্রহ করে পরে আবার চেষ্টা করুন।';

  @override
  String get exportTitle => 'এক্সপোর্ট';

  @override
  String get exportAsTxt => 'টেক্সট হিসেবে এক্সপোর্ট করুন';

  @override
  String get exportAsPdf => 'PDF হিসেবে এক্সপোর্ট করুন';

  @override
  String get paperStyleSectionTitle => 'কাগজের ধরন';

  @override
  String get paperStyleLined => 'রুলটানা';

  @override
  String get paperStyleDotGrid => 'বিন্দুযুক্ত';

  @override
  String get paperStyleGrid => 'গ্রিড';

  @override
  String get paperStyleBlank => 'ফাঁকা';

  @override
  String get paperStyleCream => 'ক্রিম';

  @override
  String get paperStyleParchment => 'পার্চমেন্ট';

  @override
  String get paperStyleVellum => 'ভেলাম';

  @override
  String get fontSectionTitle => 'নোটের ফন্ট';

  @override
  String get fontSystem => 'সিস্টেম';

  @override
  String get fontSerif => 'সেরিফ';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'চেহারা';

  @override
  String get themeLight => 'হালকা';

  @override
  String get themeDark => 'গাঢ়';

  @override
  String get themeParchment => 'পার্চমেন্ট';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get verseSectionTitle => 'আজকের বাইবেলের পদ প্রদর্শন';

  @override
  String get verseModeWatermark => 'ওয়াটারমার্ক';

  @override
  String get verseModeHeader => 'হেডার';

  @override
  String get verseModeFooter => 'ফুটার';

  @override
  String get verseModeOff => 'বন্ধ';

  @override
  String get notificationsSectionTitle => 'বিজ্ঞপ্তি';

  @override
  String get dailyReminderToggle => 'প্রতিদিনের বাইবেলের পদের রিমাইন্ডার';

  @override
  String get reminderTimeLabel => 'রিমাইন্ডারের সময়';

  @override
  String get notificationPermissionDenied =>
      'সিস্টেম সেটিংসে বিজ্ঞপ্তি বন্ধ করা আছে।';

  @override
  String get dailyReminderBody => 'আপনার আজকের বাইবেলের পদ প্রস্তুত।';

  @override
  String get privacySectionTitle => 'গোপনীয়তা';

  @override
  String get biometricLockToggle =>
      'Face ID / ফিঙ্গারপ্রিন্ট দিয়ে নোট লক করুন';

  @override
  String get premiumSectionTitle => 'প্রিমিয়াম';

  @override
  String get removeAdsTitle => 'বিজ্ঞাপন সরান';

  @override
  String get restorePurchasesButton => 'কেনাকাটা পুনরুদ্ধার করুন';

  @override
  String get proLabel => 'প্রো';

  @override
  String get engagementSectionTitle => 'আরও';

  @override
  String get rateAppTitle => 'Atrament-কে রেটিং দিন';

  @override
  String get rateAppSubtitle => 'অ্যাপটি ভালো লাগছে? একটি রিভিউ দিন';

  @override
  String get shareAppTitle => 'Atrament শেয়ার করুন';

  @override
  String get shareAppSubtitle => 'কোনো বন্ধুকে জানান';

  @override
  String get shareAppMessage =>
      'Atrament ব্যবহার করে দেখুন—কাগজের টেক্সচারসহ বিক্ষেপহীন একটি নোটপ্যাড।';

  @override
  String get languageSectionTitle => 'ভাষা';

  @override
  String get languageFollowsSystem => 'ডিভাইসের ভাষা সেটিং অনুসরণ করে';

  @override
  String get languageSystem => 'সিস্টেম ডিফল্ট';

  @override
  String get languagePickerTitle => 'ভাষা বেছে নিন';

  @override
  String get premiumScreenTitle => 'বিজ্ঞাপন সরান';

  @override
  String get premiumHeadline => 'বিক্ষেপ ছাড়াই লিখুন';

  @override
  String get premiumBody =>
      'Atrament বিনামূল্যে এবং এতে মাত্র একটি ছোট বিজ্ঞাপন ব্যানার দেখানো হয়। বিজ্ঞাপন সরানো একবারের কেনাকাটা, যা অন্য কিছু আনলক করে না—সব ফিচার ইতিমধ্যেই আপনার।';

  @override
  String get premiumRestoreButton => 'কেনাকাটা পুনরুদ্ধার করুন';

  @override
  String get premiumAlreadyProMessage =>
      'আপনার কাছে ইতিমধ্যেই “বিজ্ঞাপন সরান” আছে। ধন্যবাদ!';

  @override
  String get supportSectionTitle => 'সহায়তা';

  @override
  String get shareDebugLogButton => 'ডিবাগ লগ শেয়ার করুন';

  @override
  String get shareDebugLogSubtitle =>
      'কিছু কাজ না করলে একটি প্রযুক্তিগত রিপোর্ট পাঠান';

  @override
  String get noDebugLogMessage => 'রিপোর্ট করার মতো কিছু এখনো নেই।';

  @override
  String get clearDebugLogButton => 'ডিবাগ লগ মুছুন';

  @override
  String get clearDebugLogTitle => 'ডিবাগ লগ মুছবেন?';

  @override
  String get clearDebugLogBody =>
      'সংরক্ষিত প্রযুক্তিগত রিপোর্টটি আপনার ডিভাইস থেকে সরিয়ে দেওয়া হবে।';

  @override
  String get debugLogClearedMessage => 'ডিবাগ লগ মোছা হয়েছে।';

  @override
  String get premiumUnlockLabel => 'চিরতরে বিজ্ঞাপন সরান';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'সব';

  @override
  String get chipNotebooks => 'নোটবুক';

  @override
  String get chipRecent => 'সাম্প্রতিক';

  @override
  String get emptyAllNotesTitle => 'এখনো কোনো নোট নেই';

  @override
  String get emptyAllNotesBody => 'আপনার প্রথম নোট লিখতে + ট্যাপ করুন।';

  @override
  String get emptyRecentNotesTitle => 'সাম্প্রতিক কিছু নেই';

  @override
  String get emptyRecentNotesBody =>
      'আপনি যে নোটগুলো সম্পাদনা করবেন সেগুলো এখানে দেখা যাবে।';

  @override
  String get noteActionRename => 'নাম পরিবর্তন করুন';

  @override
  String get noteActionMoveToNotebook => 'নোটবুকে নিয়ে যান';

  @override
  String get noteActionEdit => 'সম্পাদনা করুন';

  @override
  String get noteActionExport => 'এক্সপোর্ট';

  @override
  String get noteActionShare => 'শেয়ার করুন';

  @override
  String get moveToNotebookTitle => 'নোটবুকে নিয়ে যান';

  @override
  String get moveToNotebookEmptyBody =>
      'এখনো অন্য কোনো নোটবুক নেই। এই নোটটি গুছিয়ে রাখতে একটি তৈরি করুন।';

  @override
  String get moveToNotebookCreateRow => 'নতুন নোটবুক তৈরি করুন';

  @override
  String get notebookActionRename => 'নাম পরিবর্তন করুন';

  @override
  String get notebookActionChangeCover => 'কভার পরিবর্তন করুন';

  @override
  String get notebookRenameDialogTitle => 'নোটবুকের নাম পরিবর্তন করুন';

  @override
  String get notebookCoverPickerTitle => 'কভারের রঙ বেছে নিন';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'নোটবুকটি এর সব নোটসহ মুছে যাবে (মোট: $count)। এই কাজটি আর ফেরানো যাবে না।';
  }

  @override
  String get legalAndSupportSectionTitle => 'আইনি তথ্য ও সহায়তা';

  @override
  String get privacyPolicyRow => 'গোপনীয়তা নীতি';

  @override
  String get termsOfServiceRow => 'পরিষেবার শর্তাবলি';

  @override
  String get supportRow => 'সহায়তা';

  @override
  String get openLinkFailedMessage =>
      'লিংক খোলা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get openSourceLicensesRow => 'ওপেন সোর্স লাইসেন্স';
}
