// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get errorGeneric => 'Er is iets misgegaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get save => 'Opslaan';

  @override
  String get delete => 'Verwijderen';

  @override
  String get undo => 'Ongedaan maken';

  @override
  String get redo => 'Opnieuw';

  @override
  String get untitledNote => 'Zonder titel';

  @override
  String get deleteConfirmBody => 'Dit kan niet ongedaan worden gemaakt.';

  @override
  String get deleteNoteTitle => 'Deze notitie verwijderen?';

  @override
  String deleteNotebookTitle(String name) {
    return '‘$name’ verwijderen?';
  }

  @override
  String get saveFailedMessage => 'Opslaan mislukt. Probeer het opnieuw.';

  @override
  String get exportFailedMessage =>
      'Exporteren van de notitie mislukt. Probeer het opnieuw.';

  @override
  String get shareFailedMessage =>
      'Het deelmenu kan niet worden geopend. Probeer het opnieuw.';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get searchHint => 'Notities zoeken';

  @override
  String get emptyNotebooksTitle => 'Nog geen notitieboeken';

  @override
  String get emptyNotebooksBody =>
      'Maak je eerste notitieboek om te beginnen met schrijven.';

  @override
  String get emptySearchTitle => 'Geen resultaten';

  @override
  String get emptySearchBody => 'Probeer een andere zoekterm.';

  @override
  String get emptyNotebookTitle => 'Nog geen notities';

  @override
  String get emptyNotebookBody => 'Tik op + om je eerste notitie te schrijven.';

  @override
  String get newNotebookTitle => 'Nieuw notitieboek';

  @override
  String get notebookNameHint => 'Naam van notitieboek';

  @override
  String get newNoteTitle => 'Nieuwe notitie';

  @override
  String get sortOptionsTitle => 'Sorteren';

  @override
  String get sortByModified => 'Laatst bewerkt';

  @override
  String get sortByCreated => 'Aanmaakdatum';

  @override
  String get sortByTitle => 'Titel';

  @override
  String get formatBold => 'Vet';

  @override
  String get formatItalic => 'Cursief';

  @override
  String get formatUnderline => 'Onderstreept';

  @override
  String get formatHeading => 'Kop';

  @override
  String get formatBulletList => 'Lijst met opsommingstekens';

  @override
  String get formatChecklist => 'Checklist';

  @override
  String get formatQuote => 'Citaat';

  @override
  String get formatCodeBlock => 'Codeblok';

  @override
  String get penFountainPen => 'Vulpen';

  @override
  String get penGelPen => 'Gelpen';

  @override
  String get penPencil => 'Potlood';

  @override
  String get penHighlighter => 'Markeerstift';

  @override
  String get penEraser => 'Gum';

  @override
  String get penStrokeWidth => 'Lijndikte';

  @override
  String get toggleHandwritingMode => 'Wisselen tussen typen en tekenen';

  @override
  String get biometricLockReason => 'Ontgrendel om de notitie te bekijken';

  @override
  String get noteLockedMessage => 'Deze notitie is vergrendeld';

  @override
  String get unlockButton => 'Ontgrendelen';

  @override
  String get noteLockTurnedOffMessage =>
      'Notitievergrendeling is uitgezet omdat op dit apparaat geen schermvergrendeling of biometrie is ingesteld.';

  @override
  String get biometricEnableReason =>
      'Bevestig je identiteit om notitievergrendeling aan te zetten';

  @override
  String get biometricDisableReason =>
      'Bevestig je identiteit om notitievergrendeling uit te zetten';

  @override
  String get biometricShareReason =>
      'Ontgrendel om deze notitie te delen of te exporteren';

  @override
  String get biometricAuthFailedMessage =>
      'Je identiteit kon niet worden bevestigd.';

  @override
  String get biometricSetupNeededMessage =>
      'Stel eerst een schermvergrendeling of vingerafdruk in via de apparaatinstellingen.';

  @override
  String get privacyChoicesTitle => 'Privacykeuzes';

  @override
  String get purchaseFailedMessage =>
      'De aankoop kon niet worden voltooid. Probeer het opnieuw.';

  @override
  String get restoreSuccessMessage => 'Je aankoop is hersteld.';

  @override
  String get restoreNothingFoundMessage =>
      'Geen eerdere aankoop gevonden voor dit account.';

  @override
  String get restoreFailedMessage =>
      'Aankopen konden niet worden hersteld. Controleer je verbinding en probeer het opnieuw.';

  @override
  String get reminderScheduleFailedMessage =>
      'De herinnering kon niet worden ingepland. Probeer het opnieuw.';

  @override
  String get storageIssueNotebooksLoad =>
      'Sommige notitieboeken konden niet worden geladen. Beschikbare items worden getoond.';

  @override
  String get storageIssueNotebookSave =>
      'Dit notitieboek is mogelijk niet opgeslagen. Probeer het opnieuw.';

  @override
  String get storageIssueNotebookChange =>
      'Deze wijziging is mogelijk niet opgeslagen. Probeer het opnieuw.';

  @override
  String get storageIssueNotebookDelete =>
      'Het notitieboek kon niet worden verwijderd. Probeer het opnieuw.';

  @override
  String get storageIssueNotebookOrder =>
      'De nieuwe volgorde is mogelijk niet opgeslagen. Probeer het opnieuw.';

  @override
  String get storageIssueNotesLoad =>
      'Sommige notities konden niet worden geladen. Beschikbare items worden getoond.';

  @override
  String get storageIssueSearch =>
      'Zoekresultaten kunnen op dit moment onvolledig zijn.';

  @override
  String get storageIssueNoteSave =>
      'Deze notitie is mogelijk niet opgeslagen. Controleer de opslagruimte van je apparaat.';

  @override
  String get storageIssueNoteDelete =>
      'De notitie kon niet worden verwijderd. Probeer het opnieuw.';

  @override
  String get purchaseUnavailableMessage =>
      'Deze aankoop is momenteel niet beschikbaar. Probeer het later opnieuw.';

  @override
  String get exportTitle => 'Exporteren';

  @override
  String get exportAsTxt => 'Exporteren als tekst';

  @override
  String get exportAsPdf => 'Exporteren als pdf';

  @override
  String get paperStyleSectionTitle => 'Papierstijl';

  @override
  String get paperStyleLined => 'Gelinieerd';

  @override
  String get paperStyleDotGrid => 'Stippenraster';

  @override
  String get paperStyleGrid => 'Ruitjes';

  @override
  String get paperStyleBlank => 'Blanco';

  @override
  String get paperStyleCream => 'Crème';

  @override
  String get paperStyleParchment => 'Perkament';

  @override
  String get paperStyleVellum => 'Velijn';

  @override
  String get fontSectionTitle => 'Lettertype voor notities';

  @override
  String get fontSystem => 'Systeem';

  @override
  String get fontSerif => 'Met schreef';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Weergave';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get themeParchment => 'Perkament';

  @override
  String get themeSystem => 'Systeem';

  @override
  String get verseSectionTitle => 'Weergave van het vers van de dag';

  @override
  String get verseModeWatermark => 'Watermerk';

  @override
  String get verseModeHeader => 'Koptekst';

  @override
  String get verseModeFooter => 'Voettekst';

  @override
  String get verseModeOff => 'Uit';

  @override
  String get notificationsSectionTitle => 'Meldingen';

  @override
  String get dailyReminderToggle => 'Dagelijkse versherinnering';

  @override
  String get reminderTimeLabel => 'Tijdstip van herinnering';

  @override
  String get notificationPermissionDenied =>
      'Meldingen zijn uitgezet in de systeeminstellingen.';

  @override
  String get dailyReminderBody => 'Je vers van de dag staat klaar.';

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get biometricLockToggle =>
      'Notities vergrendelen met Face ID / vingerafdruk';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Advertenties verwijderen';

  @override
  String get restorePurchasesButton => 'Aankopen herstellen';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Meer';

  @override
  String get rateAppTitle => 'Beoordeel Atrament';

  @override
  String get rateAppSubtitle => 'Bevalt de app? Laat een beoordeling achter';

  @override
  String get shareAppTitle => 'Deel Atrament';

  @override
  String get shareAppSubtitle => 'Vertel het een vriend';

  @override
  String get shareAppMessage =>
      'Probeer Atrament, een notitieblok zonder afleiding met papiertexturen.';

  @override
  String get languageSectionTitle => 'Taal';

  @override
  String get languageFollowsSystem => 'Volgt de taalinstelling van je apparaat';

  @override
  String get languageSystem => 'Systeemstandaard';

  @override
  String get languagePickerTitle => 'Kies een taal';

  @override
  String get premiumScreenTitle => 'Advertenties verwijderen';

  @override
  String get premiumHeadline => 'Schrijf zonder afleiding';

  @override
  String get premiumBody =>
      'Atrament is gratis en toont één kleine advertentiebanner. Advertenties verwijderen is een eenmalige aankoop die verder niets ontgrendelt: alle functies zijn al van jou.';

  @override
  String get premiumRestoreButton => 'Aankopen herstellen';

  @override
  String get premiumAlreadyProMessage =>
      'Je hebt “Advertenties verwijderen” al. Bedankt!';

  @override
  String get supportSectionTitle => 'Ondersteuning';

  @override
  String get shareDebugLogButton => 'Foutopsporingslogboek delen';

  @override
  String get shareDebugLogSubtitle =>
      'Stuur een technisch rapport als iets niet werkt';

  @override
  String get noDebugLogMessage => 'Er is nog niets om te melden.';

  @override
  String get clearDebugLogButton => 'Foutopsporingslogboek wissen';

  @override
  String get clearDebugLogTitle => 'Foutopsporingslogboek wissen?';

  @override
  String get clearDebugLogBody =>
      'Hiermee wordt het opgeslagen technische rapport van je apparaat verwijderd.';

  @override
  String get debugLogClearedMessage => 'Foutopsporingslogboek gewist.';

  @override
  String get premiumUnlockLabel => 'Advertenties voorgoed verwijderen';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Alles';

  @override
  String get chipNotebooks => 'Notitieboeken';

  @override
  String get chipRecent => 'Recent';

  @override
  String get emptyAllNotesTitle => 'Nog geen notities';

  @override
  String get emptyAllNotesBody => 'Tik op + om je eerste notitie te schrijven.';

  @override
  String get emptyRecentNotesTitle => 'Niets recents';

  @override
  String get emptyRecentNotesBody =>
      'Notities die je bewerkt, verschijnen hier.';

  @override
  String get noteActionRename => 'Naam wijzigen';

  @override
  String get noteActionMoveToNotebook => 'Verplaatsen naar notitieboek';

  @override
  String get noteActionEdit => 'Bewerken';

  @override
  String get noteActionExport => 'Exporteren';

  @override
  String get noteActionShare => 'Delen';

  @override
  String get moveToNotebookTitle => 'Verplaatsen naar notitieboek';

  @override
  String get moveToNotebookEmptyBody =>
      'Er zijn nog geen andere notitieboeken. Maak er een om deze notitie te ordenen.';

  @override
  String get moveToNotebookCreateRow => 'Nieuw notitieboek maken';

  @override
  String get notebookActionRename => 'Naam wijzigen';

  @override
  String get notebookActionChangeCover => 'Omslag wijzigen';

  @override
  String get notebookRenameDialogTitle => 'Notitieboek hernoemen';

  @override
  String get notebookCoverPickerTitle => 'Kies een omslagkleur';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Het notitieboek wordt verwijderd samen met al zijn notities (totaal: $count). Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Juridisch en ondersteuning';

  @override
  String get privacyPolicyRow => 'Privacybeleid';

  @override
  String get termsOfServiceRow => 'Servicevoorwaarden';

  @override
  String get supportRow => 'Ondersteuning';

  @override
  String get openLinkFailedMessage =>
      'De link kan niet worden geopend. Probeer het opnieuw.';

  @override
  String get openSourceLicensesRow => 'Opensourcelicenties';

  @override
  String get notificationChannelDescription =>
      'Je optionele dagelijkse herinnering aan een bijbelvers';
}
