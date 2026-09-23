// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'أترامنت';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get errorGeneric => 'حدث خطأ ما';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get undo => 'تراجع';

  @override
  String get redo => 'إعادة';

  @override
  String get untitledNote => 'بلا عنوان';

  @override
  String get deleteConfirmBody => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteNoteTitle => 'هل تريد حذف هذه الملاحظة؟';

  @override
  String deleteNotebookTitle(String name) {
    return 'هل تريد حذف \"$name\"؟';
  }

  @override
  String get saveFailedMessage => 'تعذّر الحفظ. يرجى المحاولة مرة أخرى.';

  @override
  String get exportFailedMessage =>
      'تعذّر تصدير هذه الملاحظة. يرجى المحاولة مرة أخرى.';

  @override
  String get shareFailedMessage =>
      'تعذّر فتح قائمة المشاركة. يرجى المحاولة مرة أخرى.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get searchHint => 'بحث في الملاحظات';

  @override
  String get emptyNotebooksTitle => 'لا توجد دفاتر بعد';

  @override
  String get emptyNotebooksBody => 'أنشئ أول دفتر لك لبدء الكتابة.';

  @override
  String get emptySearchTitle => 'لا توجد نتائج';

  @override
  String get emptySearchBody => 'جرّب مصطلح بحث مختلفًا.';

  @override
  String get emptyNotebookTitle => 'لا توجد ملاحظات بعد';

  @override
  String get emptyNotebookBody => 'اضغط على + لكتابة أول ملاحظة لك.';

  @override
  String get newNotebookTitle => 'دفتر جديد';

  @override
  String get notebookNameHint => 'اسم الدفتر';

  @override
  String get newNoteTitle => 'ملاحظة جديدة';

  @override
  String get sortOptionsTitle => 'الترتيب';

  @override
  String get sortByModified => 'آخر تعديل';

  @override
  String get sortByCreated => 'تاريخ الإنشاء';

  @override
  String get sortByTitle => 'العنوان';

  @override
  String get formatBold => 'عريض';

  @override
  String get formatItalic => 'مائل';

  @override
  String get formatUnderline => 'تسطير';

  @override
  String get formatHeading => 'عنوان';

  @override
  String get formatBulletList => 'قائمة نقطية';

  @override
  String get formatChecklist => 'قائمة مهام';

  @override
  String get formatQuote => 'اقتباس';

  @override
  String get formatCodeBlock => 'كتلة برمجية';

  @override
  String get penFountainPen => 'قلم حبر';

  @override
  String get penGelPen => 'قلم جل';

  @override
  String get penPencil => 'قلم رصاص';

  @override
  String get penHighlighter => 'قلم تحديد';

  @override
  String get penEraser => 'ممحاة';

  @override
  String get penStrokeWidth => 'سُمك الخط';

  @override
  String get toggleHandwritingMode => 'التبديل بين الكتابة والرسم';

  @override
  String get biometricLockReason => 'افتح القفل لعرض هذه الملاحظة';

  @override
  String get noteLockedMessage => 'هذه الملاحظة مقفلة';

  @override
  String get unlockButton => 'فتح القفل';

  @override
  String get exportTitle => 'تصدير';

  @override
  String get exportAsTxt => 'تصدير كنص';

  @override
  String get exportAsPdf => 'تصدير كملف PDF';

  @override
  String get paperStyleSectionTitle => 'نمط الورق';

  @override
  String get paperStyleLined => 'مسطّر';

  @override
  String get paperStyleDotGrid => 'شبكة نقطية';

  @override
  String get paperStyleGrid => 'شبكي';

  @override
  String get paperStyleBlank => 'فارغ';

  @override
  String get paperStyleCream => 'كريمي';

  @override
  String get paperStyleParchment => 'رقّ';

  @override
  String get paperStyleVellum => 'رقّ ناعم';

  @override
  String get fontSectionTitle => 'خط الملاحظة';

  @override
  String get fontSystem => 'النظام';

  @override
  String get fontSerif => 'سيريف';

  @override
  String get themeSectionTitle => 'المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeParchment => 'رقّ';

  @override
  String get themeSystem => 'النظام';

  @override
  String get verseSectionTitle => 'عرض آية اليوم';

  @override
  String get verseModeWatermark => 'علامة مائية';

  @override
  String get verseModeHeader => 'أعلى الصفحة';

  @override
  String get verseModeFooter => 'أسفل الصفحة';

  @override
  String get verseModeOff => 'إيقاف';

  @override
  String get notificationsSectionTitle => 'الإشعارات';

  @override
  String get dailyReminderToggle => 'تذكير يومي بالآية';

  @override
  String get reminderTimeLabel => 'وقت التذكير';

  @override
  String get notificationPermissionDenied =>
      'الإشعارات معطّلة في إعدادات النظام.';

  @override
  String get dailyReminderBody => 'آية اليوم جاهزة.';

  @override
  String get privacySectionTitle => 'الخصوصية';

  @override
  String get biometricLockToggle => 'قفل الملاحظات ببصمة الوجه / البصمة';

  @override
  String get premiumSectionTitle => 'بريميوم';

  @override
  String get removeAdsTitle => 'إزالة الإعلانات';

  @override
  String get restorePurchasesButton => 'استعادة المشتريات';

  @override
  String get proLabel => 'مميز';

  @override
  String get languageSectionTitle => 'اللغة';

  @override
  String get languageFollowsSystem => 'يتبع لغة جهازك';

  @override
  String get languageSystem => 'الافتراضي للنظام';

  @override
  String get languagePickerTitle => 'اختر اللغة';

  @override
  String get premiumScreenTitle => 'إزالة الإعلانات';

  @override
  String get premiumHeadline => 'اكتب دون تشتيت';

  @override
  String get premiumBody =>
      'Atrament مجاني مع إعلان بانر صغير واحد. إزالته عملية شراء لمرة واحدة لا تفتح أي شيء آخر — كل الميزات لك بالفعل.';

  @override
  String get premiumRestoreButton => 'استعادة المشتريات';

  @override
  String get premiumAlreadyProMessage =>
      'لديك بالفعل ميزة إزالة الإعلانات. شكرًا لك!';

  @override
  String get supportSectionTitle => 'الدعم';

  @override
  String get shareDebugLogButton => 'مشاركة سجل التصحيح';

  @override
  String get shareDebugLogSubtitle => 'أرسل تقريرًا تقنيًا إذا كان هناك خلل ما';

  @override
  String get noDebugLogMessage => 'لا توجد مشكلات للإبلاغ عنها بعد.';

  @override
  String get clearDebugLogButton => 'مسح سجل التصحيح';

  @override
  String get clearDebugLogTitle => 'هل تريد مسح سجل التصحيح؟';

  @override
  String get clearDebugLogBody =>
      'سيؤدي هذا إلى إزالة التقرير التقني المحفوظ من جهازك.';

  @override
  String get debugLogClearedMessage => 'تم مسح سجل التصحيح.';

  @override
  String get premiumUnlockLabel => 'إزالة الإعلانات نهائيًا';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';
}
