// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Опитайте отново';

  @override
  String get errorGeneric => 'Нещо се обърка';

  @override
  String get cancel => 'Отказ';

  @override
  String get save => 'Запази';

  @override
  String get delete => 'Изтрий';

  @override
  String get undo => 'Отмяна';

  @override
  String get redo => 'Повторение';

  @override
  String get untitledNote => 'Без заглавие';

  @override
  String get deleteConfirmBody => 'Това действие не може да бъде отменено.';

  @override
  String get deleteNoteTitle => 'Да се изтрие ли тази бележка?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Да се изтрие ли „$name“?';
  }

  @override
  String get saveFailedMessage => 'Запазването не бе успешно. Опитайте отново.';

  @override
  String get exportFailedMessage =>
      'Експортирането на бележката не бе успешно. Опитайте отново.';

  @override
  String get shareFailedMessage =>
      'Менюто за споделяне не можа да се отвори. Опитайте отново.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get searchHint => 'Търсене в бележките';

  @override
  String get emptyNotebooksTitle => 'Още няма тетрадки';

  @override
  String get emptyNotebooksBody =>
      'Създайте първата си тетрадка, за да започнете да пишете.';

  @override
  String get emptySearchTitle => 'Няма резултати';

  @override
  String get emptySearchBody => 'Опитайте с друга дума за търсене.';

  @override
  String get emptyNotebookTitle => 'Още няма бележки';

  @override
  String get emptyNotebookBody =>
      'Докоснете +, за да напишете първата си бележка.';

  @override
  String get newNotebookTitle => 'Нова тетрадка';

  @override
  String get notebookNameHint => 'Име на тетрадката';

  @override
  String get newNoteTitle => 'Нова бележка';

  @override
  String get sortOptionsTitle => 'Сортиране';

  @override
  String get sortByModified => 'Последно редактирани';

  @override
  String get sortByCreated => 'Дата на създаване';

  @override
  String get sortByTitle => 'Заглавие';

  @override
  String get formatBold => 'Получер';

  @override
  String get formatItalic => 'Курсив';

  @override
  String get formatUnderline => 'Подчертан';

  @override
  String get formatHeading => 'Заглавие';

  @override
  String get formatBulletList => 'Списък с водещи символи';

  @override
  String get formatChecklist => 'Списък със задачи';

  @override
  String get formatQuote => 'Цитат';

  @override
  String get formatCodeBlock => 'Блок с код';

  @override
  String get penFountainPen => 'Писалка';

  @override
  String get penGelPen => 'Гел писалка';

  @override
  String get penPencil => 'Молив';

  @override
  String get penHighlighter => 'Маркер';

  @override
  String get penEraser => 'Гумичка';

  @override
  String get penStrokeWidth => 'Дебелина на линията';

  @override
  String get toggleHandwritingMode => 'Превключване между писане и рисуване';

  @override
  String get biometricLockReason => 'Отключете, за да видите бележката';

  @override
  String get noteLockedMessage => 'Тази бележка е заключена';

  @override
  String get unlockButton => 'Отключване';

  @override
  String get noteLockTurnedOffMessage =>
      'Заключването на бележките е изключено, защото това устройство няма настроено заключване на екрана или биометрия.';

  @override
  String get biometricEnableReason =>
      'Потвърдете самоличността си, за да включите заключването на бележките';

  @override
  String get biometricDisableReason =>
      'Потвърдете самоличността си, за да изключите заключването на бележките';

  @override
  String get biometricShareReason =>
      'Отключете, за да споделите или експортирате бележката';

  @override
  String get biometricAuthFailedMessage =>
      'Самоличността ви не можа да бъде потвърдена.';

  @override
  String get biometricSetupNeededMessage =>
      'Първо настройте заключване на екрана или пръстов отпечатък от настройките на устройството.';

  @override
  String get privacyChoicesTitle => 'Опции за поверителност';

  @override
  String get purchaseFailedMessage =>
      'Покупката не можа да бъде завършена. Опитайте отново.';

  @override
  String get restoreSuccessMessage => 'Покупката ви беше възстановена.';

  @override
  String get restoreNothingFoundMessage =>
      'Не е намерена предишна покупка за този акаунт.';

  @override
  String get restoreFailedMessage =>
      'Покупките не можаха да бъдат възстановени. Проверете връзката си и опитайте отново.';

  @override
  String get reminderScheduleFailedMessage =>
      'Напомнянето не можа да бъде насрочено. Опитайте отново.';

  @override
  String get storageIssueNotebooksLoad =>
      'Някои тетрадки не можаха да бъдат заредени. Показва се наличното.';

  @override
  String get storageIssueNotebookSave =>
      'Тази тетрадка може да не е запазена. Опитайте отново.';

  @override
  String get storageIssueNotebookChange =>
      'Тази промяна може да не е запазена. Опитайте отново.';

  @override
  String get storageIssueNotebookDelete =>
      'Тетрадката не можа да бъде изтрита. Опитайте отново.';

  @override
  String get storageIssueNotebookOrder =>
      'Новата подредба може да не е запазена. Опитайте отново.';

  @override
  String get storageIssueNotesLoad =>
      'Някои бележки не можаха да бъдат заредени. Показва се наличното.';

  @override
  String get storageIssueSearch =>
      'В момента резултатите от търсенето може да са непълни.';

  @override
  String get storageIssueNoteSave =>
      'Тази бележка може да не е запазена. Проверете паметта на устройството.';

  @override
  String get storageIssueNoteDelete =>
      'Бележката не можа да бъде изтрита. Опитайте отново.';

  @override
  String get purchaseUnavailableMessage =>
      'Тази покупка в момента не е налична. Опитайте по-късно.';

  @override
  String get exportTitle => 'Експорт';

  @override
  String get exportAsTxt => 'Експорт като текст';

  @override
  String get exportAsPdf => 'Експорт като PDF';

  @override
  String get paperStyleSectionTitle => 'Стил на хартията';

  @override
  String get paperStyleLined => 'На редове';

  @override
  String get paperStyleDotGrid => 'С точки';

  @override
  String get paperStyleGrid => 'На квадратчета';

  @override
  String get paperStyleBlank => 'Празна';

  @override
  String get paperStyleCream => 'Кремава';

  @override
  String get paperStyleParchment => 'Пергамент';

  @override
  String get paperStyleVellum => 'Велен';

  @override
  String get fontSectionTitle => 'Шрифт на бележките';

  @override
  String get fontSystem => 'Системен';

  @override
  String get fontSerif => 'Със серифи';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Външен вид';

  @override
  String get themeLight => 'Светъл';

  @override
  String get themeDark => 'Тъмен';

  @override
  String get themeParchment => 'Пергамент';

  @override
  String get themeSystem => 'Системен';

  @override
  String get verseSectionTitle => 'Показване на стиха за деня';

  @override
  String get verseModeWatermark => 'Воден знак';

  @override
  String get verseModeHeader => 'Горен колонтитул';

  @override
  String get verseModeFooter => 'Долен колонтитул';

  @override
  String get verseModeOff => 'Изключено';

  @override
  String get notificationsSectionTitle => 'Известия';

  @override
  String get dailyReminderToggle => 'Ежедневно напомняне за стих';

  @override
  String get reminderTimeLabel => 'Час на напомнянето';

  @override
  String get notificationPermissionDenied =>
      'Известията са изключени в настройките на системата.';

  @override
  String get dailyReminderBody => 'Стихът ви за деня е готов.';

  @override
  String get privacySectionTitle => 'Поверителност';

  @override
  String get biometricLockToggle =>
      'Заключване на бележките с Face ID / пръстов отпечатък';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Премахване на рекламите';

  @override
  String get restorePurchasesButton => 'Възстановяване на покупките';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Още';

  @override
  String get rateAppTitle => 'Оценете Atrament';

  @override
  String get rateAppSubtitle => 'Харесва ли ви приложението? Оставете отзив';

  @override
  String get shareAppTitle => 'Споделете Atrament';

  @override
  String get shareAppSubtitle => 'Кажете на приятел';

  @override
  String get shareAppMessage =>
      'Опитайте Atrament — бележник без разсейване с текстури на хартия.';

  @override
  String get languageSectionTitle => 'Език';

  @override
  String get languageFollowsSystem => 'Следва езика на устройството';

  @override
  String get languageSystem => 'По подразбиране на системата';

  @override
  String get languagePickerTitle => 'Избор на език';

  @override
  String get premiumScreenTitle => 'Премахване на рекламите';

  @override
  String get premiumHeadline => 'Пишете без разсейване';

  @override
  String get premiumBody =>
      'Atrament е безплатно и показва един малък рекламен банер. Премахването на рекламите е еднократна покупка, която не отключва нищо друго — всички функции вече са ваши.';

  @override
  String get premiumRestoreButton => 'Възстановяване на покупките';

  @override
  String get premiumAlreadyProMessage =>
      'Вече имате „Премахване на рекламите“. Благодарим ви!';

  @override
  String get supportSectionTitle => 'Поддръжка';

  @override
  String get shareDebugLogButton =>
      'Споделяне на дневника за отстраняване на грешки';

  @override
  String get shareDebugLogSubtitle =>
      'Изпратете технически доклад, ако нещо не работи';

  @override
  String get noDebugLogMessage => 'Още няма нищо за докладване.';

  @override
  String get clearDebugLogButton =>
      'Изчистване на дневника за отстраняване на грешки';

  @override
  String get clearDebugLogTitle =>
      'Да се изчисти ли дневникът за отстраняване на грешки?';

  @override
  String get clearDebugLogBody =>
      'Това ще премахне запазения технически доклад от устройството ви.';

  @override
  String get debugLogClearedMessage =>
      'Дневникът за отстраняване на грешки е изчистен.';

  @override
  String get premiumUnlockLabel => 'Премахване на рекламите завинаги';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Всички';

  @override
  String get chipNotebooks => 'Тетрадки';

  @override
  String get chipRecent => 'Скорошни';

  @override
  String get emptyAllNotesTitle => 'Още няма бележки';

  @override
  String get emptyAllNotesBody =>
      'Докоснете +, за да напишете първата си бележка.';

  @override
  String get emptyRecentNotesTitle => 'Няма скорошни';

  @override
  String get emptyRecentNotesBody =>
      'Тук ще се показват бележките, които редактирате.';

  @override
  String get noteActionRename => 'Преименуване';

  @override
  String get noteActionMoveToNotebook => 'Преместване в тетрадка';

  @override
  String get noteActionEdit => 'Редактиране';

  @override
  String get noteActionExport => 'Експорт';

  @override
  String get noteActionShare => 'Споделяне';

  @override
  String get moveToNotebookTitle => 'Преместване в тетрадка';

  @override
  String get moveToNotebookEmptyBody =>
      'Още няма други тетрадки. Създайте една, за да подредите тази бележка.';

  @override
  String get moveToNotebookCreateRow => 'Създаване на нова тетрадка';

  @override
  String get notebookActionRename => 'Преименуване';

  @override
  String get notebookActionChangeCover => 'Смяна на корицата';

  @override
  String get notebookRenameDialogTitle => 'Преименуване на тетрадката';

  @override
  String get notebookCoverPickerTitle => 'Изберете цвят на корицата';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Тетрадката ще бъде изтрита заедно с всички бележки в нея (общо: $count). Това действие не може да бъде отменено.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Правна информация и поддръжка';

  @override
  String get privacyPolicyRow => 'Политика за поверителност';

  @override
  String get termsOfServiceRow => 'Условия за ползване';

  @override
  String get supportRow => 'Поддръжка';

  @override
  String get openLinkFailedMessage =>
      'Връзката не можа да се отвори. Опитайте отново.';

  @override
  String get openSourceLicensesRow => 'Лицензи за отворен код';
}
