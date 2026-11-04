// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Torna-ho a provar';

  @override
  String get errorGeneric => 'Alguna cosa ha anat malament';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get save => 'Desa';

  @override
  String get delete => 'Suprimeix';

  @override
  String get undo => 'Desfés';

  @override
  String get redo => 'Refés';

  @override
  String get untitledNote => 'Sense títol';

  @override
  String get deleteConfirmBody => 'Aquesta acció no es pot desfer.';

  @override
  String get deleteNoteTitle => 'Vols suprimir aquesta nota?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Vols suprimir «$name»?';
  }

  @override
  String get saveFailedMessage => 'No s’ha pogut desar. Torna-ho a provar.';

  @override
  String get exportFailedMessage =>
      'No s’ha pogut exportar la nota. Torna-ho a provar.';

  @override
  String get shareFailedMessage =>
      'No s’ha pogut obrir el menú de compartició. Torna-ho a provar.';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get searchHint => 'Cerca notes';

  @override
  String get emptyNotebooksTitle => 'Encara no hi ha llibretes';

  @override
  String get emptyNotebooksBody =>
      'Crea la teva primera llibreta per començar a escriure.';

  @override
  String get emptySearchTitle => 'Cap resultat';

  @override
  String get emptySearchBody => 'Prova amb un altre terme de cerca.';

  @override
  String get emptyNotebookTitle => 'Encara no hi ha notes';

  @override
  String get emptyNotebookBody => 'Toca + per escriure la teva primera nota.';

  @override
  String get newNotebookTitle => 'Llibreta nova';

  @override
  String get notebookNameHint => 'Nom de la llibreta';

  @override
  String get newNoteTitle => 'Nota nova';

  @override
  String get sortOptionsTitle => 'Ordena';

  @override
  String get sortByModified => 'Última edició';

  @override
  String get sortByCreated => 'Data de creació';

  @override
  String get sortByTitle => 'Títol';

  @override
  String get formatBold => 'Negreta';

  @override
  String get formatItalic => 'Cursiva';

  @override
  String get formatUnderline => 'Subratllat';

  @override
  String get formatHeading => 'Títol de secció';

  @override
  String get formatBulletList => 'Llista amb vinyetes';

  @override
  String get formatChecklist => 'Llista de comprovació';

  @override
  String get formatQuote => 'Cita';

  @override
  String get formatCodeBlock => 'Bloc de codi';

  @override
  String get penFountainPen => 'Ploma estilogràfica';

  @override
  String get penGelPen => 'Bolígraf de gel';

  @override
  String get penPencil => 'Llapis';

  @override
  String get penHighlighter => 'Marcador';

  @override
  String get penEraser => 'Goma';

  @override
  String get penStrokeWidth => 'Gruix del traç';

  @override
  String get toggleHandwritingMode => 'Canvia entre escriure i dibuixar';

  @override
  String get biometricLockReason => 'Desbloqueja per veure la nota';

  @override
  String get noteLockedMessage => 'Aquesta nota està bloquejada';

  @override
  String get unlockButton => 'Desbloqueja';

  @override
  String get noteLockTurnedOffMessage =>
      'El bloqueig de notes s’ha desactivat perquè aquest dispositiu no té configurat el bloqueig de pantalla ni la biometria.';

  @override
  String get biometricEnableReason =>
      'Confirma la teva identitat per activar el bloqueig de notes';

  @override
  String get biometricDisableReason =>
      'Confirma la teva identitat per desactivar el bloqueig de notes';

  @override
  String get biometricShareReason =>
      'Desbloqueja per compartir o exportar la nota';

  @override
  String get biometricAuthFailedMessage =>
      'No s’ha pogut verificar la teva identitat.';

  @override
  String get biometricSetupNeededMessage =>
      'Primer configura un bloqueig de pantalla o una empremta digital a la configuració del dispositiu.';

  @override
  String get privacyChoicesTitle => 'Opcions de privadesa';

  @override
  String get purchaseFailedMessage =>
      'No s’ha pogut completar la compra. Torna-ho a provar.';

  @override
  String get restoreSuccessMessage => 'S’ha restaurat la teva compra.';

  @override
  String get restoreNothingFoundMessage =>
      'No s’ha trobat cap compra anterior d’aquest compte.';

  @override
  String get restoreFailedMessage =>
      'No s’han pogut restaurar les compres. Comprova la connexió i torna-ho a provar.';

  @override
  String get reminderScheduleFailedMessage =>
      'No s’ha pogut programar el recordatori. Torna-ho a provar.';

  @override
  String get storageIssueNotebooksLoad =>
      'No s’han pogut carregar algunes llibretes. Es mostra el que hi ha disponible.';

  @override
  String get storageIssueNotebookSave =>
      'És possible que aquesta llibreta no s’hagi desat. Torna-ho a provar.';

  @override
  String get storageIssueNotebookChange =>
      'És possible que aquest canvi no s’hagi desat. Torna-ho a provar.';

  @override
  String get storageIssueNotebookDelete =>
      'No s’ha pogut suprimir la llibreta. Torna-ho a provar.';

  @override
  String get storageIssueNotebookOrder =>
      'És possible que el nou ordre no s’hagi desat. Torna-ho a provar.';

  @override
  String get storageIssueNotesLoad =>
      'No s’han pogut carregar algunes notes. Es mostra el que hi ha disponible.';

  @override
  String get storageIssueSearch =>
      'Ara mateix els resultats de la cerca podrien estar incomplets.';

  @override
  String get storageIssueNoteSave =>
      'És possible que aquesta nota no s’hagi desat. Comprova l’emmagatzematge del dispositiu.';

  @override
  String get storageIssueNoteDelete =>
      'No s’ha pogut suprimir la nota. Torna-ho a provar.';

  @override
  String get purchaseUnavailableMessage =>
      'Aquesta compra no està disponible ara mateix. Torna-ho a provar més tard.';

  @override
  String get exportTitle => 'Exporta';

  @override
  String get exportAsTxt => 'Exporta com a text';

  @override
  String get exportAsPdf => 'Exporta com a PDF';

  @override
  String get paperStyleSectionTitle => 'Estil de paper';

  @override
  String get paperStyleLined => 'Pautat';

  @override
  String get paperStyleDotGrid => 'De punts';

  @override
  String get paperStyleGrid => 'Quadriculat';

  @override
  String get paperStyleBlank => 'En blanc';

  @override
  String get paperStyleCream => 'Crema';

  @override
  String get paperStyleParchment => 'Pergamí';

  @override
  String get paperStyleVellum => 'Vitel·la';

  @override
  String get fontSectionTitle => 'Tipus de lletra de les notes';

  @override
  String get fontSystem => 'Del sistema';

  @override
  String get fontSerif => 'Amb serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Aspecte';

  @override
  String get themeLight => 'Clar';

  @override
  String get themeDark => 'Fosc';

  @override
  String get themeParchment => 'Pergamí';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get verseSectionTitle => 'Visualització del vers del dia';

  @override
  String get verseModeWatermark => 'Marca d’aigua';

  @override
  String get verseModeHeader => 'Títol de secció';

  @override
  String get verseModeFooter => 'Peu de pàgina';

  @override
  String get verseModeOff => 'Desactivat';

  @override
  String get notificationsSectionTitle => 'Notificacions';

  @override
  String get dailyReminderToggle => 'Recordatori diari del vers';

  @override
  String get reminderTimeLabel => 'Hora del recordatori';

  @override
  String get notificationPermissionDenied =>
      'Les notificacions estan desactivades a la configuració del sistema.';

  @override
  String get dailyReminderBody => 'El teu vers del dia està a punt.';

  @override
  String get privacySectionTitle => 'Privadesa';

  @override
  String get biometricLockToggle =>
      'Bloqueja les notes amb Face ID / empremta digital';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Elimina els anuncis';

  @override
  String get restorePurchasesButton => 'Restaura les compres';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Més';

  @override
  String get rateAppTitle => 'Valora Atrament';

  @override
  String get rateAppSubtitle => 'T’agrada l’aplicació? Deixa una ressenya';

  @override
  String get shareAppTitle => 'Comparteix Atrament';

  @override
  String get shareAppSubtitle => 'Digues-ho a un amic';

  @override
  String get shareAppMessage =>
      'Prova Atrament, un bloc de notes sense distraccions amb textures de paper.';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get languageFollowsSystem => 'Segueix l’idioma del dispositiu';

  @override
  String get languageSystem => 'Predeterminat del sistema';

  @override
  String get languagePickerTitle => 'Tria l’idioma';

  @override
  String get premiumScreenTitle => 'Elimina els anuncis';

  @override
  String get premiumHeadline => 'Escriu sense distraccions';

  @override
  String get premiumBody =>
      'Atrament és gratuït i mostra un petit bàner publicitari. Eliminar els anuncis és una compra única que no desbloqueja res més: totes les funcions ja són teves.';

  @override
  String get premiumRestoreButton => 'Restaura les compres';

  @override
  String get premiumAlreadyProMessage =>
      'Ja tens «Elimina els anuncis». Gràcies!';

  @override
  String get supportSectionTitle => 'Assistència';

  @override
  String get shareDebugLogButton => 'Comparteix el registre de depuració';

  @override
  String get shareDebugLogSubtitle =>
      'Envia un informe tècnic si alguna cosa no funciona';

  @override
  String get noDebugLogMessage => 'Encara no hi ha res per informar.';

  @override
  String get clearDebugLogButton => 'Esborra el registre de depuració';

  @override
  String get clearDebugLogTitle => 'Vols esborrar el registre de depuració?';

  @override
  String get clearDebugLogBody =>
      'L’informe tècnic desat s’eliminarà del teu dispositiu.';

  @override
  String get debugLogClearedMessage =>
      'S’ha esborrat el registre de depuració.';

  @override
  String get premiumUnlockLabel => 'Elimina els anuncis per sempre';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Totes';

  @override
  String get chipNotebooks => 'Llibretes';

  @override
  String get chipRecent => 'Recents';

  @override
  String get emptyAllNotesTitle => 'Encara no hi ha notes';

  @override
  String get emptyAllNotesBody => 'Toca + per escriure la teva primera nota.';

  @override
  String get emptyRecentNotesTitle => 'Res de recent';

  @override
  String get emptyRecentNotesBody => 'Les notes que editis apareixeran aquí.';

  @override
  String get noteActionRename => 'Canvia el nom';

  @override
  String get noteActionMoveToNotebook => 'Mou a una llibreta';

  @override
  String get noteActionEdit => 'Edita';

  @override
  String get noteActionExport => 'Exporta';

  @override
  String get noteActionShare => 'Comparteix';

  @override
  String get moveToNotebookTitle => 'Mou a una llibreta';

  @override
  String get moveToNotebookEmptyBody =>
      'Encara no hi ha altres llibretes. Crea’n una per organitzar aquesta nota.';

  @override
  String get moveToNotebookCreateRow => 'Crea una llibreta nova';

  @override
  String get notebookActionRename => 'Canvia el nom';

  @override
  String get notebookActionChangeCover => 'Canvia la coberta';

  @override
  String get notebookRenameDialogTitle => 'Canvia el nom de la llibreta';

  @override
  String get notebookCoverPickerTitle => 'Tria el color de la coberta';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'La llibreta se suprimirà juntament amb totes les notes (en total: $count). Aquesta acció no es pot desfer.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Informació legal i assistència';

  @override
  String get privacyPolicyRow => 'Política de privadesa';

  @override
  String get termsOfServiceRow => 'Condicions del servei';

  @override
  String get supportRow => 'Assistència';

  @override
  String get openLinkFailedMessage =>
      'No s’ha pogut obrir l’enllaç. Torna-ho a provar.';

  @override
  String get openSourceLicensesRow => 'Llicències de codi obert';
}
