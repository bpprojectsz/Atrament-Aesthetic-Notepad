// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Riprova';

  @override
  String get errorGeneric => 'Qualcosa è andato storto';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get undo => 'Annulla azione';

  @override
  String get redo => 'Ripeti';

  @override
  String get untitledNote => 'Senza titolo';

  @override
  String get deleteConfirmBody => 'Questa azione non può essere annullata.';

  @override
  String get deleteNoteTitle => 'Eliminare questa nota?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Eliminare «$name»?';
  }

  @override
  String get saveFailedMessage => 'Impossibile salvare. Riprova.';

  @override
  String get exportFailedMessage =>
      'Impossibile esportare questa nota. Riprova.';

  @override
  String get shareFailedMessage =>
      'Impossibile aprire il menu di condivisione. Riprova.';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get searchHint => 'Cerca nelle note';

  @override
  String get emptyNotebooksTitle => 'Ancora nessun quaderno';

  @override
  String get emptyNotebooksBody =>
      'Crea il tuo primo quaderno per iniziare a scrivere.';

  @override
  String get emptySearchTitle => 'Nessun risultato';

  @override
  String get emptySearchBody => 'Prova con un altro termine di ricerca.';

  @override
  String get emptyNotebookTitle => 'Ancora nessuna nota';

  @override
  String get emptyNotebookBody => 'Tocca + per scrivere la tua prima nota.';

  @override
  String get newNotebookTitle => 'Nuovo quaderno';

  @override
  String get notebookNameHint => 'Nome del quaderno';

  @override
  String get newNoteTitle => 'Nuova nota';

  @override
  String get sortOptionsTitle => 'Ordina';

  @override
  String get sortByModified => 'Ultima modifica';

  @override
  String get sortByCreated => 'Data di creazione';

  @override
  String get sortByTitle => 'Titolo';

  @override
  String get formatBold => 'Grassetto';

  @override
  String get formatItalic => 'Corsivo';

  @override
  String get formatUnderline => 'Sottolineato';

  @override
  String get formatHeading => 'Titolo';

  @override
  String get formatBulletList => 'Elenco puntato';

  @override
  String get formatChecklist => 'Elenco di controllo';

  @override
  String get formatQuote => 'Citazione';

  @override
  String get formatCodeBlock => 'Blocco di codice';

  @override
  String get penFountainPen => 'Penna stilografica';

  @override
  String get penGelPen => 'Penna gel';

  @override
  String get penPencil => 'Matita';

  @override
  String get penHighlighter => 'Evidenziatore';

  @override
  String get penEraser => 'Gomma';

  @override
  String get penStrokeWidth => 'Spessore del tratto';

  @override
  String get toggleHandwritingMode => 'Passa dalla digitazione al disegno';

  @override
  String get biometricLockReason => 'Sblocca per visualizzare la nota';

  @override
  String get noteLockedMessage => 'Questa nota è bloccata';

  @override
  String get unlockButton => 'Sblocca';

  @override
  String get noteLockTurnedOffMessage =>
      'Il blocco delle note è stato disattivato perché su questo dispositivo non sono configurati blocco schermo o biometria.';

  @override
  String get biometricEnableReason =>
      'Conferma la tua identità per attivare il blocco delle note';

  @override
  String get biometricDisableReason =>
      'Conferma la tua identità per disattivare il blocco delle note';

  @override
  String get biometricShareReason =>
      'Sblocca per condividere o esportare questa nota';

  @override
  String get biometricAuthFailedMessage =>
      'Impossibile verificare la tua identità.';

  @override
  String get biometricSetupNeededMessage =>
      'Configura prima un blocco schermo o un’impronta digitale nelle impostazioni del dispositivo.';

  @override
  String get privacyChoicesTitle => 'Opzioni sulla privacy';

  @override
  String get purchaseFailedMessage =>
      'Impossibile completare l’acquisto. Riprova.';

  @override
  String get restoreSuccessMessage => 'Il tuo acquisto è stato ripristinato.';

  @override
  String get restoreNothingFoundMessage =>
      'Nessun acquisto precedente trovato per questo account.';

  @override
  String get restoreFailedMessage =>
      'Impossibile ripristinare gli acquisti. Controlla la connessione e riprova.';

  @override
  String get reminderScheduleFailedMessage =>
      'Impossibile programmare il promemoria. Riprova.';

  @override
  String get storageIssueNotebooksLoad =>
      'Impossibile caricare alcuni quaderni. Vengono mostrati quelli disponibili.';

  @override
  String get storageIssueNotebookSave =>
      'Questo quaderno potrebbe non essere stato salvato. Riprova.';

  @override
  String get storageIssueNotebookChange =>
      'Questa modifica potrebbe non essere stata salvata. Riprova.';

  @override
  String get storageIssueNotebookDelete =>
      'Impossibile eliminare il quaderno. Riprova.';

  @override
  String get storageIssueNotebookOrder =>
      'Il nuovo ordine potrebbe non essere stato salvato. Riprova.';

  @override
  String get storageIssueNotesLoad =>
      'Impossibile caricare alcune note. Vengono mostrate quelle disponibili.';

  @override
  String get storageIssueSearch =>
      'I risultati della ricerca potrebbero essere incompleti al momento.';

  @override
  String get storageIssueNoteSave =>
      'Questa nota potrebbe non essere stata salvata. Controlla lo spazio sul dispositivo.';

  @override
  String get storageIssueNoteDelete =>
      'Impossibile eliminare la nota. Riprova.';

  @override
  String get purchaseUnavailableMessage =>
      'Questo acquisto al momento non è disponibile. Riprova più tardi.';

  @override
  String get exportTitle => 'Esporta';

  @override
  String get exportAsTxt => 'Esporta come testo';

  @override
  String get exportAsPdf => 'Esporta come PDF';

  @override
  String get paperStyleSectionTitle => 'Stile della carta';

  @override
  String get paperStyleLined => 'A righe';

  @override
  String get paperStyleDotGrid => 'A puntini';

  @override
  String get paperStyleGrid => 'A quadretti';

  @override
  String get paperStyleBlank => 'Bianca';

  @override
  String get paperStyleCream => 'Crema';

  @override
  String get paperStyleParchment => 'Pergamena';

  @override
  String get paperStyleVellum => 'Velina';

  @override
  String get fontSectionTitle => 'Carattere delle note';

  @override
  String get fontSystem => 'Di sistema';

  @override
  String get fontSerif => 'Con grazie';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Aspetto';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeParchment => 'Pergamena';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get verseSectionTitle => 'Visualizzazione del versetto del giorno';

  @override
  String get verseModeWatermark => 'Filigrana';

  @override
  String get verseModeHeader => 'Intestazione';

  @override
  String get verseModeFooter => 'Piè di pagina';

  @override
  String get verseModeOff => 'Disattivato';

  @override
  String get notificationsSectionTitle => 'Notifiche';

  @override
  String get dailyReminderToggle => 'Promemoria giornaliero del versetto';

  @override
  String get reminderTimeLabel => 'Orario del promemoria';

  @override
  String get notificationPermissionDenied =>
      'Le notifiche sono disattivate nelle impostazioni di sistema.';

  @override
  String get dailyReminderBody => 'Il tuo versetto del giorno è pronto.';

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get biometricLockToggle =>
      'Blocca le note con Face ID / impronta digitale';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Rimuovi pubblicità';

  @override
  String get restorePurchasesButton => 'Ripristina acquisti';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Altro';

  @override
  String get rateAppTitle => 'Valuta Atrament';

  @override
  String get rateAppSubtitle => 'Ti piace l’app? Lascia una recensione';

  @override
  String get shareAppTitle => 'Condividi Atrament';

  @override
  String get shareAppSubtitle => 'Dillo a un amico';

  @override
  String get shareAppMessage =>
      'Prova Atrament, un blocco note senza distrazioni con texture di carta.';

  @override
  String get languageSectionTitle => 'Lingua';

  @override
  String get languageFollowsSystem => 'Segue la lingua del dispositivo';

  @override
  String get languageSystem => 'Predefinito di sistema';

  @override
  String get languagePickerTitle => 'Scegli la lingua';

  @override
  String get premiumScreenTitle => 'Rimuovi pubblicità';

  @override
  String get premiumHeadline => 'Scrivi senza distrazioni';

  @override
  String get premiumBody =>
      'Atrament è gratuito e mostra un solo piccolo banner pubblicitario. Rimuovere la pubblicità è un acquisto una tantum che non sblocca altro: tutte le funzioni sono già tue.';

  @override
  String get premiumRestoreButton => 'Ripristina acquisti';

  @override
  String get premiumAlreadyProMessage =>
      'Hai già “Rimuovi pubblicità”. Grazie!';

  @override
  String get supportSectionTitle => 'Assistenza';

  @override
  String get shareDebugLogButton => 'Condividi il registro di debug';

  @override
  String get shareDebugLogSubtitle =>
      'Invia un rapporto tecnico se qualcosa non funziona';

  @override
  String get noDebugLogMessage => 'Non c’è ancora nulla da segnalare.';

  @override
  String get clearDebugLogButton => 'Cancella il registro di debug';

  @override
  String get clearDebugLogTitle => 'Cancellare il registro di debug?';

  @override
  String get clearDebugLogBody =>
      'Il rapporto tecnico salvato verrà rimosso dal tuo dispositivo.';

  @override
  String get debugLogClearedMessage => 'Registro di debug cancellato.';

  @override
  String get premiumUnlockLabel => 'Rimuovi pubblicità per sempre';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Tutte';

  @override
  String get chipNotebooks => 'Quaderni';

  @override
  String get chipRecent => 'Recenti';

  @override
  String get emptyAllNotesTitle => 'Ancora nessuna nota';

  @override
  String get emptyAllNotesBody => 'Tocca + per scrivere la tua prima nota.';

  @override
  String get emptyRecentNotesTitle => 'Niente di recente';

  @override
  String get emptyRecentNotesBody => 'Le note che modifichi appariranno qui.';

  @override
  String get noteActionRename => 'Rinomina';

  @override
  String get noteActionMoveToNotebook => 'Sposta in un quaderno';

  @override
  String get noteActionEdit => 'Modifica';

  @override
  String get noteActionExport => 'Esporta';

  @override
  String get noteActionShare => 'Condividi';

  @override
  String get moveToNotebookTitle => 'Sposta in un quaderno';

  @override
  String get moveToNotebookEmptyBody =>
      'Non ci sono ancora altri quaderni. Creane uno per organizzare questa nota.';

  @override
  String get moveToNotebookCreateRow => 'Crea un nuovo quaderno';

  @override
  String get notebookActionRename => 'Rinomina';

  @override
  String get notebookActionChangeCover => 'Cambia copertina';

  @override
  String get notebookRenameDialogTitle => 'Rinomina quaderno';

  @override
  String get notebookCoverPickerTitle => 'Scegli il colore della copertina';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Il quaderno verrà eliminato insieme a tutte le sue note (in totale: $count). Questa azione non può essere annullata.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Informazioni legali e assistenza';

  @override
  String get privacyPolicyRow => 'Informativa sulla privacy';

  @override
  String get termsOfServiceRow => 'Termini di servizio';

  @override
  String get supportRow => 'Assistenza';

  @override
  String get openLinkFailedMessage => 'Impossibile aprire il link. Riprova.';

  @override
  String get openSourceLicensesRow => 'Licenze open source';

  @override
  String get notificationChannelDescription =>
      'Il tuo promemoria giornaliero facoltativo di un versetto biblico';
}
