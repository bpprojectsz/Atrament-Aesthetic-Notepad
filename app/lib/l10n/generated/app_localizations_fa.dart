// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get errorGeneric => 'مشکلی پیش آمد';

  @override
  String get cancel => 'لغو';

  @override
  String get save => 'ذخیره';

  @override
  String get delete => 'حذف';

  @override
  String get undo => 'واگرد';

  @override
  String get redo => 'انجام دوباره';

  @override
  String get untitledNote => 'بدون عنوان';

  @override
  String get deleteConfirmBody => 'این عمل قابل بازگشت نیست.';

  @override
  String get deleteNoteTitle => 'این یادداشت حذف شود؟';

  @override
  String deleteNotebookTitle(String name) {
    return '«$name» حذف شود؟';
  }

  @override
  String get saveFailedMessage => 'ذخیره نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get exportFailedMessage =>
      'خروجی گرفتن از این یادداشت انجام نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get shareFailedMessage =>
      'منوی اشتراک‌گذاری باز نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get searchHint => 'جستجوی یادداشت‌ها';

  @override
  String get emptyNotebooksTitle => 'هنوز دفترچه‌ای وجود ندارد';

  @override
  String get emptyNotebooksBody =>
      'برای شروع نوشتن، اولین دفترچه‌تان را بسازید.';

  @override
  String get emptySearchTitle => 'نتیجه‌ای یافت نشد';

  @override
  String get emptySearchBody => 'عبارت دیگری را جستجو کنید.';

  @override
  String get emptyNotebookTitle => 'هنوز یادداشتی وجود ندارد';

  @override
  String get emptyNotebookBody => 'برای نوشتن اولین یادداشت، روی + بزنید.';

  @override
  String get newNotebookTitle => 'دفترچه جدید';

  @override
  String get notebookNameHint => 'نام دفترچه';

  @override
  String get newNoteTitle => 'یادداشت جدید';

  @override
  String get sortOptionsTitle => 'مرتب‌سازی';

  @override
  String get sortByModified => 'آخرین ویرایش';

  @override
  String get sortByCreated => 'تاریخ ایجاد';

  @override
  String get sortByTitle => 'عنوان';

  @override
  String get formatBold => 'پررنگ';

  @override
  String get formatItalic => 'مورب';

  @override
  String get formatUnderline => 'زیرخط‌دار';

  @override
  String get formatHeading => 'سرتیتر';

  @override
  String get formatBulletList => 'فهرست گلوله‌ای';

  @override
  String get formatChecklist => 'فهرست کارها';

  @override
  String get formatQuote => 'نقل‌قول';

  @override
  String get formatCodeBlock => 'بلوک کد';

  @override
  String get penFountainPen => 'خودنویس';

  @override
  String get penGelPen => 'خودکار ژله‌ای';

  @override
  String get penPencil => 'مداد';

  @override
  String get penHighlighter => 'ماژیک هایلایت';

  @override
  String get penEraser => 'پاک‌کن';

  @override
  String get penStrokeWidth => 'ضخامت خط';

  @override
  String get toggleHandwritingMode => 'جابه‌جایی بین تایپ و نقاشی';

  @override
  String get biometricLockReason => 'برای دیدن یادداشت، قفل را باز کنید';

  @override
  String get noteLockedMessage => 'این یادداشت قفل است';

  @override
  String get unlockButton => 'باز کردن قفل';

  @override
  String get noteLockTurnedOffMessage =>
      'قفل یادداشت خاموش شد، چون در این دستگاه قفل صفحه یا بیومتریک تنظیم نشده است.';

  @override
  String get biometricEnableReason =>
      'برای روشن کردن قفل یادداشت، هویت خود را تأیید کنید';

  @override
  String get biometricDisableReason =>
      'برای خاموش کردن قفل یادداشت، هویت خود را تأیید کنید';

  @override
  String get biometricShareReason =>
      'برای اشتراک‌گذاری یا خروجی گرفتن از این یادداشت، قفل را باز کنید';

  @override
  String get biometricAuthFailedMessage => 'هویت شما تأیید نشد.';

  @override
  String get biometricSetupNeededMessage =>
      'ابتدا در تنظیمات دستگاه، قفل صفحه یا اثر انگشت را تنظیم کنید.';

  @override
  String get privacyChoicesTitle => 'گزینه‌های حریم خصوصی';

  @override
  String get purchaseFailedMessage => 'خرید کامل نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get restoreSuccessMessage => 'خرید شما بازیابی شد.';

  @override
  String get restoreNothingFoundMessage => 'خرید قبلی برای این حساب پیدا نشد.';

  @override
  String get restoreFailedMessage =>
      'خریدها بازیابی نشدند. اتصال خود را بررسی کنید و دوباره تلاش کنید.';

  @override
  String get reminderScheduleFailedMessage =>
      'یادآور زمان‌بندی نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get storageIssueNotebooksLoad =>
      'برخی دفترچه‌ها بارگذاری نشدند. موارد موجود نمایش داده می‌شوند.';

  @override
  String get storageIssueNotebookSave =>
      'ممکن است این دفترچه ذخیره نشده باشد. لطفاً دوباره تلاش کنید.';

  @override
  String get storageIssueNotebookChange =>
      'ممکن است این تغییر ذخیره نشده باشد. لطفاً دوباره تلاش کنید.';

  @override
  String get storageIssueNotebookDelete =>
      'دفترچه حذف نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get storageIssueNotebookOrder =>
      'ممکن است ترتیب جدید ذخیره نشده باشد. لطفاً دوباره تلاش کنید.';

  @override
  String get storageIssueNotesLoad =>
      'برخی یادداشت‌ها بارگذاری نشدند. موارد موجود نمایش داده می‌شوند.';

  @override
  String get storageIssueSearch =>
      'در حال حاضر ممکن است نتایج جستجو ناقص باشند.';

  @override
  String get storageIssueNoteSave =>
      'ممکن است این یادداشت ذخیره نشده باشد. حافظه دستگاه را بررسی کنید.';

  @override
  String get storageIssueNoteDelete =>
      'یادداشت حذف نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get purchaseUnavailableMessage =>
      'این خرید در حال حاضر در دسترس نیست. لطفاً بعداً دوباره تلاش کنید.';

  @override
  String get exportTitle => 'خروجی گرفتن';

  @override
  String get exportAsTxt => 'خروجی به‌صورت متن';

  @override
  String get exportAsPdf => 'خروجی به‌صورت PDF';

  @override
  String get paperStyleSectionTitle => 'سبک کاغذ';

  @override
  String get paperStyleLined => 'خط‌دار';

  @override
  String get paperStyleDotGrid => 'نقطه‌چین';

  @override
  String get paperStyleGrid => 'شطرنجی';

  @override
  String get paperStyleBlank => 'سفید';

  @override
  String get paperStyleCream => 'کرم';

  @override
  String get paperStyleParchment => 'پارشمن';

  @override
  String get paperStyleVellum => 'کاغذ پوستی';

  @override
  String get fontSectionTitle => 'قلم یادداشت‌ها';

  @override
  String get fontSystem => 'سیستم';

  @override
  String get fontSerif => 'سریف‌دار';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'ظاهر';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تیره';

  @override
  String get themeParchment => 'پارشمن';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get verseSectionTitle => 'نمایش آیه روز';

  @override
  String get verseModeWatermark => 'نقش‌آب';

  @override
  String get verseModeHeader => 'سرصفحه';

  @override
  String get verseModeFooter => 'پاصفحه';

  @override
  String get verseModeOff => 'خاموش';

  @override
  String get notificationsSectionTitle => 'اعلان‌ها';

  @override
  String get dailyReminderToggle => 'یادآور روزانه آیه';

  @override
  String get reminderTimeLabel => 'زمان یادآور';

  @override
  String get notificationPermissionDenied =>
      'اعلان‌ها در تنظیمات سیستم خاموش هستند.';

  @override
  String get dailyReminderBody => 'آیه امروز شما آماده است.';

  @override
  String get privacySectionTitle => 'حریم خصوصی';

  @override
  String get biometricLockToggle => 'قفل یادداشت‌ها با Face ID / اثر انگشت';

  @override
  String get premiumSectionTitle => 'پریمیوم';

  @override
  String get removeAdsTitle => 'حذف تبلیغات';

  @override
  String get restorePurchasesButton => 'بازیابی خریدها';

  @override
  String get proLabel => 'پرو';

  @override
  String get engagementSectionTitle => 'بیشتر';

  @override
  String get rateAppTitle => 'امتیاز دادن به Atrament';

  @override
  String get rateAppSubtitle => 'از برنامه خوشتان آمد؟ نظر بدهید';

  @override
  String get shareAppTitle => 'اشتراک‌گذاری Atrament';

  @override
  String get shareAppSubtitle => 'به یک دوست بگویید';

  @override
  String get shareAppMessage =>
      'Atrament را امتحان کنید — دفترچه‌ای بدون حواس‌پرتی با بافت کاغذ.';

  @override
  String get languageSectionTitle => 'زبان';

  @override
  String get languageFollowsSystem => 'از تنظیم زبان دستگاه پیروی می‌کند';

  @override
  String get languageSystem => 'پیش‌فرض سیستم';

  @override
  String get languagePickerTitle => 'انتخاب زبان';

  @override
  String get premiumScreenTitle => 'حذف تبلیغات';

  @override
  String get premiumHeadline => 'بدون حواس‌پرتی بنویسید';

  @override
  String get premiumBody =>
      'Atrament رایگان است و فقط یک بنر تبلیغاتی کوچک نشان می‌دهد. حذف تبلیغات یک خرید یک‌باره است که چیز دیگری را باز نمی‌کند — همه قابلیت‌ها از قبل مال شماست.';

  @override
  String get premiumRestoreButton => 'بازیابی خریدها';

  @override
  String get premiumAlreadyProMessage =>
      '«حذف تبلیغات» را از قبل دارید. سپاسگزاریم!';

  @override
  String get supportSectionTitle => 'پشتیبانی';

  @override
  String get shareDebugLogButton => 'اشتراک‌گذاری گزارش اشکال‌زدایی';

  @override
  String get shareDebugLogSubtitle => 'اگر چیزی کار نمی‌کند، گزارش فنی بفرستید';

  @override
  String get noDebugLogMessage => 'هنوز چیزی برای گزارش نیست.';

  @override
  String get clearDebugLogButton => 'پاک کردن گزارش اشکال‌زدایی';

  @override
  String get clearDebugLogTitle => 'گزارش اشکال‌زدایی پاک شود؟';

  @override
  String get clearDebugLogBody =>
      'گزارش فنی ذخیره‌شده از دستگاه شما حذف می‌شود.';

  @override
  String get debugLogClearedMessage => 'گزارش اشکال‌زدایی پاک شد.';

  @override
  String get premiumUnlockLabel => 'حذف دائمی تبلیغات';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'همه';

  @override
  String get chipNotebooks => 'دفترچه‌ها';

  @override
  String get chipRecent => 'اخیر';

  @override
  String get emptyAllNotesTitle => 'هنوز یادداشتی وجود ندارد';

  @override
  String get emptyAllNotesBody => 'برای نوشتن اولین یادداشت، روی + بزنید.';

  @override
  String get emptyRecentNotesTitle => 'مورد اخیری نیست';

  @override
  String get emptyRecentNotesBody =>
      'یادداشت‌هایی که ویرایش می‌کنید اینجا نمایش داده می‌شوند.';

  @override
  String get noteActionRename => 'تغییر نام';

  @override
  String get noteActionMoveToNotebook => 'انتقال به دفترچه';

  @override
  String get noteActionEdit => 'ویرایش';

  @override
  String get noteActionExport => 'خروجی گرفتن';

  @override
  String get noteActionShare => 'اشتراک‌گذاری';

  @override
  String get moveToNotebookTitle => 'انتقال به دفترچه';

  @override
  String get moveToNotebookEmptyBody =>
      'هنوز دفترچه دیگری وجود ندارد. برای سازمان‌دهی این یادداشت، یکی بسازید.';

  @override
  String get moveToNotebookCreateRow => 'ساخت دفترچه جدید';

  @override
  String get notebookActionRename => 'تغییر نام';

  @override
  String get notebookActionChangeCover => 'تغییر جلد';

  @override
  String get notebookRenameDialogTitle => 'تغییر نام دفترچه';

  @override
  String get notebookCoverPickerTitle => 'انتخاب رنگ جلد';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'دفترچه با همه یادداشت‌هایش حذف می‌شود (مجموعاً: $count). این عمل قابل بازگشت نیست.';
  }

  @override
  String get legalAndSupportSectionTitle => 'اطلاعات حقوقی و پشتیبانی';

  @override
  String get privacyPolicyRow => 'سیاست حریم خصوصی';

  @override
  String get termsOfServiceRow => 'شرایط خدمات';

  @override
  String get supportRow => 'پشتیبانی';

  @override
  String get openLinkFailedMessage => 'پیوند باز نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get openSourceLicensesRow => 'مجوزهای متن‌باز';
}
