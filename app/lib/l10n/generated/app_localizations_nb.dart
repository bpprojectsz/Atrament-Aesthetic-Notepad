// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get errorGeneric => 'Noe gikk galt';

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Lagre';

  @override
  String get delete => 'Slett';

  @override
  String get undo => 'Angre';

  @override
  String get redo => 'Gjør om';

  @override
  String get untitledNote => 'Uten tittel';

  @override
  String get deleteConfirmBody => 'Denne handlingen kan ikke angres.';

  @override
  String get deleteNoteTitle => 'Vil du slette dette notatet?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Vil du slette «$name»?';
  }

  @override
  String get saveFailedMessage => 'Kunne ikke lagre. Prøv igjen.';

  @override
  String get exportFailedMessage =>
      'Kunne ikke eksportere notatet. Prøv igjen.';

  @override
  String get shareFailedMessage => 'Kunne ikke åpne delingsmenyen. Prøv igjen.';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get searchHint => 'Søk i notater';

  @override
  String get emptyNotebooksTitle => 'Ingen notatbøker ennå';

  @override
  String get emptyNotebooksBody =>
      'Opprett din første notatbok for å begynne å skrive.';

  @override
  String get emptySearchTitle => 'Ingen resultater';

  @override
  String get emptySearchBody => 'Prøv et annet søkeord.';

  @override
  String get emptyNotebookTitle => 'Ingen notater ennå';

  @override
  String get emptyNotebookBody => 'Trykk på + for å skrive ditt første notat.';

  @override
  String get newNotebookTitle => 'Ny notatbok';

  @override
  String get notebookNameHint => 'Navn på notatbok';

  @override
  String get newNoteTitle => 'Nytt notat';

  @override
  String get sortOptionsTitle => 'Sorter';

  @override
  String get sortByModified => 'Sist redigert';

  @override
  String get sortByCreated => 'Opprettet';

  @override
  String get sortByTitle => 'Tittel';

  @override
  String get formatBold => 'Fet';

  @override
  String get formatItalic => 'Kursiv';

  @override
  String get formatUnderline => 'Understreket';

  @override
  String get formatHeading => 'Overskrift';

  @override
  String get formatBulletList => 'Punktliste';

  @override
  String get formatChecklist => 'Sjekkliste';

  @override
  String get formatQuote => 'Sitat';

  @override
  String get formatCodeBlock => 'Kodeblokk';

  @override
  String get penFountainPen => 'Fyllepenn';

  @override
  String get penGelPen => 'Gelpenn';

  @override
  String get penPencil => 'Blyant';

  @override
  String get penHighlighter => 'Tekstmarker';

  @override
  String get penEraser => 'Viskelær';

  @override
  String get penStrokeWidth => 'Linjetykkelse';

  @override
  String get toggleHandwritingMode => 'Bytt mellom skriving og tegning';

  @override
  String get biometricLockReason => 'Lås opp for å se notatet';

  @override
  String get noteLockedMessage => 'Dette notatet er låst';

  @override
  String get unlockButton => 'Lås opp';

  @override
  String get noteLockTurnedOffMessage =>
      'Notatlåsen er slått av fordi denne enheten ikke har skjermlås eller biometri satt opp.';

  @override
  String get biometricEnableReason =>
      'Bekreft identiteten din for å slå på notatlåsen';

  @override
  String get biometricDisableReason =>
      'Bekreft identiteten din for å slå av notatlåsen';

  @override
  String get biometricShareReason =>
      'Lås opp for å dele eller eksportere notatet';

  @override
  String get biometricAuthFailedMessage =>
      'Identiteten din kunne ikke bekreftes.';

  @override
  String get biometricSetupNeededMessage =>
      'Sett først opp skjermlås eller fingeravtrykk i enhetsinnstillingene.';

  @override
  String get privacyChoicesTitle => 'Personvernvalg';

  @override
  String get purchaseFailedMessage =>
      'Kjøpet kunne ikke fullføres. Prøv igjen.';

  @override
  String get restoreSuccessMessage => 'Kjøpet ditt er gjenopprettet.';

  @override
  String get restoreNothingFoundMessage =>
      'Fant ingen tidligere kjøp for denne kontoen.';

  @override
  String get restoreFailedMessage =>
      'Kjøpene kunne ikke gjenopprettes. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get reminderScheduleFailedMessage =>
      'Påminnelsen kunne ikke planlegges. Prøv igjen.';

  @override
  String get storageIssueNotebooksLoad =>
      'Noen notatbøker kunne ikke lastes inn. Viser det som er tilgjengelig.';

  @override
  String get storageIssueNotebookSave =>
      'Denne notatboken er kanskje ikke lagret. Prøv igjen.';

  @override
  String get storageIssueNotebookChange =>
      'Denne endringen er kanskje ikke lagret. Prøv igjen.';

  @override
  String get storageIssueNotebookDelete =>
      'Notatboken kunne ikke slettes. Prøv igjen.';

  @override
  String get storageIssueNotebookOrder =>
      'Den nye rekkefølgen er kanskje ikke lagret. Prøv igjen.';

  @override
  String get storageIssueNotesLoad =>
      'Noen notater kunne ikke lastes inn. Viser det som er tilgjengelig.';

  @override
  String get storageIssueSearch =>
      'Søkeresultatene kan være ufullstendige akkurat nå.';

  @override
  String get storageIssueNoteSave =>
      'Dette notatet er kanskje ikke lagret. Sjekk lagringsplassen på enheten.';

  @override
  String get storageIssueNoteDelete =>
      'Notatet kunne ikke slettes. Prøv igjen.';

  @override
  String get purchaseUnavailableMessage =>
      'Dette kjøpet er ikke tilgjengelig akkurat nå. Prøv igjen senere.';

  @override
  String get exportTitle => 'Eksporter';

  @override
  String get exportAsTxt => 'Eksporter som tekst';

  @override
  String get exportAsPdf => 'Eksporter som PDF';

  @override
  String get paperStyleSectionTitle => 'Papirstil';

  @override
  String get paperStyleLined => 'Linjert';

  @override
  String get paperStyleDotGrid => 'Prikket';

  @override
  String get paperStyleGrid => 'Rutet';

  @override
  String get paperStyleBlank => 'Blankt';

  @override
  String get paperStyleCream => 'Kremfarget';

  @override
  String get paperStyleParchment => 'Pergament';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Skrifttype for notater';

  @override
  String get fontSystem => 'System';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Utseende';

  @override
  String get themeLight => 'Lys';

  @override
  String get themeDark => 'Mørk';

  @override
  String get themeParchment => 'Pergament';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Visning av dagens vers';

  @override
  String get verseModeWatermark => 'Vannmerke';

  @override
  String get verseModeHeader => 'Topptekst';

  @override
  String get verseModeFooter => 'Bunntekst';

  @override
  String get verseModeOff => 'Av';

  @override
  String get notificationsSectionTitle => 'Varsler';

  @override
  String get dailyReminderToggle => 'Daglig påminnelse om vers';

  @override
  String get reminderTimeLabel => 'Tidspunkt for påminnelse';

  @override
  String get notificationPermissionDenied =>
      'Varsler er slått av i systeminnstillingene.';

  @override
  String get dailyReminderBody => 'Dagens vers er klart.';

  @override
  String get privacySectionTitle => 'Personvern';

  @override
  String get biometricLockToggle => 'Lås notater med Face ID / fingeravtrykk';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Fjern annonser';

  @override
  String get restorePurchasesButton => 'Gjenopprett kjøp';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Mer';

  @override
  String get rateAppTitle => 'Vurder Atrament';

  @override
  String get rateAppSubtitle => 'Liker du appen? Skriv en anmeldelse';

  @override
  String get shareAppTitle => 'Del Atrament';

  @override
  String get shareAppSubtitle => 'Fortell en venn';

  @override
  String get shareAppMessage =>
      'Prøv Atrament – en distraksjonsfri notatblokk med papirtekstur.';

  @override
  String get languageSectionTitle => 'Språk';

  @override
  String get languageFollowsSystem => 'Følger språkinnstillingen på enheten';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get languagePickerTitle => 'Velg språk';

  @override
  String get premiumScreenTitle => 'Fjern annonser';

  @override
  String get premiumHeadline => 'Skriv uten distraksjoner';

  @override
  String get premiumBody =>
      'Atrament er gratis og viser ett lite annonsebanner. Å fjerne annonsene er et engangskjøp som ikke låser opp noe annet – alle funksjoner er allerede dine.';

  @override
  String get premiumRestoreButton => 'Gjenopprett kjøp';

  @override
  String get premiumAlreadyProMessage =>
      'Du har allerede «Fjern annonser». Takk!';

  @override
  String get supportSectionTitle => 'Brukerstøtte';

  @override
  String get shareDebugLogButton => 'Del feilsøkingslogg';

  @override
  String get shareDebugLogSubtitle =>
      'Send en teknisk rapport hvis noe ikke fungerer';

  @override
  String get noDebugLogMessage => 'Ingenting å rapportere ennå.';

  @override
  String get clearDebugLogButton => 'Tøm feilsøkingsloggen';

  @override
  String get clearDebugLogTitle => 'Vil du tømme feilsøkingsloggen?';

  @override
  String get clearDebugLogBody =>
      'Den lagrede tekniske rapporten fjernes fra enheten din.';

  @override
  String get debugLogClearedMessage => 'Feilsøkingsloggen er tømt.';

  @override
  String get premiumUnlockLabel => 'Fjern annonser for alltid';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Alle';

  @override
  String get chipNotebooks => 'Notatbøker';

  @override
  String get chipRecent => 'Nylige';

  @override
  String get emptyAllNotesTitle => 'Ingen notater ennå';

  @override
  String get emptyAllNotesBody => 'Trykk på + for å skrive ditt første notat.';

  @override
  String get emptyRecentNotesTitle => 'Ingenting nylig redigert';

  @override
  String get emptyRecentNotesBody => 'Notater du redigerer, vises her.';

  @override
  String get noteActionRename => 'Gi nytt navn';

  @override
  String get noteActionMoveToNotebook => 'Flytt til notatbok';

  @override
  String get noteActionEdit => 'Rediger';

  @override
  String get noteActionExport => 'Eksporter';

  @override
  String get noteActionShare => 'Del';

  @override
  String get moveToNotebookTitle => 'Flytt til notatbok';

  @override
  String get moveToNotebookEmptyBody =>
      'Det finnes ingen andre notatbøker ennå. Opprett en for å organisere dette notatet.';

  @override
  String get moveToNotebookCreateRow => 'Opprett ny notatbok';

  @override
  String get notebookActionRename => 'Gi nytt navn';

  @override
  String get notebookActionChangeCover => 'Bytt omslag';

  @override
  String get notebookRenameDialogTitle => 'Gi notatboken nytt navn';

  @override
  String get notebookCoverPickerTitle => 'Velg omslagsfarge';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Notatboken slettes sammen med alle notatene i den (totalt: $count). Dette kan ikke angres.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Juridisk og brukerstøtte';

  @override
  String get privacyPolicyRow => 'Personvernerklæring';

  @override
  String get termsOfServiceRow => 'Brukervilkår';

  @override
  String get supportRow => 'Brukerstøtte';

  @override
  String get openLinkFailedMessage => 'Kunne ikke åpne lenken. Prøv igjen.';

  @override
  String get openSourceLicensesRow => 'Åpen kildekode-lisenser';

  @override
  String get notificationChannelDescription =>
      'Din valgfrie daglige påminnelse om et bibelvers';
}
