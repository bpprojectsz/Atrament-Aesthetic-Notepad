// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Reîncearcă';

  @override
  String get errorGeneric => 'Ceva nu a mers bine';

  @override
  String get cancel => 'Anulează';

  @override
  String get save => 'Salvează';

  @override
  String get delete => 'Șterge';

  @override
  String get undo => 'Desfă';

  @override
  String get redo => 'Refă';

  @override
  String get untitledNote => 'Fără titlu';

  @override
  String get deleteConfirmBody => 'Această acțiune nu poate fi anulată.';

  @override
  String get deleteNoteTitle => 'Ștergi această notă?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Ștergi „$name”?';
  }

  @override
  String get saveFailedMessage => 'Nu s-a putut salva. Încearcă din nou.';

  @override
  String get exportFailedMessage =>
      'Nu s-a putut exporta nota. Încearcă din nou.';

  @override
  String get shareFailedMessage =>
      'Nu s-a putut deschide meniul de distribuire. Încearcă din nou.';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get searchHint => 'Caută în note';

  @override
  String get emptyNotebooksTitle => 'Încă nu există caiete';

  @override
  String get emptyNotebooksBody =>
      'Creează primul caiet ca să începi să scrii.';

  @override
  String get emptySearchTitle => 'Niciun rezultat';

  @override
  String get emptySearchBody => 'Încearcă alt termen de căutare.';

  @override
  String get emptyNotebookTitle => 'Încă nu există note';

  @override
  String get emptyNotebookBody => 'Atinge + ca să scrii prima notă.';

  @override
  String get newNotebookTitle => 'Caiet nou';

  @override
  String get notebookNameHint => 'Numele caietului';

  @override
  String get newNoteTitle => 'Notă nouă';

  @override
  String get sortOptionsTitle => 'Sortare';

  @override
  String get sortByModified => 'Ultima modificare';

  @override
  String get sortByCreated => 'Data creării';

  @override
  String get sortByTitle => 'Titlu';

  @override
  String get formatBold => 'Aldin';

  @override
  String get formatItalic => 'Cursiv';

  @override
  String get formatUnderline => 'Subliniat';

  @override
  String get formatHeading => 'Titlu';

  @override
  String get formatBulletList => 'Listă cu buline';

  @override
  String get formatChecklist => 'Listă de sarcini';

  @override
  String get formatQuote => 'Citat';

  @override
  String get formatCodeBlock => 'Bloc de cod';

  @override
  String get penFountainPen => 'Stilou';

  @override
  String get penGelPen => 'Pix cu gel';

  @override
  String get penPencil => 'Creion';

  @override
  String get penHighlighter => 'Textmarker';

  @override
  String get penEraser => 'Radieră';

  @override
  String get penStrokeWidth => 'Grosimea liniei';

  @override
  String get toggleHandwritingMode => 'Comută între scriere și desenare';

  @override
  String get biometricLockReason => 'Deblochează pentru a vedea nota';

  @override
  String get noteLockedMessage => 'Această notă este blocată';

  @override
  String get unlockButton => 'Deblochează';

  @override
  String get noteLockTurnedOffMessage =>
      'Blocarea notelor a fost dezactivată deoarece acest dispozitiv nu are blocare a ecranului sau biometrie configurate.';

  @override
  String get biometricEnableReason =>
      'Confirmă-ți identitatea pentru a activa blocarea notelor';

  @override
  String get biometricDisableReason =>
      'Confirmă-ți identitatea pentru a dezactiva blocarea notelor';

  @override
  String get biometricShareReason =>
      'Deblochează pentru a distribui sau exporta nota';

  @override
  String get biometricAuthFailedMessage =>
      'Identitatea ta nu a putut fi verificată.';

  @override
  String get biometricSetupNeededMessage =>
      'Mai întâi configurează blocarea ecranului sau amprenta în setările dispozitivului.';

  @override
  String get privacyChoicesTitle => 'Opțiuni de confidențialitate';

  @override
  String get purchaseFailedMessage =>
      'Achiziția nu a putut fi finalizată. Încearcă din nou.';

  @override
  String get restoreSuccessMessage => 'Achiziția ta a fost restaurată.';

  @override
  String get restoreNothingFoundMessage =>
      'Nu a fost găsită nicio achiziție anterioară pentru acest cont.';

  @override
  String get restoreFailedMessage =>
      'Achizițiile nu au putut fi restaurate. Verifică conexiunea și încearcă din nou.';

  @override
  String get reminderScheduleFailedMessage =>
      'Memento-ul nu a putut fi programat. Încearcă din nou.';

  @override
  String get storageIssueNotebooksLoad =>
      'Unele caiete nu au putut fi încărcate. Se afișează ce este disponibil.';

  @override
  String get storageIssueNotebookSave =>
      'Este posibil ca acest caiet să nu fi fost salvat. Încearcă din nou.';

  @override
  String get storageIssueNotebookChange =>
      'Este posibil ca această modificare să nu fi fost salvată. Încearcă din nou.';

  @override
  String get storageIssueNotebookDelete =>
      'Caietul nu a putut fi șters. Încearcă din nou.';

  @override
  String get storageIssueNotebookOrder =>
      'Este posibil ca noua ordine să nu fi fost salvată. Încearcă din nou.';

  @override
  String get storageIssueNotesLoad =>
      'Unele note nu au putut fi încărcate. Se afișează ce este disponibil.';

  @override
  String get storageIssueSearch =>
      'Rezultatele căutării pot fi incomplete acum.';

  @override
  String get storageIssueNoteSave =>
      'Este posibil ca această notă să nu fi fost salvată. Verifică spațiul de stocare al dispozitivului.';

  @override
  String get storageIssueNoteDelete =>
      'Nota nu a putut fi ștearsă. Încearcă din nou.';

  @override
  String get purchaseUnavailableMessage =>
      'Această achiziție nu este disponibilă acum. Încearcă din nou mai târziu.';

  @override
  String get exportTitle => 'Export';

  @override
  String get exportAsTxt => 'Exportă ca text';

  @override
  String get exportAsPdf => 'Exportă ca PDF';

  @override
  String get paperStyleSectionTitle => 'Stil de hârtie';

  @override
  String get paperStyleLined => 'Liniată';

  @override
  String get paperStyleDotGrid => 'Cu puncte';

  @override
  String get paperStyleGrid => 'Cu pătrățele';

  @override
  String get paperStyleBlank => 'Goală';

  @override
  String get paperStyleCream => 'Crem';

  @override
  String get paperStyleParchment => 'Pergament';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Fontul notelor';

  @override
  String get fontSystem => 'Sistem';

  @override
  String get fontSerif => 'Cu serife';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Aspect';

  @override
  String get themeLight => 'Luminos';

  @override
  String get themeDark => 'Întunecat';

  @override
  String get themeParchment => 'Pergament';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get verseSectionTitle => 'Afișarea versetului zilei';

  @override
  String get verseModeWatermark => 'Filigran';

  @override
  String get verseModeHeader => 'Antet';

  @override
  String get verseModeFooter => 'Subsol';

  @override
  String get verseModeOff => 'Dezactivat';

  @override
  String get notificationsSectionTitle => 'Notificări';

  @override
  String get dailyReminderToggle => 'Memento zilnic cu verset';

  @override
  String get reminderTimeLabel => 'Ora memento-ului';

  @override
  String get notificationPermissionDenied =>
      'Notificările sunt dezactivate în setările sistemului.';

  @override
  String get dailyReminderBody => 'Versetul tău zilnic este gata.';

  @override
  String get privacySectionTitle => 'Confidențialitate';

  @override
  String get biometricLockToggle => 'Blochează notele cu Face ID / amprentă';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Elimină reclamele';

  @override
  String get restorePurchasesButton => 'Restaurează achizițiile';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Mai multe';

  @override
  String get rateAppTitle => 'Evaluează Atrament';

  @override
  String get rateAppSubtitle => 'Îți place aplicația? Lasă o recenzie';

  @override
  String get shareAppTitle => 'Distribuie Atrament';

  @override
  String get shareAppSubtitle => 'Spune-i unui prieten';

  @override
  String get shareAppMessage =>
      'Încearcă Atrament — un carnet de notițe fără distrageri, cu texturi de hârtie.';

  @override
  String get languageSectionTitle => 'Limbă';

  @override
  String get languageFollowsSystem => 'Urmează limba dispozitivului';

  @override
  String get languageSystem => 'Implicit din sistem';

  @override
  String get languagePickerTitle => 'Alege limba';

  @override
  String get premiumScreenTitle => 'Elimină reclamele';

  @override
  String get premiumHeadline => 'Scrie fără distrageri';

  @override
  String get premiumBody =>
      'Atrament este gratuit și afișează un singur banner publicitar mic. Eliminarea reclamelor este o achiziție unică ce nu deblochează nimic altceva — toate funcțiile sunt deja ale tale.';

  @override
  String get premiumRestoreButton => 'Restaurează achizițiile';

  @override
  String get premiumAlreadyProMessage =>
      'Ai deja „Elimină reclamele”. Mulțumim!';

  @override
  String get supportSectionTitle => 'Asistență';

  @override
  String get shareDebugLogButton => 'Distribuie jurnalul de depanare';

  @override
  String get shareDebugLogSubtitle =>
      'Trimite un raport tehnic dacă ceva nu funcționează';

  @override
  String get noDebugLogMessage => 'Încă nu este nimic de raportat.';

  @override
  String get clearDebugLogButton => 'Șterge jurnalul de depanare';

  @override
  String get clearDebugLogTitle => 'Ștergi jurnalul de depanare?';

  @override
  String get clearDebugLogBody =>
      'Raportul tehnic salvat va fi eliminat de pe dispozitiv.';

  @override
  String get debugLogClearedMessage => 'Jurnalul de depanare a fost șters.';

  @override
  String get premiumUnlockLabel => 'Elimină reclamele pentru totdeauna';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Toate';

  @override
  String get chipNotebooks => 'Caiete';

  @override
  String get chipRecent => 'Recente';

  @override
  String get emptyAllNotesTitle => 'Încă nu există note';

  @override
  String get emptyAllNotesBody => 'Atinge + ca să scrii prima notă.';

  @override
  String get emptyRecentNotesTitle => 'Nimic recent';

  @override
  String get emptyRecentNotesBody =>
      'Notele pe care le editezi vor apărea aici.';

  @override
  String get noteActionRename => 'Redenumește';

  @override
  String get noteActionMoveToNotebook => 'Mută în caiet';

  @override
  String get noteActionEdit => 'Editează';

  @override
  String get noteActionExport => 'Exportă';

  @override
  String get noteActionShare => 'Distribuie';

  @override
  String get moveToNotebookTitle => 'Mută în caiet';

  @override
  String get moveToNotebookEmptyBody =>
      'Nu există încă alte caiete. Creează unul pentru a organiza această notă.';

  @override
  String get moveToNotebookCreateRow => 'Creează un caiet nou';

  @override
  String get notebookActionRename => 'Redenumește';

  @override
  String get notebookActionChangeCover => 'Schimbă coperta';

  @override
  String get notebookRenameDialogTitle => 'Redenumește caietul';

  @override
  String get notebookCoverPickerTitle => 'Alege culoarea copertei';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Caietul va fi șters împreună cu toate notele din el (în total: $count). Această acțiune nu poate fi anulată.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Informații legale și asistență';

  @override
  String get privacyPolicyRow => 'Politica de confidențialitate';

  @override
  String get termsOfServiceRow => 'Termeni și condiții';

  @override
  String get supportRow => 'Asistență';

  @override
  String get openLinkFailedMessage =>
      'Linkul nu a putut fi deschis. Încearcă din nou.';

  @override
  String get openSourceLicensesRow => 'Licențe open source';
}
