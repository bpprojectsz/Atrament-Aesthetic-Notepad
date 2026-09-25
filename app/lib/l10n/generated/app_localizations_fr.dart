// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Réessayer';

  @override
  String get errorGeneric => 'Une erreur est survenue';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get undo => 'Annuler';

  @override
  String get redo => 'Rétablir';

  @override
  String get untitledNote => 'Sans titre';

  @override
  String get deleteConfirmBody => 'Cette action est irréversible.';

  @override
  String get deleteNoteTitle => 'Supprimer cette note ?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Supprimer « $name » ?';
  }

  @override
  String get saveFailedMessage =>
      'Impossible d\'enregistrer. Veuillez réessayer.';

  @override
  String get exportFailedMessage =>
      'Impossible d\'exporter cette note. Veuillez réessayer.';

  @override
  String get shareFailedMessage =>
      'Impossible d\'ouvrir le menu de partage. Veuillez réessayer.';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get searchHint => 'Rechercher des notes';

  @override
  String get emptyNotebooksTitle => 'Aucun carnet pour l\'instant';

  @override
  String get emptyNotebooksBody =>
      'Créez votre premier carnet pour commencer à écrire.';

  @override
  String get emptySearchTitle => 'Aucun résultat';

  @override
  String get emptySearchBody => 'Essayez un autre terme de recherche.';

  @override
  String get emptyNotebookTitle => 'Aucune note pour l\'instant';

  @override
  String get emptyNotebookBody =>
      'Appuyez sur + pour écrire votre première note.';

  @override
  String get newNotebookTitle => 'Nouveau carnet';

  @override
  String get notebookNameHint => 'Nom du carnet';

  @override
  String get newNoteTitle => 'Nouvelle note';

  @override
  String get sortOptionsTitle => 'Trier';

  @override
  String get sortByModified => 'Dernière modification';

  @override
  String get sortByCreated => 'Date de création';

  @override
  String get sortByTitle => 'Titre';

  @override
  String get formatBold => 'Gras';

  @override
  String get formatItalic => 'Italique';

  @override
  String get formatUnderline => 'Souligné';

  @override
  String get formatHeading => 'Titre';

  @override
  String get formatBulletList => 'Liste à puces';

  @override
  String get formatChecklist => 'Liste de tâches';

  @override
  String get formatQuote => 'Citation';

  @override
  String get formatCodeBlock => 'Bloc de code';

  @override
  String get penFountainPen => 'Stylo plume';

  @override
  String get penGelPen => 'Stylo gel';

  @override
  String get penPencil => 'Crayon';

  @override
  String get penHighlighter => 'Surligneur';

  @override
  String get penEraser => 'Gomme';

  @override
  String get penStrokeWidth => 'Épaisseur du trait';

  @override
  String get toggleHandwritingMode => 'Basculer entre écrire et dessiner';

  @override
  String get biometricLockReason => 'Déverrouillez pour voir cette note';

  @override
  String get noteLockedMessage => 'Cette note est verrouillée';

  @override
  String get unlockButton => 'Déverrouiller';

  @override
  String get exportTitle => 'Exporter';

  @override
  String get exportAsTxt => 'Exporter en texte';

  @override
  String get exportAsPdf => 'Exporter en PDF';

  @override
  String get paperStyleSectionTitle => 'Style de papier';

  @override
  String get paperStyleLined => 'Ligné';

  @override
  String get paperStyleDotGrid => 'Pointillé';

  @override
  String get paperStyleGrid => 'Quadrillé';

  @override
  String get paperStyleBlank => 'Vierge';

  @override
  String get paperStyleCream => 'Crème';

  @override
  String get paperStyleParchment => 'Parchemin';

  @override
  String get paperStyleVellum => 'Vélin';

  @override
  String get fontSectionTitle => 'Police de la note';

  @override
  String get fontSystem => 'Système';

  @override
  String get fontSerif => 'Serif';

  @override
  String get themeSectionTitle => 'Apparence';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeParchment => 'Parchemin';

  @override
  String get themeSystem => 'Système';

  @override
  String get verseSectionTitle => 'Affichage du verset du jour';

  @override
  String get verseModeWatermark => 'Filigrane';

  @override
  String get verseModeHeader => 'En-tête';

  @override
  String get verseModeFooter => 'Pied de page';

  @override
  String get verseModeOff => 'Désactivé';

  @override
  String get notificationsSectionTitle => 'Notifications';

  @override
  String get dailyReminderToggle => 'Rappel quotidien du verset';

  @override
  String get reminderTimeLabel => 'Heure du rappel';

  @override
  String get notificationPermissionDenied =>
      'Les notifications sont désactivées dans les réglages système.';

  @override
  String get dailyReminderBody => 'Votre verset du jour est prêt.';

  @override
  String get privacySectionTitle => 'Confidentialité';

  @override
  String get biometricLockToggle =>
      'Verrouiller les notes avec Face ID / empreinte digitale';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Supprimer les publicités';

  @override
  String get restorePurchasesButton => 'Restaurer les achats';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Plus';

  @override
  String get rateAppTitle => 'Noter Atrament';

  @override
  String get rateAppSubtitle => 'L\'app vous plaît ? Laissez un avis';

  @override
  String get shareAppTitle => 'Partager Atrament';

  @override
  String get shareAppSubtitle => 'Parlez-en à un ami';

  @override
  String get shareAppMessage =>
      'Essayez Atrament — un bloc-notes sans distraction avec textures papier.';

  @override
  String get languageSectionTitle => 'Langue';

  @override
  String get languageFollowsSystem =>
      'Suit la langue configurée sur votre appareil';

  @override
  String get languageSystem => 'Par défaut du système';

  @override
  String get languagePickerTitle => 'Choisir la langue';

  @override
  String get premiumScreenTitle => 'Supprimer les publicités';

  @override
  String get premiumHeadline => 'Écrivez sans distraction';

  @override
  String get premiumBody =>
      'Atrament est gratuit avec une petite bannière publicitaire. La supprimer est un achat unique qui ne débloque rien d\'autre — toutes les fonctionnalités sont déjà à vous.';

  @override
  String get premiumRestoreButton => 'Restaurer les achats';

  @override
  String get premiumAlreadyProMessage =>
      'Vous avez déjà Supprimer les publicités. Merci !';

  @override
  String get supportSectionTitle => 'Assistance';

  @override
  String get shareDebugLogButton => 'Partager le journal de débogage';

  @override
  String get shareDebugLogSubtitle =>
      'Envoyez un rapport technique si quelque chose ne fonctionne pas';

  @override
  String get noDebugLogMessage => 'Aucun problème à signaler pour l\'instant.';

  @override
  String get clearDebugLogButton => 'Effacer le journal de débogage';

  @override
  String get clearDebugLogTitle => 'Effacer le journal de débogage ?';

  @override
  String get clearDebugLogBody =>
      'Cela supprime le rapport technique enregistré sur votre appareil.';

  @override
  String get debugLogClearedMessage => 'Journal de débogage effacé.';

  @override
  String get premiumUnlockLabel => 'Supprimer les pubs définitivement';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'All';

  @override
  String get chipNotebooks => 'Notebooks';

  @override
  String get chipRecent => 'Recent';

  @override
  String get emptyAllNotesTitle => 'No notes yet';

  @override
  String get emptyAllNotesBody => 'Tap the + button to write your first note.';

  @override
  String get emptyRecentNotesTitle => 'Nothing recent';

  @override
  String get emptyRecentNotesBody => 'Notes you edit will show up here.';

  @override
  String get noteActionRename => 'Rename';

  @override
  String get noteActionMoveToNotebook => 'Move to Notebook';

  @override
  String get noteActionEdit => 'Edit';

  @override
  String get noteActionExport => 'Export';

  @override
  String get noteActionShare => 'Share';

  @override
  String get moveToNotebookTitle => 'Move to Notebook';

  @override
  String get moveToNotebookEmptyBody =>
      'No other notebooks yet. Create one to organise this note.';

  @override
  String get moveToNotebookCreateRow => 'Create new notebook';

  @override
  String get notebookActionRename => 'Rename';

  @override
  String get notebookActionChangeCover => 'Change cover';

  @override
  String get notebookRenameDialogTitle => 'Rename Notebook';

  @override
  String get notebookCoverPickerTitle => 'Choose a cover color';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'This will delete the notebook and its $count notes. This can\'t be undone.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Legal & Support';

  @override
  String get privacyPolicyRow => 'Privacy Policy';

  @override
  String get termsOfServiceRow => 'Terms of Service';

  @override
  String get supportRow => 'Support';

  @override
  String get openLinkFailedMessage =>
      'Couldn\'t open the link. Please try again.';
}
