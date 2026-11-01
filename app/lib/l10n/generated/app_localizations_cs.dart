// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get errorGeneric => 'Něco se nepovedlo';

  @override
  String get cancel => 'Zrušit';

  @override
  String get save => 'Uložit';

  @override
  String get delete => 'Smazat';

  @override
  String get undo => 'Zpět';

  @override
  String get redo => 'Znovu';

  @override
  String get untitledNote => 'Bez názvu';

  @override
  String get deleteConfirmBody => 'Tuto akci nelze vrátit zpět.';

  @override
  String get deleteNoteTitle => 'Smazat tuto poznámku?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Smazat „$name“?';
  }

  @override
  String get saveFailedMessage => 'Uložení se nezdařilo. Zkuste to znovu.';

  @override
  String get exportFailedMessage =>
      'Export poznámky se nezdařil. Zkuste to znovu.';

  @override
  String get shareFailedMessage =>
      'Nepodařilo se otevřít nabídku sdílení. Zkuste to znovu.';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get searchHint => 'Hledat v poznámkách';

  @override
  String get emptyNotebooksTitle => 'Zatím žádné zápisníky';

  @override
  String get emptyNotebooksBody => 'Vytvořte první zápisník a začněte psát.';

  @override
  String get emptySearchTitle => 'Nic nenalezeno';

  @override
  String get emptySearchBody => 'Zkuste jiný hledaný výraz.';

  @override
  String get emptyNotebookTitle => 'Zatím žádné poznámky';

  @override
  String get emptyNotebookBody => 'Klepnutím na + napíšete první poznámku.';

  @override
  String get newNotebookTitle => 'Nový zápisník';

  @override
  String get notebookNameHint => 'Název zápisníku';

  @override
  String get newNoteTitle => 'Nová poznámka';

  @override
  String get sortOptionsTitle => 'Řazení';

  @override
  String get sortByModified => 'Naposledy upraveno';

  @override
  String get sortByCreated => 'Datum vytvoření';

  @override
  String get sortByTitle => 'Název';

  @override
  String get formatBold => 'Tučné';

  @override
  String get formatItalic => 'Kurzíva';

  @override
  String get formatUnderline => 'Podtržené';

  @override
  String get formatHeading => 'Nadpis';

  @override
  String get formatBulletList => 'Odrážkový seznam';

  @override
  String get formatChecklist => 'Seznam úkolů';

  @override
  String get formatQuote => 'Citace';

  @override
  String get formatCodeBlock => 'Blok kódu';

  @override
  String get penFountainPen => 'Plnicí pero';

  @override
  String get penGelPen => 'Gelové pero';

  @override
  String get penPencil => 'Tužka';

  @override
  String get penHighlighter => 'Zvýrazňovač';

  @override
  String get penEraser => 'Guma';

  @override
  String get penStrokeWidth => 'Tloušťka čáry';

  @override
  String get toggleHandwritingMode => 'Přepnout mezi psaním a kreslením';

  @override
  String get biometricLockReason => 'Odemkněte a zobrazte poznámku';

  @override
  String get noteLockedMessage => 'Tato poznámka je zamčená';

  @override
  String get unlockButton => 'Odemknout';

  @override
  String get noteLockTurnedOffMessage =>
      'Zámek poznámek byl vypnut, protože toto zařízení nemá nastavený zámek obrazovky ani biometrii.';

  @override
  String get biometricEnableReason =>
      'Potvrďte svou totožnost a zapněte zámek poznámek';

  @override
  String get biometricDisableReason =>
      'Potvrďte svou totožnost a vypněte zámek poznámek';

  @override
  String get biometricShareReason =>
      'Odemkněte a poznámku sdílejte nebo exportujte';

  @override
  String get biometricAuthFailedMessage =>
      'Vaši totožnost se nepodařilo ověřit.';

  @override
  String get biometricSetupNeededMessage =>
      'Nejprve v nastavení zařízení nastavte zámek obrazovky nebo otisk prstu.';

  @override
  String get privacyChoicesTitle => 'Možnosti ochrany soukromí';

  @override
  String get purchaseFailedMessage =>
      'Nákup se nepodařilo dokončit. Zkuste to znovu.';

  @override
  String get restoreSuccessMessage => 'Váš nákup byl obnoven.';

  @override
  String get restoreNothingFoundMessage =>
      'Pro tento účet nebyl nalezen žádný dřívější nákup.';

  @override
  String get restoreFailedMessage =>
      'Nákupy se nepodařilo obnovit. Zkontrolujte připojení a zkuste to znovu.';

  @override
  String get reminderScheduleFailedMessage =>
      'Připomenutí se nepodařilo naplánovat. Zkuste to znovu.';

  @override
  String get storageIssueNotebooksLoad =>
      'Některé zápisníky se nepodařilo načíst. Zobrazuje se, co je k dispozici.';

  @override
  String get storageIssueNotebookSave =>
      'Tento zápisník možná nebyl uložen. Zkuste to znovu.';

  @override
  String get storageIssueNotebookChange =>
      'Tato změna možná nebyla uložena. Zkuste to znovu.';

  @override
  String get storageIssueNotebookDelete =>
      'Zápisník se nepodařilo smazat. Zkuste to znovu.';

  @override
  String get storageIssueNotebookOrder =>
      'Nové pořadí možná nebylo uloženo. Zkuste to znovu.';

  @override
  String get storageIssueNotesLoad =>
      'Některé poznámky se nepodařilo načíst. Zobrazuje se, co je k dispozici.';

  @override
  String get storageIssueSearch => 'Výsledky hledání mohou být teď neúplné.';

  @override
  String get storageIssueNoteSave =>
      'Tato poznámka možná nebyla uložena. Zkontrolujte úložiště zařízení.';

  @override
  String get storageIssueNoteDelete =>
      'Poznámku se nepodařilo smazat. Zkuste to znovu.';

  @override
  String get purchaseUnavailableMessage =>
      'Tento nákup teď není dostupný. Zkuste to později.';

  @override
  String get exportTitle => 'Export';

  @override
  String get exportAsTxt => 'Exportovat jako text';

  @override
  String get exportAsPdf => 'Exportovat jako PDF';

  @override
  String get paperStyleSectionTitle => 'Styl papíru';

  @override
  String get paperStyleLined => 'Linkovaný';

  @override
  String get paperStyleDotGrid => 'Tečkovaný';

  @override
  String get paperStyleGrid => 'Čtverečkovaný';

  @override
  String get paperStyleBlank => 'Prázdný';

  @override
  String get paperStyleCream => 'Krémový';

  @override
  String get paperStyleParchment => 'Pergamen';

  @override
  String get paperStyleVellum => 'Velín';

  @override
  String get fontSectionTitle => 'Písmo poznámek';

  @override
  String get fontSystem => 'Systémové';

  @override
  String get fontSerif => 'Patkové';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Vzhled';

  @override
  String get themeLight => 'Světlý';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get themeParchment => 'Pergamen';

  @override
  String get themeSystem => 'Systémový';

  @override
  String get verseSectionTitle => 'Zobrazení verše dne';

  @override
  String get verseModeWatermark => 'Vodoznak';

  @override
  String get verseModeHeader => 'Záhlaví';

  @override
  String get verseModeFooter => 'Zápatí';

  @override
  String get verseModeOff => 'Vypnuto';

  @override
  String get notificationsSectionTitle => 'Oznámení';

  @override
  String get dailyReminderToggle => 'Denní připomenutí verše';

  @override
  String get reminderTimeLabel => 'Čas připomenutí';

  @override
  String get notificationPermissionDenied =>
      'Oznámení jsou vypnutá v nastavení systému.';

  @override
  String get dailyReminderBody => 'Váš verš dne je připraven.';

  @override
  String get privacySectionTitle => 'Soukromí';

  @override
  String get biometricLockToggle =>
      'Zamykat poznámky pomocí Face ID / otisku prstu';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Odstranit reklamy';

  @override
  String get restorePurchasesButton => 'Obnovit nákupy';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Více';

  @override
  String get rateAppTitle => 'Ohodnotit Atrament';

  @override
  String get rateAppSubtitle => 'Líbí se vám aplikace? Zanechte hodnocení';

  @override
  String get shareAppTitle => 'Sdílet Atrament';

  @override
  String get shareAppSubtitle => 'Řekněte to kamarádovi';

  @override
  String get shareAppMessage =>
      'Vyzkoušejte Atrament — zápisník bez rušivých prvků s texturami papíru.';

  @override
  String get languageSectionTitle => 'Jazyk';

  @override
  String get languageFollowsSystem => 'Řídí se jazykem zařízení';

  @override
  String get languageSystem => 'Výchozí systémový';

  @override
  String get languagePickerTitle => 'Vyberte jazyk';

  @override
  String get premiumScreenTitle => 'Odstranit reklamy';

  @override
  String get premiumHeadline => 'Pište bez vyrušování';

  @override
  String get premiumBody =>
      'Atrament je zdarma a zobrazuje jeden malý reklamní banner. Odstranění reklam je jednorázový nákup, který nic dalšího neodemyká — všechny funkce už máte.';

  @override
  String get premiumRestoreButton => 'Obnovit nákupy';

  @override
  String get premiumAlreadyProMessage => 'Odstranění reklam už máte. Děkujeme!';

  @override
  String get supportSectionTitle => 'Podpora';

  @override
  String get shareDebugLogButton => 'Sdílet ladicí protokol';

  @override
  String get shareDebugLogSubtitle =>
      'Pokud něco nefunguje, pošlete technickou zprávu';

  @override
  String get noDebugLogMessage => 'Zatím není co hlásit.';

  @override
  String get clearDebugLogButton => 'Vymazat ladicí protokol';

  @override
  String get clearDebugLogTitle => 'Vymazat ladicí protokol?';

  @override
  String get clearDebugLogBody =>
      'Tím se uložená technická zpráva odstraní z vašeho zařízení.';

  @override
  String get debugLogClearedMessage => 'Ladicí protokol byl vymazán.';

  @override
  String get premiumUnlockLabel => 'Odstranit reklamy navždy';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Vše';

  @override
  String get chipNotebooks => 'Zápisníky';

  @override
  String get chipRecent => 'Nedávné';

  @override
  String get emptyAllNotesTitle => 'Zatím žádné poznámky';

  @override
  String get emptyAllNotesBody => 'Klepnutím na + napíšete první poznámku.';

  @override
  String get emptyRecentNotesTitle => 'Nic nedávného';

  @override
  String get emptyRecentNotesBody => 'Zde se zobrazí poznámky, které upravíte.';

  @override
  String get noteActionRename => 'Přejmenovat';

  @override
  String get noteActionMoveToNotebook => 'Přesunout do zápisníku';

  @override
  String get noteActionEdit => 'Upravit';

  @override
  String get noteActionExport => 'Exportovat';

  @override
  String get noteActionShare => 'Sdílet';

  @override
  String get moveToNotebookTitle => 'Přesunout do zápisníku';

  @override
  String get moveToNotebookEmptyBody =>
      'Zatím nejsou žádné další zápisníky. Vytvořte jeden a poznámku si uspořádejte.';

  @override
  String get moveToNotebookCreateRow => 'Vytvořit nový zápisník';

  @override
  String get notebookActionRename => 'Přejmenovat';

  @override
  String get notebookActionChangeCover => 'Změnit obálku';

  @override
  String get notebookRenameDialogTitle => 'Přejmenovat zápisník';

  @override
  String get notebookCoverPickerTitle => 'Vyberte barvu obálky';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Zápisník bude smazán včetně všech poznámek (celkem: $count). Tuto akci nelze vrátit zpět.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Právní informace a podpora';

  @override
  String get privacyPolicyRow => 'Zásady ochrany osobních údajů';

  @override
  String get termsOfServiceRow => 'Podmínky služby';

  @override
  String get supportRow => 'Podpora';

  @override
  String get openLinkFailedMessage =>
      'Odkaz se nepodařilo otevřít. Zkuste to znovu.';

  @override
  String get openSourceLicensesRow => 'Open source licence';
}
