// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Повторить';

  @override
  String get errorGeneric => 'Что-то пошло не так';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get undo => 'Отменить';

  @override
  String get redo => 'Вернуть';

  @override
  String get untitledNote => 'Без названия';

  @override
  String get deleteConfirmBody => 'Это действие нельзя отменить.';

  @override
  String get deleteNoteTitle => 'Удалить эту заметку?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Удалить «$name»?';
  }

  @override
  String get saveFailedMessage => 'Не удалось сохранить. Попробуйте ещё раз.';

  @override
  String get exportFailedMessage =>
      'Не удалось экспортировать заметку. Попробуйте ещё раз.';

  @override
  String get shareFailedMessage =>
      'Не удалось открыть меню «Поделиться». Попробуйте ещё раз.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get searchHint => 'Поиск по заметкам';

  @override
  String get emptyNotebooksTitle => 'Блокнотов пока нет';

  @override
  String get emptyNotebooksBody =>
      'Создайте первый блокнот, чтобы начать писать.';

  @override
  String get emptySearchTitle => 'Ничего не найдено';

  @override
  String get emptySearchBody => 'Попробуйте другой запрос.';

  @override
  String get emptyNotebookTitle => 'Заметок пока нет';

  @override
  String get emptyNotebookBody => 'Нажмите «+», чтобы написать первую заметку.';

  @override
  String get newNotebookTitle => 'Новый блокнот';

  @override
  String get notebookNameHint => 'Название блокнота';

  @override
  String get newNoteTitle => 'Новая заметка';

  @override
  String get sortOptionsTitle => 'Сортировка';

  @override
  String get sortByModified => 'По дате изменения';

  @override
  String get sortByCreated => 'По дате создания';

  @override
  String get sortByTitle => 'По названию';

  @override
  String get formatBold => 'Жирный';

  @override
  String get formatItalic => 'Курсив';

  @override
  String get formatUnderline => 'Подчёркнутый';

  @override
  String get formatHeading => 'Заголовок';

  @override
  String get formatBulletList => 'Маркированный список';

  @override
  String get formatChecklist => 'Список задач';

  @override
  String get formatQuote => 'Цитата';

  @override
  String get formatCodeBlock => 'Блок кода';

  @override
  String get penFountainPen => 'Перьевая ручка';

  @override
  String get penGelPen => 'Гелевая ручка';

  @override
  String get penPencil => 'Карандаш';

  @override
  String get penHighlighter => 'Маркер';

  @override
  String get penEraser => 'Ластик';

  @override
  String get penStrokeWidth => 'Толщина линии';

  @override
  String get toggleHandwritingMode =>
      'Переключение между набором текста и рисованием';

  @override
  String get biometricLockReason => 'Разблокируйте, чтобы просмотреть заметку';

  @override
  String get noteLockedMessage => 'Заметка заблокирована';

  @override
  String get unlockButton => 'Разблокировать';

  @override
  String get noteLockTurnedOffMessage =>
      'Блокировка заметок отключена: на этом устройстве не настроены блокировка экрана и биометрия.';

  @override
  String get biometricEnableReason =>
      'Подтвердите личность, чтобы включить блокировку заметок';

  @override
  String get biometricDisableReason =>
      'Подтвердите личность, чтобы отключить блокировку заметок';

  @override
  String get biometricShareReason =>
      'Разблокируйте, чтобы поделиться заметкой или экспортировать её';

  @override
  String get biometricAuthFailedMessage =>
      'Не удалось подтвердить вашу личность.';

  @override
  String get biometricSetupNeededMessage =>
      'Сначала настройте блокировку экрана или отпечаток пальца в настройках устройства.';

  @override
  String get privacyChoicesTitle => 'Параметры конфиденциальности';

  @override
  String get purchaseFailedMessage =>
      'Не удалось завершить покупку. Попробуйте ещё раз.';

  @override
  String get restoreSuccessMessage => 'Покупка восстановлена.';

  @override
  String get restoreNothingFoundMessage =>
      'Для этой учётной записи прежних покупок не найдено.';

  @override
  String get restoreFailedMessage =>
      'Не удалось восстановить покупки. Проверьте подключение и попробуйте ещё раз.';

  @override
  String get reminderScheduleFailedMessage =>
      'Не удалось настроить напоминание. Попробуйте ещё раз.';

  @override
  String get storageIssueNotebooksLoad =>
      'Часть блокнотов не удалось загрузить. Показано то, что доступно.';

  @override
  String get storageIssueNotebookSave =>
      'Возможно, этот блокнот не сохранён. Попробуйте ещё раз.';

  @override
  String get storageIssueNotebookChange =>
      'Возможно, это изменение не сохранено. Попробуйте ещё раз.';

  @override
  String get storageIssueNotebookDelete =>
      'Не удалось удалить блокнот. Попробуйте ещё раз.';

  @override
  String get storageIssueNotebookOrder =>
      'Возможно, новый порядок не сохранён. Попробуйте ещё раз.';

  @override
  String get storageIssueNotesLoad =>
      'Часть заметок не удалось загрузить. Показано то, что доступно.';

  @override
  String get storageIssueSearch =>
      'Сейчас результаты поиска могут быть неполными.';

  @override
  String get storageIssueNoteSave =>
      'Возможно, эта заметка не сохранена. Проверьте свободное место на устройстве.';

  @override
  String get storageIssueNoteDelete =>
      'Не удалось удалить заметку. Попробуйте ещё раз.';

  @override
  String get purchaseUnavailableMessage =>
      'Эта покупка сейчас недоступна. Попробуйте позже.';

  @override
  String get exportTitle => 'Экспорт';

  @override
  String get exportAsTxt => 'Экспорт в текст';

  @override
  String get exportAsPdf => 'Экспорт в PDF';

  @override
  String get paperStyleSectionTitle => 'Стиль бумаги';

  @override
  String get paperStyleLined => 'В линейку';

  @override
  String get paperStyleDotGrid => 'В точку';

  @override
  String get paperStyleGrid => 'В клетку';

  @override
  String get paperStyleBlank => 'Чистый лист';

  @override
  String get paperStyleCream => 'Кремовая';

  @override
  String get paperStyleParchment => 'Пергамент';

  @override
  String get paperStyleVellum => 'Веленевая';

  @override
  String get fontSectionTitle => 'Шрифт заметок';

  @override
  String get fontSystem => 'Системный';

  @override
  String get fontSerif => 'С засечками';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Оформление';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeParchment => 'Пергамент';

  @override
  String get themeSystem => 'Системная';

  @override
  String get verseSectionTitle => 'Отображение стиха дня';

  @override
  String get verseModeWatermark => 'Водяной знак';

  @override
  String get verseModeHeader => 'В верхней части';

  @override
  String get verseModeFooter => 'В нижней части';

  @override
  String get verseModeOff => 'Выключено';

  @override
  String get notificationsSectionTitle => 'Уведомления';

  @override
  String get dailyReminderToggle => 'Ежедневное напоминание со стихом';

  @override
  String get reminderTimeLabel => 'Время напоминания';

  @override
  String get notificationPermissionDenied =>
      'Уведомления отключены в настройках системы.';

  @override
  String get dailyReminderBody => 'Ваш стих дня готов.';

  @override
  String get privacySectionTitle => 'Конфиденциальность';

  @override
  String get biometricLockToggle =>
      'Блокировать заметки по Face ID / отпечатку пальца';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Отключить рекламу';

  @override
  String get restorePurchasesButton => 'Восстановить покупки';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Ещё';

  @override
  String get rateAppTitle => 'Оценить Atrament';

  @override
  String get rateAppSubtitle => 'Нравится приложение? Оставьте отзыв';

  @override
  String get shareAppTitle => 'Поделиться Atrament';

  @override
  String get shareAppSubtitle => 'Расскажите другу';

  @override
  String get shareAppMessage =>
      'Попробуйте Atrament — блокнот без отвлекающих факторов с текстурами бумаги.';

  @override
  String get languageSectionTitle => 'Язык';

  @override
  String get languageFollowsSystem => 'Совпадает с языком устройства';

  @override
  String get languageSystem => 'Как в системе';

  @override
  String get languagePickerTitle => 'Выбор языка';

  @override
  String get premiumScreenTitle => 'Отключить рекламу';

  @override
  String get premiumHeadline => 'Пишите без отвлечений';

  @override
  String get premiumBody =>
      'Atrament бесплатен и показывает один небольшой рекламный баннер. Отключение рекламы — разовая покупка, которая ничего больше не открывает: все функции уже доступны вам.';

  @override
  String get premiumRestoreButton => 'Восстановить покупки';

  @override
  String get premiumAlreadyProMessage =>
      'Отключение рекламы уже у вас. Спасибо!';

  @override
  String get supportSectionTitle => 'Поддержка';

  @override
  String get shareDebugLogButton => 'Отправить журнал отладки';

  @override
  String get shareDebugLogSubtitle =>
      'Отправьте технический отчёт, если что-то не работает';

  @override
  String get noDebugLogMessage => 'Пока нечего сообщать.';

  @override
  String get clearDebugLogButton => 'Очистить журнал отладки';

  @override
  String get clearDebugLogTitle => 'Очистить журнал отладки?';

  @override
  String get clearDebugLogBody =>
      'Сохранённый технический отчёт будет удалён с вашего устройства.';

  @override
  String get debugLogClearedMessage => 'Журнал отладки очищен.';

  @override
  String get premiumUnlockLabel => 'Отключить рекламу навсегда';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Все';

  @override
  String get chipNotebooks => 'Блокноты';

  @override
  String get chipRecent => 'Недавние';

  @override
  String get emptyAllNotesTitle => 'Заметок пока нет';

  @override
  String get emptyAllNotesBody => 'Нажмите «+», чтобы написать первую заметку.';

  @override
  String get emptyRecentNotesTitle => 'Нет недавних заметок';

  @override
  String get emptyRecentNotesBody =>
      'Здесь появятся заметки, которые вы изменили.';

  @override
  String get noteActionRename => 'Переименовать';

  @override
  String get noteActionMoveToNotebook => 'Переместить в блокнот';

  @override
  String get noteActionEdit => 'Изменить';

  @override
  String get noteActionExport => 'Экспорт';

  @override
  String get noteActionShare => 'Поделиться';

  @override
  String get moveToNotebookTitle => 'Переместить в блокнот';

  @override
  String get moveToNotebookEmptyBody =>
      'Других блокнотов пока нет. Создайте блокнот, чтобы упорядочить эту заметку.';

  @override
  String get moveToNotebookCreateRow => 'Создать новый блокнот';

  @override
  String get notebookActionRename => 'Переименовать';

  @override
  String get notebookActionChangeCover => 'Сменить обложку';

  @override
  String get notebookRenameDialogTitle => 'Переименовать блокнот';

  @override
  String get notebookCoverPickerTitle => 'Выберите цвет обложки';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Блокнот будет удалён вместе со всеми заметками (всего: $count). Это действие нельзя отменить.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Правовая информация и поддержка';

  @override
  String get privacyPolicyRow => 'Политика конфиденциальности';

  @override
  String get termsOfServiceRow => 'Условия использования';

  @override
  String get supportRow => 'Поддержка';

  @override
  String get openLinkFailedMessage =>
      'Не удалось открыть ссылку. Попробуйте ещё раз.';

  @override
  String get openSourceLicensesRow => 'Лицензии с открытым исходным кодом';

  @override
  String get notificationChannelDescription =>
      'Ваше необязательное ежедневное напоминание о стихе из Библии';
}
