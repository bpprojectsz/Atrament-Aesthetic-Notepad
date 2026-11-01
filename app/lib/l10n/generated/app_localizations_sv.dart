// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Försök igen';

  @override
  String get errorGeneric => 'Något gick fel';

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Spara';

  @override
  String get delete => 'Radera';

  @override
  String get undo => 'Ångra';

  @override
  String get redo => 'Gör om';

  @override
  String get untitledNote => 'Namnlös';

  @override
  String get deleteConfirmBody => 'Det går inte att ångra den här åtgärden.';

  @override
  String get deleteNoteTitle => 'Radera den här anteckningen?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Radera ”$name”?';
  }

  @override
  String get saveFailedMessage => 'Det gick inte att spara. Försök igen.';

  @override
  String get exportFailedMessage =>
      'Det gick inte att exportera anteckningen. Försök igen.';

  @override
  String get shareFailedMessage =>
      'Det gick inte att öppna delningsmenyn. Försök igen.';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get searchHint => 'Sök i anteckningar';

  @override
  String get emptyNotebooksTitle => 'Inga anteckningsböcker än';

  @override
  String get emptyNotebooksBody =>
      'Skapa din första anteckningsbok för att börja skriva.';

  @override
  String get emptySearchTitle => 'Inga resultat';

  @override
  String get emptySearchBody => 'Prova en annan sökterm.';

  @override
  String get emptyNotebookTitle => 'Inga anteckningar än';

  @override
  String get emptyNotebookBody =>
      'Tryck på + för att skriva din första anteckning.';

  @override
  String get newNotebookTitle => 'Ny anteckningsbok';

  @override
  String get notebookNameHint => 'Anteckningsbokens namn';

  @override
  String get newNoteTitle => 'Ny anteckning';

  @override
  String get sortOptionsTitle => 'Sortera';

  @override
  String get sortByModified => 'Senast redigerad';

  @override
  String get sortByCreated => 'Skapandedatum';

  @override
  String get sortByTitle => 'Titel';

  @override
  String get formatBold => 'Fet';

  @override
  String get formatItalic => 'Kursiv';

  @override
  String get formatUnderline => 'Understruken';

  @override
  String get formatHeading => 'Rubrik';

  @override
  String get formatBulletList => 'Punktlista';

  @override
  String get formatChecklist => 'Checklista';

  @override
  String get formatQuote => 'Citat';

  @override
  String get formatCodeBlock => 'Kodblock';

  @override
  String get penFountainPen => 'Reservoarpenna';

  @override
  String get penGelPen => 'Gelpenna';

  @override
  String get penPencil => 'Blyertspenna';

  @override
  String get penHighlighter => 'Överstrykningspenna';

  @override
  String get penEraser => 'Suddgummi';

  @override
  String get penStrokeWidth => 'Linjetjocklek';

  @override
  String get toggleHandwritingMode => 'Växla mellan att skriva och rita';

  @override
  String get biometricLockReason => 'Lås upp för att visa anteckningen';

  @override
  String get noteLockedMessage => 'Anteckningen är låst';

  @override
  String get unlockButton => 'Lås upp';

  @override
  String get noteLockTurnedOffMessage =>
      'Anteckningslåset har stängts av eftersom ingen skärmlåsning eller biometri är inställd på den här enheten.';

  @override
  String get biometricEnableReason =>
      'Bekräfta din identitet för att aktivera anteckningslåset';

  @override
  String get biometricDisableReason =>
      'Bekräfta din identitet för att inaktivera anteckningslåset';

  @override
  String get biometricShareReason =>
      'Lås upp för att dela eller exportera anteckningen';

  @override
  String get biometricAuthFailedMessage =>
      'Din identitet kunde inte bekräftas.';

  @override
  String get biometricSetupNeededMessage =>
      'Ställ först in skärmlås eller fingeravtryck i enhetens inställningar.';

  @override
  String get privacyChoicesTitle => 'Sekretessval';

  @override
  String get purchaseFailedMessage =>
      'Köpet kunde inte slutföras. Försök igen.';

  @override
  String get restoreSuccessMessage => 'Ditt köp har återställts.';

  @override
  String get restoreNothingFoundMessage =>
      'Inga tidigare köp hittades för det här kontot.';

  @override
  String get restoreFailedMessage =>
      'Köpen kunde inte återställas. Kontrollera anslutningen och försök igen.';

  @override
  String get reminderScheduleFailedMessage =>
      'Påminnelsen kunde inte schemaläggas. Försök igen.';

  @override
  String get storageIssueNotebooksLoad =>
      'Vissa anteckningsböcker kunde inte läsas in. Det som finns visas.';

  @override
  String get storageIssueNotebookSave =>
      'Den här anteckningsboken kanske inte sparades. Försök igen.';

  @override
  String get storageIssueNotebookChange =>
      'Ändringen kanske inte sparades. Försök igen.';

  @override
  String get storageIssueNotebookDelete =>
      'Anteckningsboken kunde inte raderas. Försök igen.';

  @override
  String get storageIssueNotebookOrder =>
      'Den nya ordningen kanske inte sparades. Försök igen.';

  @override
  String get storageIssueNotesLoad =>
      'Vissa anteckningar kunde inte läsas in. Det som finns visas.';

  @override
  String get storageIssueSearch =>
      'Sökresultaten kan vara ofullständiga just nu.';

  @override
  String get storageIssueNoteSave =>
      'Anteckningen kanske inte sparades. Kontrollera enhetens lagringsutrymme.';

  @override
  String get storageIssueNoteDelete =>
      'Anteckningen kunde inte raderas. Försök igen.';

  @override
  String get purchaseUnavailableMessage =>
      'Köpet är inte tillgängligt just nu. Försök igen senare.';

  @override
  String get exportTitle => 'Exportera';

  @override
  String get exportAsTxt => 'Exportera som text';

  @override
  String get exportAsPdf => 'Exportera som PDF';

  @override
  String get paperStyleSectionTitle => 'Pappersstil';

  @override
  String get paperStyleLined => 'Linjerat';

  @override
  String get paperStyleDotGrid => 'Prickrutigt';

  @override
  String get paperStyleGrid => 'Rutat';

  @override
  String get paperStyleBlank => 'Blankt';

  @override
  String get paperStyleCream => 'Gräddvitt';

  @override
  String get paperStyleParchment => 'Pergament';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Anteckningstypsnitt';

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
  String get themeLight => 'Ljust';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get themeParchment => 'Pergament';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Visning av dagens vers';

  @override
  String get verseModeWatermark => 'Vattenstämpel';

  @override
  String get verseModeHeader => 'Sidhuvud';

  @override
  String get verseModeFooter => 'Sidfot';

  @override
  String get verseModeOff => 'Av';

  @override
  String get notificationsSectionTitle => 'Aviseringar';

  @override
  String get dailyReminderToggle => 'Daglig versåminnelse';

  @override
  String get reminderTimeLabel => 'Tid för påminnelse';

  @override
  String get notificationPermissionDenied =>
      'Aviseringar är avstängda i systeminställningarna.';

  @override
  String get dailyReminderBody => 'Dagens vers är klar.';

  @override
  String get privacySectionTitle => 'Integritet';

  @override
  String get biometricLockToggle =>
      'Lås anteckningar med Face ID / fingeravtryck';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Ta bort annonser';

  @override
  String get restorePurchasesButton => 'Återställ köp';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Mer';

  @override
  String get rateAppTitle => 'Betygsätt Atrament';

  @override
  String get rateAppSubtitle => 'Gillar du appen? Lämna ett omdöme';

  @override
  String get shareAppTitle => 'Dela Atrament';

  @override
  String get shareAppSubtitle => 'Berätta för en vän';

  @override
  String get shareAppMessage =>
      'Testa Atrament – ett distraktionsfritt anteckningsblock med papperstexturer.';

  @override
  String get languageSectionTitle => 'Språk';

  @override
  String get languageFollowsSystem => 'Följer enhetens språkinställning';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get languagePickerTitle => 'Välj språk';

  @override
  String get premiumScreenTitle => 'Ta bort annonser';

  @override
  String get premiumHeadline => 'Skriv utan distraktioner';

  @override
  String get premiumBody =>
      'Atrament är gratis och visar en liten annonsbanner. Att ta bort annonserna är ett engångsköp som inte låser upp något annat – alla funktioner är redan dina.';

  @override
  String get premiumRestoreButton => 'Återställ köp';

  @override
  String get premiumAlreadyProMessage => 'Du har redan Ta bort annonser. Tack!';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get shareDebugLogButton => 'Dela felsökningslogg';

  @override
  String get shareDebugLogSubtitle =>
      'Skicka en teknisk rapport om något inte fungerar';

  @override
  String get noDebugLogMessage => 'Inget att rapportera än.';

  @override
  String get clearDebugLogButton => 'Rensa felsökningsloggen';

  @override
  String get clearDebugLogTitle => 'Rensa felsökningsloggen?';

  @override
  String get clearDebugLogBody =>
      'Den sparade tekniska rapporten tas bort från din enhet.';

  @override
  String get debugLogClearedMessage => 'Felsökningsloggen har rensats.';

  @override
  String get premiumUnlockLabel => 'Ta bort annonser för alltid';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Alla';

  @override
  String get chipNotebooks => 'Anteckningsböcker';

  @override
  String get chipRecent => 'Senaste';

  @override
  String get emptyAllNotesTitle => 'Inga anteckningar än';

  @override
  String get emptyAllNotesBody =>
      'Tryck på + för att skriva din första anteckning.';

  @override
  String get emptyRecentNotesTitle => 'Inget nyligen';

  @override
  String get emptyRecentNotesBody => 'Anteckningar du redigerar visas här.';

  @override
  String get noteActionRename => 'Byt namn';

  @override
  String get noteActionMoveToNotebook => 'Flytta till anteckningsbok';

  @override
  String get noteActionEdit => 'Redigera';

  @override
  String get noteActionExport => 'Exportera';

  @override
  String get noteActionShare => 'Dela';

  @override
  String get moveToNotebookTitle => 'Flytta till anteckningsbok';

  @override
  String get moveToNotebookEmptyBody =>
      'Det finns inga andra anteckningsböcker än. Skapa en för att organisera anteckningen.';

  @override
  String get moveToNotebookCreateRow => 'Skapa ny anteckningsbok';

  @override
  String get notebookActionRename => 'Byt namn';

  @override
  String get notebookActionChangeCover => 'Byt omslag';

  @override
  String get notebookRenameDialogTitle => 'Byt namn på anteckningsboken';

  @override
  String get notebookCoverPickerTitle => 'Välj omslagsfärg';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Anteckningsboken raderas tillsammans med alla anteckningar i den (totalt: $count). Det går inte att ångra.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Juridik och support';

  @override
  String get privacyPolicyRow => 'Integritetspolicy';

  @override
  String get termsOfServiceRow => 'Användarvillkor';

  @override
  String get supportRow => 'Support';

  @override
  String get openLinkFailedMessage =>
      'Det gick inte att öppna länken. Försök igen.';

  @override
  String get openSourceLicensesRow => 'Licenser för öppen källkod';
}
