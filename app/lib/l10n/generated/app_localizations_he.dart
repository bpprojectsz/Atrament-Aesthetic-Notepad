// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appName => 'אטרמנט';

  @override
  String get retry => 'נסה שוב';

  @override
  String get errorGeneric => 'משהו השתבש';

  @override
  String get cancel => 'ביטול';

  @override
  String get save => 'שמירה';

  @override
  String get delete => 'מחיקה';

  @override
  String get undo => 'בטל';

  @override
  String get redo => 'בצע שוב';

  @override
  String get untitledNote => 'ללא כותרת';

  @override
  String get deleteConfirmBody => 'לא ניתן לבטל פעולה זו.';

  @override
  String get deleteNoteTitle => 'למחוק פתקית זו?';

  @override
  String deleteNotebookTitle(String name) {
    return 'למחוק את \"$name\"?';
  }

  @override
  String get saveFailedMessage => 'השמירה נכשלה. נסה שוב.';

  @override
  String get exportFailedMessage => 'ייצוא הפתקית נכשל. נסה שוב.';

  @override
  String get shareFailedMessage => 'פתיחת תפריט השיתוף נכשלה. נסה שוב.';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get searchHint => 'חיפוש בפתקיות';

  @override
  String get emptyNotebooksTitle => 'אין עדיין מחברות';

  @override
  String get emptyNotebooksBody =>
      'צור את המחברת הראשונה שלך כדי להתחיל לכתוב.';

  @override
  String get emptySearchTitle => 'אין תוצאות';

  @override
  String get emptySearchBody => 'נסה מונח חיפוש אחר.';

  @override
  String get emptyNotebookTitle => 'אין עדיין פתקיות';

  @override
  String get emptyNotebookBody => 'הקש על + כדי לכתוב את הפתקית הראשונה שלך.';

  @override
  String get newNotebookTitle => 'מחברת חדשה';

  @override
  String get notebookNameHint => 'שם המחברת';

  @override
  String get newNoteTitle => 'פתקית חדשה';

  @override
  String get sortOptionsTitle => 'מיון';

  @override
  String get sortByModified => 'עריכה אחרונה';

  @override
  String get sortByCreated => 'תאריך יצירה';

  @override
  String get sortByTitle => 'כותרת';

  @override
  String get formatBold => 'מודגש';

  @override
  String get formatItalic => 'נטוי';

  @override
  String get formatUnderline => 'קו תחתי';

  @override
  String get formatHeading => 'כותרת';

  @override
  String get formatBulletList => 'רשימת תבליטים';

  @override
  String get formatChecklist => 'רשימת משימות';

  @override
  String get formatQuote => 'ציטוט';

  @override
  String get formatCodeBlock => 'בלוק קוד';

  @override
  String get penFountainPen => 'עט נובע';

  @override
  String get penGelPen => 'עט ג\'ל';

  @override
  String get penPencil => 'עיפרון';

  @override
  String get penHighlighter => 'מדגיש';

  @override
  String get penEraser => 'מחק';

  @override
  String get penStrokeWidth => 'עובי קו';

  @override
  String get toggleHandwritingMode => 'החלפה בין הקלדה לציור';

  @override
  String get biometricLockReason => 'בטל נעילה כדי לצפות בפתקית זו';

  @override
  String get noteLockedMessage => 'פתקית זו נעולה';

  @override
  String get unlockButton => 'בטל נעילה';

  @override
  String get exportTitle => 'ייצוא';

  @override
  String get exportAsTxt => 'ייצוא כטקסט';

  @override
  String get exportAsPdf => 'ייצוא כ-PDF';

  @override
  String get paperStyleSectionTitle => 'סגנון נייר';

  @override
  String get paperStyleLined => 'מסורגל';

  @override
  String get paperStyleDotGrid => 'רשת נקודות';

  @override
  String get paperStyleGrid => 'משובץ';

  @override
  String get paperStyleBlank => 'ריק';

  @override
  String get paperStyleCream => 'קרם';

  @override
  String get paperStyleParchment => 'קלף';

  @override
  String get paperStyleVellum => 'קלף עדין';

  @override
  String get fontSectionTitle => 'גופן הפתקית';

  @override
  String get fontSystem => 'מערכת';

  @override
  String get fontSerif => 'סריף';

  @override
  String get themeSectionTitle => 'מראה';

  @override
  String get themeLight => 'בהיר';

  @override
  String get themeDark => 'כהה';

  @override
  String get themeParchment => 'קלף';

  @override
  String get themeSystem => 'מערכת';

  @override
  String get verseSectionTitle => 'תצוגת פסוק יומי';

  @override
  String get verseModeWatermark => 'סימן מים';

  @override
  String get verseModeHeader => 'כותרת עליונה';

  @override
  String get verseModeFooter => 'כותרת תחתונה';

  @override
  String get verseModeOff => 'כבוי';

  @override
  String get notificationsSectionTitle => 'התראות';

  @override
  String get dailyReminderToggle => 'תזכורת פסוק יומית';

  @override
  String get reminderTimeLabel => 'שעת התזכורת';

  @override
  String get notificationPermissionDenied => 'ההתראות כבויות בהגדרות המערכת.';

  @override
  String get dailyReminderBody => 'הפסוק היומי שלך מוכן.';

  @override
  String get privacySectionTitle => 'פרטיות';

  @override
  String get biometricLockToggle => 'נעילת פתקיות עם Face ID / טביעת אצבע';

  @override
  String get premiumSectionTitle => 'פרימיום';

  @override
  String get removeAdsTitle => 'הסרת פרסומות';

  @override
  String get restorePurchasesButton => 'שחזור רכישות';

  @override
  String get proLabel => 'פרו';

  @override
  String get languageSectionTitle => 'שפה';

  @override
  String get languageFollowsSystem => 'בהתאם לשפת המכשיר שלך';

  @override
  String get languageSystem => 'ברירת מחדל של המערכת';

  @override
  String get languagePickerTitle => 'בחר שפה';

  @override
  String get premiumScreenTitle => 'הסרת פרסומות';

  @override
  String get premiumHeadline => 'כתוב ללא הסחות דעת';

  @override
  String get premiumBody =>
      'Atrament חינמית עם באנר פרסום קטן אחד. הסרתו היא רכישה חד-פעמית שאינה פותחת דבר נוסף — כל התכונות כבר שלך.';

  @override
  String get premiumRestoreButton => 'שחזור רכישות';

  @override
  String get premiumAlreadyProMessage => 'כבר יש לך הסרת פרסומות. תודה!';

  @override
  String get supportSectionTitle => 'תמיכה';

  @override
  String get shareDebugLogButton => 'שתף יומן ניפוי באגים';

  @override
  String get shareDebugLogSubtitle => 'שלח דוח טכני אם משהו לא עובד';

  @override
  String get noDebugLogMessage => 'אין עדיין בעיות לדווח עליהן.';

  @override
  String get clearDebugLogButton => 'נקה יומן ניפוי באגים';

  @override
  String get clearDebugLogTitle => 'לנקות את יומן ניפוי הבאגים?';

  @override
  String get clearDebugLogBody =>
      'פעולה זו מסירה את הדוח הטכני השמור מהמכשיר שלך.';

  @override
  String get debugLogClearedMessage => 'יומן ניפוי הבאגים נוקה.';

  @override
  String get premiumUnlockLabel => 'הסרת פרסומות לתמיד';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';
}
