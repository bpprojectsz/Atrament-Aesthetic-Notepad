// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Skúsiť znova';

  @override
  String get errorGeneric => 'Niečo sa pokazilo';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get save => 'Uložiť';

  @override
  String get delete => 'Odstrániť';

  @override
  String get undo => 'Späť';

  @override
  String get redo => 'Znova';

  @override
  String get untitledNote => 'Bez názvu';

  @override
  String get deleteConfirmBody => 'Túto akciu nie je možné vrátiť späť.';

  @override
  String get deleteNoteTitle => 'Odstrániť túto poznámku?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Odstrániť „$name“?';
  }

  @override
  String get saveFailedMessage => 'Uloženie zlyhalo. Skúste to znova.';

  @override
  String get exportFailedMessage => 'Export poznámky zlyhal. Skúste to znova.';

  @override
  String get shareFailedMessage =>
      'Ponuku zdieľania sa nepodarilo otvoriť. Skúste to znova.';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get searchHint => 'Hľadať v poznámkach';

  @override
  String get emptyNotebooksTitle => 'Zatiaľ žiadne zápisníky';

  @override
  String get emptyNotebooksBody => 'Vytvorte prvý zápisník a začnite písať.';

  @override
  String get emptySearchTitle => 'Nenašli sa žiadne výsledky';

  @override
  String get emptySearchBody => 'Skúste iný hľadaný výraz.';

  @override
  String get emptyNotebookTitle => 'Zatiaľ žiadne poznámky';

  @override
  String get emptyNotebookBody => 'Klepnutím na + napíšete prvú poznámku.';

  @override
  String get newNotebookTitle => 'Nový zápisník';

  @override
  String get notebookNameHint => 'Názov zápisníka';

  @override
  String get newNoteTitle => 'Nová poznámka';

  @override
  String get sortOptionsTitle => 'Zoradenie';

  @override
  String get sortByModified => 'Naposledy upravené';

  @override
  String get sortByCreated => 'Dátum vytvorenia';

  @override
  String get sortByTitle => 'Názov';

  @override
  String get formatBold => 'Tučné';

  @override
  String get formatItalic => 'Kurzíva';

  @override
  String get formatUnderline => 'Podčiarknuté';

  @override
  String get formatHeading => 'Nadpis';

  @override
  String get formatBulletList => 'Odrážkový zoznam';

  @override
  String get formatChecklist => 'Zoznam úloh';

  @override
  String get formatQuote => 'Citát';

  @override
  String get formatCodeBlock => 'Blok kódu';

  @override
  String get penFountainPen => 'Plniace pero';

  @override
  String get penGelPen => 'Gélové pero';

  @override
  String get penPencil => 'Ceruzka';

  @override
  String get penHighlighter => 'Zvýrazňovač';

  @override
  String get penEraser => 'Guma';

  @override
  String get penStrokeWidth => 'Hrúbka čiary';

  @override
  String get toggleHandwritingMode => 'Prepnúť medzi písaním a kreslením';

  @override
  String get biometricLockReason => 'Odomknite a zobrazte poznámku';

  @override
  String get noteLockedMessage => 'Táto poznámka je zamknutá';

  @override
  String get unlockButton => 'Odomknúť';

  @override
  String get noteLockTurnedOffMessage =>
      'Zámok poznámok bol vypnutý, pretože toto zariadenie nemá nastavený zámok obrazovky ani biometriu.';

  @override
  String get biometricEnableReason =>
      'Potvrďte svoju totožnosť a zapnite zámok poznámok';

  @override
  String get biometricDisableReason =>
      'Potvrďte svoju totožnosť a vypnite zámok poznámok';

  @override
  String get biometricShareReason =>
      'Odomknite a poznámku zdieľajte alebo exportujte';

  @override
  String get biometricAuthFailedMessage =>
      'Vašu totožnosť sa nepodarilo overiť.';

  @override
  String get biometricSetupNeededMessage =>
      'Najprv v nastaveniach zariadenia nastavte zámok obrazovky alebo odtlačok prsta.';

  @override
  String get privacyChoicesTitle => 'Možnosti ochrany osobných údajov';

  @override
  String get purchaseFailedMessage =>
      'Nákup sa nepodarilo dokončiť. Skúste to znova.';

  @override
  String get restoreSuccessMessage => 'Váš nákup bol obnovený.';

  @override
  String get restoreNothingFoundMessage =>
      'Pre tento účet sa nenašiel žiadny predchádzajúci nákup.';

  @override
  String get restoreFailedMessage =>
      'Nákupy sa nepodarilo obnoviť. Skontrolujte pripojenie a skúste to znova.';

  @override
  String get reminderScheduleFailedMessage =>
      'Pripomenutie sa nepodarilo naplánovať. Skúste to znova.';

  @override
  String get storageIssueNotebooksLoad =>
      'Niektoré zápisníky sa nepodarilo načítať. Zobrazuje sa, čo je k dispozícii.';

  @override
  String get storageIssueNotebookSave =>
      'Tento zápisník možno nebol uložený. Skúste to znova.';

  @override
  String get storageIssueNotebookChange =>
      'Táto zmena možno nebola uložená. Skúste to znova.';

  @override
  String get storageIssueNotebookDelete =>
      'Zápisník sa nepodarilo odstrániť. Skúste to znova.';

  @override
  String get storageIssueNotebookOrder =>
      'Nové poradie možno nebolo uložené. Skúste to znova.';

  @override
  String get storageIssueNotesLoad =>
      'Niektoré poznámky sa nepodarilo načítať. Zobrazuje sa, čo je k dispozícii.';

  @override
  String get storageIssueSearch => 'Výsledky hľadania môžu byť teraz neúplné.';

  @override
  String get storageIssueNoteSave =>
      'Táto poznámka možno nebola uložená. Skontrolujte úložisko zariadenia.';

  @override
  String get storageIssueNoteDelete =>
      'Poznámku sa nepodarilo odstrániť. Skúste to znova.';

  @override
  String get purchaseUnavailableMessage =>
      'Tento nákup teraz nie je dostupný. Skúste to neskôr.';

  @override
  String get exportTitle => 'Export';

  @override
  String get exportAsTxt => 'Exportovať ako text';

  @override
  String get exportAsPdf => 'Exportovať ako PDF';

  @override
  String get paperStyleSectionTitle => 'Štýl papiera';

  @override
  String get paperStyleLined => 'Linajkovaný';

  @override
  String get paperStyleDotGrid => 'Bodkovaný';

  @override
  String get paperStyleGrid => 'Štvorčekovaný';

  @override
  String get paperStyleBlank => 'Prázdny';

  @override
  String get paperStyleCream => 'Krémový';

  @override
  String get paperStyleParchment => 'Pergamen';

  @override
  String get paperStyleVellum => 'Velín';

  @override
  String get fontSectionTitle => 'Písmo poznámok';

  @override
  String get fontSystem => 'Systémové';

  @override
  String get fontSerif => 'Pätkové';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Vzhľad';

  @override
  String get themeLight => 'Svetlý';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get themeParchment => 'Pergamen';

  @override
  String get themeSystem => 'Systémový';

  @override
  String get verseSectionTitle => 'Zobrazenie verša dňa';

  @override
  String get verseModeWatermark => 'Vodoznak';

  @override
  String get verseModeHeader => 'Hlavička';

  @override
  String get verseModeFooter => 'Pätička';

  @override
  String get verseModeOff => 'Vypnuté';

  @override
  String get notificationsSectionTitle => 'Upozornenia';

  @override
  String get dailyReminderToggle => 'Denné pripomenutie verša';

  @override
  String get reminderTimeLabel => 'Čas pripomenutia';

  @override
  String get notificationPermissionDenied =>
      'Upozornenia sú vypnuté v nastaveniach systému.';

  @override
  String get dailyReminderBody => 'Váš verš dňa je pripravený.';

  @override
  String get privacySectionTitle => 'Súkromie';

  @override
  String get biometricLockToggle =>
      'Zamykať poznámky pomocou Face ID / odtlačku prsta';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Odstrániť reklamy';

  @override
  String get restorePurchasesButton => 'Obnoviť nákupy';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Viac';

  @override
  String get rateAppTitle => 'Ohodnotiť Atrament';

  @override
  String get rateAppSubtitle => 'Páči sa vám aplikácia? Zanechajte hodnotenie';

  @override
  String get shareAppTitle => 'Zdieľať Atrament';

  @override
  String get shareAppSubtitle => 'Povedzte to kamarátovi';

  @override
  String get shareAppMessage =>
      'Vyskúšajte Atrament — zápisník bez rušivých prvkov s textúrami papiera.';

  @override
  String get languageSectionTitle => 'Jazyk';

  @override
  String get languageFollowsSystem => 'Riadi sa jazykom zariadenia';

  @override
  String get languageSystem => 'Predvolený systémový';

  @override
  String get languagePickerTitle => 'Vyberte jazyk';

  @override
  String get premiumScreenTitle => 'Odstrániť reklamy';

  @override
  String get premiumHeadline => 'Píšte bez vyrušovania';

  @override
  String get premiumBody =>
      'Atrament je zadarmo a zobrazuje jeden malý reklamný banner. Odstránenie reklám je jednorazový nákup, ktorý nič ďalšie neodomyká — všetky funkcie už máte.';

  @override
  String get premiumRestoreButton => 'Obnoviť nákupy';

  @override
  String get premiumAlreadyProMessage =>
      'Odstránenie reklám už máte. Ďakujeme!';

  @override
  String get supportSectionTitle => 'Podpora';

  @override
  String get shareDebugLogButton => 'Zdieľať ladiaci protokol';

  @override
  String get shareDebugLogSubtitle =>
      'Ak niečo nefunguje, pošlite technickú správu';

  @override
  String get noDebugLogMessage => 'Zatiaľ nie je čo hlásiť.';

  @override
  String get clearDebugLogButton => 'Vymazať ladiaci protokol';

  @override
  String get clearDebugLogTitle => 'Vymazať ladiaci protokol?';

  @override
  String get clearDebugLogBody =>
      'Tým sa uložená technická správa odstráni z vášho zariadenia.';

  @override
  String get debugLogClearedMessage => 'Ladiaci protokol bol vymazaný.';

  @override
  String get premiumUnlockLabel => 'Odstrániť reklamy navždy';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Všetky';

  @override
  String get chipNotebooks => 'Zápisníky';

  @override
  String get chipRecent => 'Nedávne';

  @override
  String get emptyAllNotesTitle => 'Zatiaľ žiadne poznámky';

  @override
  String get emptyAllNotesBody => 'Klepnutím na + napíšete prvú poznámku.';

  @override
  String get emptyRecentNotesTitle => 'Nič nedávne';

  @override
  String get emptyRecentNotesBody => 'Tu sa zobrazia poznámky, ktoré upravíte.';

  @override
  String get noteActionRename => 'Premenovať';

  @override
  String get noteActionMoveToNotebook => 'Presunúť do zápisníka';

  @override
  String get noteActionEdit => 'Upraviť';

  @override
  String get noteActionExport => 'Exportovať';

  @override
  String get noteActionShare => 'Zdieľať';

  @override
  String get moveToNotebookTitle => 'Presunúť do zápisníka';

  @override
  String get moveToNotebookEmptyBody =>
      'Zatiaľ nie sú žiadne ďalšie zápisníky. Vytvorte jeden a poznámku si usporiadajte.';

  @override
  String get moveToNotebookCreateRow => 'Vytvoriť nový zápisník';

  @override
  String get notebookActionRename => 'Premenovať';

  @override
  String get notebookActionChangeCover => 'Zmeniť obálku';

  @override
  String get notebookRenameDialogTitle => 'Premenovať zápisník';

  @override
  String get notebookCoverPickerTitle => 'Vyberte farbu obálky';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Zápisník bude odstránený vrátane všetkých poznámok (spolu: $count). Túto akciu nie je možné vrátiť späť.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Právne informácie a podpora';

  @override
  String get privacyPolicyRow => 'Zásady ochrany osobných údajov';

  @override
  String get termsOfServiceRow => 'Zmluvné podmienky';

  @override
  String get supportRow => 'Podpora';

  @override
  String get openLinkFailedMessage =>
      'Odkaz sa nepodarilo otvoriť. Skúste to znova.';

  @override
  String get openSourceLicensesRow => 'Licencie open source';
}
