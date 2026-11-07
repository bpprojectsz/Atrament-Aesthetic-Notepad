// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get errorGeneric => 'Coś poszło nie tak';

  @override
  String get cancel => 'Anuluj';

  @override
  String get save => 'Zapisz';

  @override
  String get delete => 'Usuń';

  @override
  String get undo => 'Cofnij';

  @override
  String get redo => 'Ponów';

  @override
  String get untitledNote => 'Bez tytułu';

  @override
  String get deleteConfirmBody => 'Tej czynności nie można cofnąć.';

  @override
  String get deleteNoteTitle => 'Usunąć tę notatkę?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Usunąć „$name”?';
  }

  @override
  String get saveFailedMessage => 'Nie udało się zapisać. Spróbuj ponownie.';

  @override
  String get exportFailedMessage =>
      'Nie udało się wyeksportować notatki. Spróbuj ponownie.';

  @override
  String get shareFailedMessage =>
      'Nie udało się otworzyć menu udostępniania. Spróbuj ponownie.';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get searchHint => 'Szukaj w notatkach';

  @override
  String get emptyNotebooksTitle => 'Brak notatników';

  @override
  String get emptyNotebooksBody =>
      'Utwórz pierwszy notatnik, aby zacząć pisać.';

  @override
  String get emptySearchTitle => 'Brak wyników';

  @override
  String get emptySearchBody => 'Spróbuj innej frazy.';

  @override
  String get emptyNotebookTitle => 'Brak notatek';

  @override
  String get emptyNotebookBody => 'Naciśnij +, aby napisać pierwszą notatkę.';

  @override
  String get newNotebookTitle => 'Nowy notatnik';

  @override
  String get notebookNameHint => 'Nazwa notatnika';

  @override
  String get newNoteTitle => 'Nowa notatka';

  @override
  String get sortOptionsTitle => 'Sortowanie';

  @override
  String get sortByModified => 'Ostatnio edytowane';

  @override
  String get sortByCreated => 'Data utworzenia';

  @override
  String get sortByTitle => 'Tytuł';

  @override
  String get formatBold => 'Pogrubienie';

  @override
  String get formatItalic => 'Kursywa';

  @override
  String get formatUnderline => 'Podkreślenie';

  @override
  String get formatHeading => 'Nagłówek';

  @override
  String get formatBulletList => 'Lista punktowana';

  @override
  String get formatChecklist => 'Lista zadań';

  @override
  String get formatQuote => 'Cytat';

  @override
  String get formatCodeBlock => 'Blok kodu';

  @override
  String get penFountainPen => 'Pióro wieczne';

  @override
  String get penGelPen => 'Długopis żelowy';

  @override
  String get penPencil => 'Ołówek';

  @override
  String get penHighlighter => 'Zakreślacz';

  @override
  String get penEraser => 'Gumka';

  @override
  String get penStrokeWidth => 'Grubość linii';

  @override
  String get toggleHandwritingMode => 'Przełącz między pisaniem a rysowaniem';

  @override
  String get biometricLockReason => 'Odblokuj, aby wyświetlić notatkę';

  @override
  String get noteLockedMessage => 'Ta notatka jest zablokowana';

  @override
  String get unlockButton => 'Odblokuj';

  @override
  String get noteLockTurnedOffMessage =>
      'Blokada notatek została wyłączona, ponieważ to urządzenie nie ma skonfigurowanej blokady ekranu ani biometrii.';

  @override
  String get biometricEnableReason =>
      'Potwierdź tożsamość, aby włączyć blokadę notatek';

  @override
  String get biometricDisableReason =>
      'Potwierdź tożsamość, aby wyłączyć blokadę notatek';

  @override
  String get biometricShareReason =>
      'Odblokuj, aby udostępnić lub wyeksportować notatkę';

  @override
  String get biometricAuthFailedMessage =>
      'Nie udało się potwierdzić Twojej tożsamości.';

  @override
  String get biometricSetupNeededMessage =>
      'Najpierw skonfiguruj blokadę ekranu lub odcisk palca w ustawieniach urządzenia.';

  @override
  String get privacyChoicesTitle => 'Ustawienia prywatności';

  @override
  String get purchaseFailedMessage =>
      'Nie udało się dokończyć zakupu. Spróbuj ponownie.';

  @override
  String get restoreSuccessMessage => 'Zakup został przywrócony.';

  @override
  String get restoreNothingFoundMessage =>
      'Nie znaleziono wcześniejszych zakupów dla tego konta.';

  @override
  String get restoreFailedMessage =>
      'Nie udało się przywrócić zakupów. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get reminderScheduleFailedMessage =>
      'Nie udało się ustawić przypomnienia. Spróbuj ponownie.';

  @override
  String get storageIssueNotebooksLoad =>
      'Nie udało się wczytać części notatników. Wyświetlane są dostępne dane.';

  @override
  String get storageIssueNotebookSave =>
      'Ten notatnik mógł nie zostać zapisany. Spróbuj ponownie.';

  @override
  String get storageIssueNotebookChange =>
      'Ta zmiana mogła nie zostać zapisana. Spróbuj ponownie.';

  @override
  String get storageIssueNotebookDelete =>
      'Nie udało się usunąć notatnika. Spróbuj ponownie.';

  @override
  String get storageIssueNotebookOrder =>
      'Nowa kolejność mogła nie zostać zapisana. Spróbuj ponownie.';

  @override
  String get storageIssueNotesLoad =>
      'Nie udało się wczytać części notatek. Wyświetlane są dostępne dane.';

  @override
  String get storageIssueSearch =>
      'Wyniki wyszukiwania mogą być teraz niekompletne.';

  @override
  String get storageIssueNoteSave =>
      'Ta notatka mogła nie zostać zapisana. Sprawdź miejsce na urządzeniu.';

  @override
  String get storageIssueNoteDelete =>
      'Nie udało się usunąć notatki. Spróbuj ponownie.';

  @override
  String get purchaseUnavailableMessage =>
      'Ten zakup jest teraz niedostępny. Spróbuj ponownie później.';

  @override
  String get exportTitle => 'Eksport';

  @override
  String get exportAsTxt => 'Eksportuj jako tekst';

  @override
  String get exportAsPdf => 'Eksportuj jako PDF';

  @override
  String get paperStyleSectionTitle => 'Styl papieru';

  @override
  String get paperStyleLined => 'W linie';

  @override
  String get paperStyleDotGrid => 'W kropki';

  @override
  String get paperStyleGrid => 'W kratkę';

  @override
  String get paperStyleBlank => 'Czysty';

  @override
  String get paperStyleCream => 'Kremowy';

  @override
  String get paperStyleParchment => 'Pergamin';

  @override
  String get paperStyleVellum => 'Welin';

  @override
  String get fontSectionTitle => 'Czcionka notatek';

  @override
  String get fontSystem => 'Systemowa';

  @override
  String get fontSerif => 'Szeryfowa';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Wygląd';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get themeParchment => 'Pergamin';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get verseSectionTitle => 'Wyświetlanie wersetu dnia';

  @override
  String get verseModeWatermark => 'Znak wodny';

  @override
  String get verseModeHeader => 'Nagłówek strony';

  @override
  String get verseModeFooter => 'Stopka';

  @override
  String get verseModeOff => 'Wyłączone';

  @override
  String get notificationsSectionTitle => 'Powiadomienia';

  @override
  String get dailyReminderToggle => 'Codzienne przypomnienie o wersecie';

  @override
  String get reminderTimeLabel => 'Godzina przypomnienia';

  @override
  String get notificationPermissionDenied =>
      'Powiadomienia są wyłączone w ustawieniach systemu.';

  @override
  String get dailyReminderBody => 'Twój werset dnia jest gotowy.';

  @override
  String get privacySectionTitle => 'Prywatność';

  @override
  String get biometricLockToggle =>
      'Blokuj notatki za pomocą Face ID / odcisku palca';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Usuń reklamy';

  @override
  String get restorePurchasesButton => 'Przywróć zakupy';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Więcej';

  @override
  String get rateAppTitle => 'Oceń Atrament';

  @override
  String get rateAppSubtitle => 'Podoba Ci się aplikacja? Zostaw opinię';

  @override
  String get shareAppTitle => 'Udostępnij Atrament';

  @override
  String get shareAppSubtitle => 'Powiedz znajomemu';

  @override
  String get shareAppMessage =>
      'Wypróbuj Atrament — notatnik bez rozpraszaczy z teksturami papieru.';

  @override
  String get languageSectionTitle => 'Język';

  @override
  String get languageFollowsSystem => 'Zgodny z językiem urządzenia';

  @override
  String get languageSystem => 'Domyślny systemowy';

  @override
  String get languagePickerTitle => 'Wybierz język';

  @override
  String get premiumScreenTitle => 'Usuń reklamy';

  @override
  String get premiumHeadline => 'Pisz bez rozproszeń';

  @override
  String get premiumBody =>
      'Atrament jest bezpłatny i pokazuje jeden mały baner reklamowy. Usunięcie reklam to jednorazowy zakup, który niczego innego nie odblokowuje — wszystkie funkcje są już Twoje.';

  @override
  String get premiumRestoreButton => 'Przywróć zakupy';

  @override
  String get premiumAlreadyProMessage =>
      'Masz już opcję „Usuń reklamy”. Dziękujemy!';

  @override
  String get supportSectionTitle => 'Pomoc';

  @override
  String get shareDebugLogButton => 'Udostępnij dziennik debugowania';

  @override
  String get shareDebugLogSubtitle =>
      'Wyślij raport techniczny, jeśli coś nie działa';

  @override
  String get noDebugLogMessage => 'Nie ma jeszcze nic do zgłoszenia.';

  @override
  String get clearDebugLogButton => 'Wyczyść dziennik debugowania';

  @override
  String get clearDebugLogTitle => 'Wyczyścić dziennik debugowania?';

  @override
  String get clearDebugLogBody =>
      'Zapisany raport techniczny zostanie usunięty z urządzenia.';

  @override
  String get debugLogClearedMessage =>
      'Dziennik debugowania został wyczyszczony.';

  @override
  String get premiumUnlockLabel => 'Usuń reklamy na zawsze';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Wszystkie';

  @override
  String get chipNotebooks => 'Notatniki';

  @override
  String get chipRecent => 'Ostatnie';

  @override
  String get emptyAllNotesTitle => 'Brak notatek';

  @override
  String get emptyAllNotesBody => 'Naciśnij +, aby napisać pierwszą notatkę.';

  @override
  String get emptyRecentNotesTitle => 'Brak ostatnich notatek';

  @override
  String get emptyRecentNotesBody =>
      'Tutaj pojawią się edytowane przez Ciebie notatki.';

  @override
  String get noteActionRename => 'Zmień nazwę';

  @override
  String get noteActionMoveToNotebook => 'Przenieś do notatnika';

  @override
  String get noteActionEdit => 'Edytuj';

  @override
  String get noteActionExport => 'Eksportuj';

  @override
  String get noteActionShare => 'Udostępnij';

  @override
  String get moveToNotebookTitle => 'Przenieś do notatnika';

  @override
  String get moveToNotebookEmptyBody =>
      'Nie ma jeszcze innych notatników. Utwórz notatnik, aby uporządkować tę notatkę.';

  @override
  String get moveToNotebookCreateRow => 'Utwórz nowy notatnik';

  @override
  String get notebookActionRename => 'Zmień nazwę';

  @override
  String get notebookActionChangeCover => 'Zmień okładkę';

  @override
  String get notebookRenameDialogTitle => 'Zmień nazwę notatnika';

  @override
  String get notebookCoverPickerTitle => 'Wybierz kolor okładki';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Notatnik zostanie usunięty razem ze wszystkimi notatkami (łącznie: $count). Tej czynności nie można cofnąć.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Informacje prawne i pomoc';

  @override
  String get privacyPolicyRow => 'Polityka prywatności';

  @override
  String get termsOfServiceRow => 'Warunki korzystania z usługi';

  @override
  String get supportRow => 'Pomoc';

  @override
  String get openLinkFailedMessage =>
      'Nie udało się otworzyć łącza. Spróbuj ponownie.';

  @override
  String get openSourceLicensesRow => 'Licencje open source';
}
