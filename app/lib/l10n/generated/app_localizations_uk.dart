// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Повторити';

  @override
  String get errorGeneric => 'Щось пішло не так';

  @override
  String get cancel => 'Скасувати';

  @override
  String get save => 'Зберегти';

  @override
  String get delete => 'Видалити';

  @override
  String get undo => 'Відмінити';

  @override
  String get redo => 'Повернути';

  @override
  String get untitledNote => 'Без назви';

  @override
  String get deleteConfirmBody => 'Цю дію не можна скасувати.';

  @override
  String get deleteNoteTitle => 'Видалити цю нотатку?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Видалити «$name»?';
  }

  @override
  String get saveFailedMessage => 'Не вдалося зберегти. Спробуйте ще раз.';

  @override
  String get exportFailedMessage =>
      'Не вдалося експортувати нотатку. Спробуйте ще раз.';

  @override
  String get shareFailedMessage =>
      'Не вдалося відкрити меню «Поділитися». Спробуйте ще раз.';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get searchHint => 'Пошук нотаток';

  @override
  String get emptyNotebooksTitle => 'Блокнотів ще немає';

  @override
  String get emptyNotebooksBody =>
      'Створіть перший блокнот, щоб почати писати.';

  @override
  String get emptySearchTitle => 'Нічого не знайдено';

  @override
  String get emptySearchBody => 'Спробуйте інший запит.';

  @override
  String get emptyNotebookTitle => 'Нотаток ще немає';

  @override
  String get emptyNotebookBody => 'Натисніть «+», щоб написати першу нотатку.';

  @override
  String get newNotebookTitle => 'Новий блокнот';

  @override
  String get notebookNameHint => 'Назва блокнота';

  @override
  String get newNoteTitle => 'Нова нотатка';

  @override
  String get sortOptionsTitle => 'Сортування';

  @override
  String get sortByModified => 'За датою зміни';

  @override
  String get sortByCreated => 'За датою створення';

  @override
  String get sortByTitle => 'За назвою';

  @override
  String get formatBold => 'Жирний';

  @override
  String get formatItalic => 'Курсив';

  @override
  String get formatUnderline => 'Підкреслений';

  @override
  String get formatHeading => 'Заголовок';

  @override
  String get formatBulletList => 'Маркований список';

  @override
  String get formatChecklist => 'Список завдань';

  @override
  String get formatQuote => 'Цитата';

  @override
  String get formatCodeBlock => 'Блок коду';

  @override
  String get penFountainPen => 'Перова ручка';

  @override
  String get penGelPen => 'Гелева ручка';

  @override
  String get penPencil => 'Олівець';

  @override
  String get penHighlighter => 'Маркер';

  @override
  String get penEraser => 'Гумка';

  @override
  String get penStrokeWidth => 'Товщина лінії';

  @override
  String get toggleHandwritingMode => 'Перемикання між друком і малюванням';

  @override
  String get biometricLockReason => 'Розблокуйте, щоб переглянути нотатку';

  @override
  String get noteLockedMessage => 'Нотатку заблоковано';

  @override
  String get unlockButton => 'Розблокувати';

  @override
  String get noteLockTurnedOffMessage =>
      'Блокування нотаток вимкнено: на цьому пристрої не налаштовано блокування екрана чи біометрію.';

  @override
  String get biometricEnableReason =>
      'Підтвердьте особу, щоб увімкнути блокування нотаток';

  @override
  String get biometricDisableReason =>
      'Підтвердьте особу, щоб вимкнути блокування нотаток';

  @override
  String get biometricShareReason =>
      'Розблокуйте, щоб поділитися нотаткою або експортувати її';

  @override
  String get biometricAuthFailedMessage => 'Не вдалося підтвердити вашу особу.';

  @override
  String get biometricSetupNeededMessage =>
      'Спершу налаштуйте блокування екрана або відбиток пальця в налаштуваннях пристрою.';

  @override
  String get privacyChoicesTitle => 'Параметри конфіденційності';

  @override
  String get purchaseFailedMessage =>
      'Не вдалося завершити покупку. Спробуйте ще раз.';

  @override
  String get restoreSuccessMessage => 'Покупку відновлено.';

  @override
  String get restoreNothingFoundMessage =>
      'Для цього облікового запису попередніх покупок не знайдено.';

  @override
  String get restoreFailedMessage =>
      'Не вдалося відновити покупки. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get reminderScheduleFailedMessage =>
      'Не вдалося налаштувати нагадування. Спробуйте ще раз.';

  @override
  String get storageIssueNotebooksLoad =>
      'Частину блокнотів не вдалося завантажити. Показано те, що доступне.';

  @override
  String get storageIssueNotebookSave =>
      'Можливо, цей блокнот не збережено. Спробуйте ще раз.';

  @override
  String get storageIssueNotebookChange =>
      'Можливо, цю зміну не збережено. Спробуйте ще раз.';

  @override
  String get storageIssueNotebookDelete =>
      'Не вдалося видалити блокнот. Спробуйте ще раз.';

  @override
  String get storageIssueNotebookOrder =>
      'Можливо, новий порядок не збережено. Спробуйте ще раз.';

  @override
  String get storageIssueNotesLoad =>
      'Частину нотаток не вдалося завантажити. Показано те, що доступне.';

  @override
  String get storageIssueSearch =>
      'Наразі результати пошуку можуть бути неповними.';

  @override
  String get storageIssueNoteSave =>
      'Можливо, цю нотатку не збережено. Перевірте вільне місце на пристрої.';

  @override
  String get storageIssueNoteDelete =>
      'Не вдалося видалити нотатку. Спробуйте ще раз.';

  @override
  String get purchaseUnavailableMessage =>
      'Ця покупка зараз недоступна. Спробуйте пізніше.';

  @override
  String get exportTitle => 'Експорт';

  @override
  String get exportAsTxt => 'Експорт у текст';

  @override
  String get exportAsPdf => 'Експорт у PDF';

  @override
  String get paperStyleSectionTitle => 'Стиль паперу';

  @override
  String get paperStyleLined => 'У лінійку';

  @override
  String get paperStyleDotGrid => 'У крапку';

  @override
  String get paperStyleGrid => 'У клітинку';

  @override
  String get paperStyleBlank => 'Чистий аркуш';

  @override
  String get paperStyleCream => 'Кремовий';

  @override
  String get paperStyleParchment => 'Пергамент';

  @override
  String get paperStyleVellum => 'Велень';

  @override
  String get fontSectionTitle => 'Шрифт нотаток';

  @override
  String get fontSystem => 'Системний';

  @override
  String get fontSerif => 'З засічками';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Оформлення';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get themeParchment => 'Пергамент';

  @override
  String get themeSystem => 'Системна';

  @override
  String get verseSectionTitle => 'Показ вірша дня';

  @override
  String get verseModeWatermark => 'Водяний знак';

  @override
  String get verseModeHeader => 'Угорі';

  @override
  String get verseModeFooter => 'Унизу';

  @override
  String get verseModeOff => 'Вимкнено';

  @override
  String get notificationsSectionTitle => 'Сповіщення';

  @override
  String get dailyReminderToggle => 'Щоденне нагадування з віршем';

  @override
  String get reminderTimeLabel => 'Час нагадування';

  @override
  String get notificationPermissionDenied =>
      'Сповіщення вимкнено в налаштуваннях системи.';

  @override
  String get dailyReminderBody => 'Ваш вірш дня готовий.';

  @override
  String get privacySectionTitle => 'Конфіденційність';

  @override
  String get biometricLockToggle =>
      'Блокувати нотатки за допомогою Face ID / відбитка пальця';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Вимкнути рекламу';

  @override
  String get restorePurchasesButton => 'Відновити покупки';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Ще';

  @override
  String get rateAppTitle => 'Оцінити Atrament';

  @override
  String get rateAppSubtitle => 'Подобається застосунок? Залиште відгук';

  @override
  String get shareAppTitle => 'Поділитися Atrament';

  @override
  String get shareAppSubtitle => 'Розкажіть другові';

  @override
  String get shareAppMessage =>
      'Спробуйте Atrament — блокнот без відволікань із текстурами паперу.';

  @override
  String get languageSectionTitle => 'Мова';

  @override
  String get languageFollowsSystem => 'Збігається з мовою пристрою';

  @override
  String get languageSystem => 'Як у системі';

  @override
  String get languagePickerTitle => 'Вибір мови';

  @override
  String get premiumScreenTitle => 'Вимкнути рекламу';

  @override
  String get premiumHeadline => 'Пишіть без відволікань';

  @override
  String get premiumBody =>
      'Atrament безкоштовний і показує один невеликий рекламний банер. Вимкнення реклами — разова покупка, яка нічого більше не відкриває: усі функції вже доступні вам.';

  @override
  String get premiumRestoreButton => 'Відновити покупки';

  @override
  String get premiumAlreadyProMessage =>
      'Вимкнення реклами вже у вас. Дякуємо!';

  @override
  String get supportSectionTitle => 'Підтримка';

  @override
  String get shareDebugLogButton => 'Надіслати журнал налагодження';

  @override
  String get shareDebugLogSubtitle =>
      'Надішліть технічний звіт, якщо щось не працює';

  @override
  String get noDebugLogMessage => 'Поки що нічого повідомляти.';

  @override
  String get clearDebugLogButton => 'Очистити журнал налагодження';

  @override
  String get clearDebugLogTitle => 'Очистити журнал налагодження?';

  @override
  String get clearDebugLogBody =>
      'Збережений технічний звіт буде видалено з вашого пристрою.';

  @override
  String get debugLogClearedMessage => 'Журнал налагодження очищено.';

  @override
  String get premiumUnlockLabel => 'Вимкнути рекламу назавжди';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Усі';

  @override
  String get chipNotebooks => 'Блокноти';

  @override
  String get chipRecent => 'Нещодавні';

  @override
  String get emptyAllNotesTitle => 'Нотаток ще немає';

  @override
  String get emptyAllNotesBody => 'Натисніть «+», щоб написати першу нотатку.';

  @override
  String get emptyRecentNotesTitle => 'Немає нещодавніх нотаток';

  @override
  String get emptyRecentNotesBody =>
      'Тут з’являтимуться нотатки, які ви змінили.';

  @override
  String get noteActionRename => 'Перейменувати';

  @override
  String get noteActionMoveToNotebook => 'Перемістити до блокнота';

  @override
  String get noteActionEdit => 'Редагувати';

  @override
  String get noteActionExport => 'Експорт';

  @override
  String get noteActionShare => 'Поділитися';

  @override
  String get moveToNotebookTitle => 'Перемістити до блокнота';

  @override
  String get moveToNotebookEmptyBody =>
      'Інших блокнотів ще немає. Створіть блокнот, щоб упорядкувати цю нотатку.';

  @override
  String get moveToNotebookCreateRow => 'Створити новий блокнот';

  @override
  String get notebookActionRename => 'Перейменувати';

  @override
  String get notebookActionChangeCover => 'Змінити обкладинку';

  @override
  String get notebookRenameDialogTitle => 'Перейменувати блокнот';

  @override
  String get notebookCoverPickerTitle => 'Виберіть колір обкладинки';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Блокнот буде видалено разом з усіма нотатками (усього: $count). Цю дію не можна скасувати.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Правова інформація та підтримка';

  @override
  String get privacyPolicyRow => 'Політика конфіденційності';

  @override
  String get termsOfServiceRow => 'Умови користування';

  @override
  String get supportRow => 'Підтримка';

  @override
  String get openLinkFailedMessage =>
      'Не вдалося відкрити посилання. Спробуйте ще раз.';

  @override
  String get openSourceLicensesRow => 'Ліцензії з відкритим кодом';
}
