// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Prøv igen';

  @override
  String get errorGeneric => 'Noget gik galt';

  @override
  String get cancel => 'Annuller';

  @override
  String get save => 'Gem';

  @override
  String get delete => 'Slet';

  @override
  String get undo => 'Fortryd';

  @override
  String get redo => 'Gentag';

  @override
  String get untitledNote => 'Uden titel';

  @override
  String get deleteConfirmBody => 'Handlingen kan ikke fortrydes.';

  @override
  String get deleteNoteTitle => 'Vil du slette denne note?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Vil du slette “$name”?';
  }

  @override
  String get saveFailedMessage => 'Det lykkedes ikke at gemme. Prøv igen.';

  @override
  String get exportFailedMessage =>
      'Det lykkedes ikke at eksportere noten. Prøv igen.';

  @override
  String get shareFailedMessage => 'Delemenuen kunne ikke åbnes. Prøv igen.';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get searchHint => 'Søg i noter';

  @override
  String get emptyNotebooksTitle => 'Ingen notesbøger endnu';

  @override
  String get emptyNotebooksBody =>
      'Opret din første notesbog for at begynde at skrive.';

  @override
  String get emptySearchTitle => 'Ingen resultater';

  @override
  String get emptySearchBody => 'Prøv et andet søgeord.';

  @override
  String get emptyNotebookTitle => 'Ingen noter endnu';

  @override
  String get emptyNotebookBody => 'Tryk på + for at skrive din første note.';

  @override
  String get newNotebookTitle => 'Ny notesbog';

  @override
  String get notebookNameHint => 'Notesbogens navn';

  @override
  String get newNoteTitle => 'Ny note';

  @override
  String get sortOptionsTitle => 'Sortér';

  @override
  String get sortByModified => 'Senest redigeret';

  @override
  String get sortByCreated => 'Oprettelsesdato';

  @override
  String get sortByTitle => 'Titel';

  @override
  String get formatBold => 'Fed';

  @override
  String get formatItalic => 'Kursiv';

  @override
  String get formatUnderline => 'Understreget';

  @override
  String get formatHeading => 'Overskrift';

  @override
  String get formatBulletList => 'Punktopstilling';

  @override
  String get formatChecklist => 'Tjekliste';

  @override
  String get formatQuote => 'Citat';

  @override
  String get formatCodeBlock => 'Kodeblok';

  @override
  String get penFountainPen => 'Fyldepen';

  @override
  String get penGelPen => 'Gelpen';

  @override
  String get penPencil => 'Blyant';

  @override
  String get penHighlighter => 'Overstregningspen';

  @override
  String get penEraser => 'Viskelæder';

  @override
  String get penStrokeWidth => 'Stregtykkelse';

  @override
  String get toggleHandwritingMode => 'Skift mellem at skrive og tegne';

  @override
  String get biometricLockReason => 'Lås op for at se noten';

  @override
  String get noteLockedMessage => 'Denne note er låst';

  @override
  String get unlockButton => 'Lås op';

  @override
  String get noteLockTurnedOffMessage =>
      'Notelåsen er slået fra, fordi denne enhed ikke har skærmlås eller biometri sat op.';

  @override
  String get biometricEnableReason =>
      'Bekræft din identitet for at slå notelåsen til';

  @override
  String get biometricDisableReason =>
      'Bekræft din identitet for at slå notelåsen fra';

  @override
  String get biometricShareReason =>
      'Lås op for at dele eller eksportere noten';

  @override
  String get biometricAuthFailedMessage =>
      'Din identitet kunne ikke bekræftes.';

  @override
  String get biometricSetupNeededMessage =>
      'Konfigurer først en skærmlås eller et fingeraftryk i enhedens indstillinger.';

  @override
  String get privacyChoicesTitle => 'Privatlivsvalg';

  @override
  String get purchaseFailedMessage =>
      'Købet kunne ikke gennemføres. Prøv igen.';

  @override
  String get restoreSuccessMessage => 'Dit køb er gendannet.';

  @override
  String get restoreNothingFoundMessage =>
      'Der blev ikke fundet tidligere køb for denne konto.';

  @override
  String get restoreFailedMessage =>
      'Køb kunne ikke gendannes. Tjek din forbindelse, og prøv igen.';

  @override
  String get reminderScheduleFailedMessage =>
      'Påmindelsen kunne ikke planlægges. Prøv igen.';

  @override
  String get storageIssueNotebooksLoad =>
      'Nogle notesbøger kunne ikke indlæses. Det tilgængelige vises.';

  @override
  String get storageIssueNotebookSave =>
      'Denne notesbog er muligvis ikke gemt. Prøv igen.';

  @override
  String get storageIssueNotebookChange =>
      'Denne ændring er muligvis ikke gemt. Prøv igen.';

  @override
  String get storageIssueNotebookDelete =>
      'Notesbogen kunne ikke slettes. Prøv igen.';

  @override
  String get storageIssueNotebookOrder =>
      'Den nye rækkefølge er muligvis ikke gemt. Prøv igen.';

  @override
  String get storageIssueNotesLoad =>
      'Nogle noter kunne ikke indlæses. Det tilgængelige vises.';

  @override
  String get storageIssueSearch =>
      'Søgeresultaterne kan være ufuldstændige lige nu.';

  @override
  String get storageIssueNoteSave =>
      'Denne note er muligvis ikke gemt. Tjek enhedens lagerplads.';

  @override
  String get storageIssueNoteDelete => 'Noten kunne ikke slettes. Prøv igen.';

  @override
  String get purchaseUnavailableMessage =>
      'Dette køb er ikke tilgængeligt lige nu. Prøv igen senere.';

  @override
  String get exportTitle => 'Eksportér';

  @override
  String get exportAsTxt => 'Eksportér som tekst';

  @override
  String get exportAsPdf => 'Eksportér som PDF';

  @override
  String get paperStyleSectionTitle => 'Papirstil';

  @override
  String get paperStyleLined => 'Linjeret';

  @override
  String get paperStyleDotGrid => 'Prikket';

  @override
  String get paperStyleGrid => 'Ternet';

  @override
  String get paperStyleBlank => 'Blankt';

  @override
  String get paperStyleCream => 'Cremefarvet';

  @override
  String get paperStyleParchment => 'Pergament';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Skrifttype til noter';

  @override
  String get fontSystem => 'System';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Udseende';

  @override
  String get themeLight => 'Lys';

  @override
  String get themeDark => 'Mørk';

  @override
  String get themeParchment => 'Pergament';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Visning af dagens vers';

  @override
  String get verseModeWatermark => 'Vandmærke';

  @override
  String get verseModeHeader => 'Sidehoved';

  @override
  String get verseModeFooter => 'Sidefod';

  @override
  String get verseModeOff => 'Fra';

  @override
  String get notificationsSectionTitle => 'Notifikationer';

  @override
  String get dailyReminderToggle => 'Daglig påmindelse om vers';

  @override
  String get reminderTimeLabel => 'Tidspunkt for påmindelse';

  @override
  String get notificationPermissionDenied =>
      'Notifikationer er slået fra i systemindstillingerne.';

  @override
  String get dailyReminderBody => 'Dagens vers er klar.';

  @override
  String get privacySectionTitle => 'Privatliv';

  @override
  String get biometricLockToggle => 'Lås noter med Face ID / fingeraftryk';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Fjern reklamer';

  @override
  String get restorePurchasesButton => 'Gendan køb';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Mere';

  @override
  String get rateAppTitle => 'Bedøm Atrament';

  @override
  String get rateAppSubtitle => 'Kan du lide appen? Skriv en anmeldelse';

  @override
  String get shareAppTitle => 'Del Atrament';

  @override
  String get shareAppSubtitle => 'Fortæl det til en ven';

  @override
  String get shareAppMessage =>
      'Prøv Atrament – en forstyrrelsesfri notesblok med papirtekstur.';

  @override
  String get languageSectionTitle => 'Sprog';

  @override
  String get languageFollowsSystem => 'Følger enhedens sprogindstilling';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get languagePickerTitle => 'Vælg sprog';

  @override
  String get premiumScreenTitle => 'Fjern reklamer';

  @override
  String get premiumHeadline => 'Skriv uden forstyrrelser';

  @override
  String get premiumBody =>
      'Atrament er gratis og viser ét lille reklamebanner. At fjerne reklamerne er et engangskøb, der ikke låser noget andet op – alle funktioner er allerede dine.';

  @override
  String get premiumRestoreButton => 'Gendan køb';

  @override
  String get premiumAlreadyProMessage => 'Du har allerede “Fjern reklamer”. Tak!';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get shareDebugLogButton => 'Del fejlfindingslog';

  @override
  String get shareDebugLogSubtitle =>
      'Send en teknisk rapport, hvis noget ikke virker';

  @override
  String get noDebugLogMessage => 'Der er ikke noget at rapportere endnu.';

  @override
  String get clearDebugLogButton => 'Ryd fejlfindingslog';

  @override
  String get clearDebugLogTitle => 'Vil du rydde fejlfindingsloggen?';

  @override
  String get clearDebugLogBody =>
      'Den gemte tekniske rapport fjernes fra din enhed.';

  @override
  String get debugLogClearedMessage => 'Fejlfindingsloggen er ryddet.';

  @override
  String get premiumUnlockLabel => 'Fjern reklamer for altid';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Alle';

  @override
  String get chipNotebooks => 'Notesbøger';

  @override
  String get chipRecent => 'Seneste';

  @override
  String get emptyAllNotesTitle => 'Ingen noter endnu';

  @override
  String get emptyAllNotesBody => 'Tryk på + for at skrive din første note.';

  @override
  String get emptyRecentNotesTitle => 'Intet nyligt redigeret';

  @override
  String get emptyRecentNotesBody => 'Noter, du redigerer, vises her.';

  @override
  String get noteActionRename => 'Omdøb';

  @override
  String get noteActionMoveToNotebook => 'Flyt til notesbog';

  @override
  String get noteActionEdit => 'Rediger';

  @override
  String get noteActionExport => 'Eksportér';

  @override
  String get noteActionShare => 'Del';

  @override
  String get moveToNotebookTitle => 'Flyt til notesbog';

  @override
  String get moveToNotebookEmptyBody =>
      'Der er ingen andre notesbøger endnu. Opret en for at organisere denne note.';

  @override
  String get moveToNotebookCreateRow => 'Opret ny notesbog';

  @override
  String get notebookActionRename => 'Omdøb';

  @override
  String get notebookActionChangeCover => 'Skift omslag';

  @override
  String get notebookRenameDialogTitle => 'Omdøb notesbog';

  @override
  String get notebookCoverPickerTitle => 'Vælg omslagsfarve';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Notesbogen slettes sammen med alle dens noter (i alt: $count). Handlingen kan ikke fortrydes.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Jura og support';

  @override
  String get privacyPolicyRow => 'Privatlivspolitik';

  @override
  String get termsOfServiceRow => 'Servicevilkår';

  @override
  String get supportRow => 'Support';

  @override
  String get openLinkFailedMessage => 'Linket kunne ikke åbnes. Prøv igen.';

  @override
  String get openSourceLicensesRow => 'Open source-licenser';
}
