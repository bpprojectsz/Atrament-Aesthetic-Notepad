// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Δοκιμάστε ξανά';

  @override
  String get errorGeneric => 'Κάτι πήγε στραβά';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get undo => 'Αναίρεση';

  @override
  String get redo => 'Επανάληψη';

  @override
  String get untitledNote => 'Χωρίς τίτλο';

  @override
  String get deleteConfirmBody => 'Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';

  @override
  String get deleteNoteTitle => 'Να διαγραφεί αυτή η σημείωση;';

  @override
  String deleteNotebookTitle(String name) {
    return 'Να διαγραφεί το «$name»;';
  }

  @override
  String get saveFailedMessage =>
      'Δεν ήταν δυνατή η αποθήκευση. Δοκιμάστε ξανά.';

  @override
  String get exportFailedMessage =>
      'Δεν ήταν δυνατή η εξαγωγή της σημείωσης. Δοκιμάστε ξανά.';

  @override
  String get shareFailedMessage =>
      'Δεν ήταν δυνατό το άνοιγμα του μενού κοινής χρήσης. Δοκιμάστε ξανά.';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get searchHint => 'Αναζήτηση σημειώσεων';

  @override
  String get emptyNotebooksTitle => 'Δεν υπάρχουν ακόμη τετράδια';

  @override
  String get emptyNotebooksBody =>
      'Δημιουργήστε το πρώτο σας τετράδιο για να αρχίσετε να γράφετε.';

  @override
  String get emptySearchTitle => 'Δεν βρέθηκαν αποτελέσματα';

  @override
  String get emptySearchBody => 'Δοκιμάστε διαφορετικό όρο αναζήτησης.';

  @override
  String get emptyNotebookTitle => 'Δεν υπάρχουν ακόμη σημειώσεις';

  @override
  String get emptyNotebookBody =>
      'Πατήστε + για να γράψετε την πρώτη σας σημείωση.';

  @override
  String get newNotebookTitle => 'Νέο τετράδιο';

  @override
  String get notebookNameHint => 'Όνομα τετραδίου';

  @override
  String get newNoteTitle => 'Νέα σημείωση';

  @override
  String get sortOptionsTitle => 'Ταξινόμηση';

  @override
  String get sortByModified => 'Τελευταία επεξεργασία';

  @override
  String get sortByCreated => 'Ημερομηνία δημιουργίας';

  @override
  String get sortByTitle => 'Τίτλος';

  @override
  String get formatBold => 'Έντονα';

  @override
  String get formatItalic => 'Πλάγια';

  @override
  String get formatUnderline => 'Υπογράμμιση';

  @override
  String get formatHeading => 'Επικεφαλίδα';

  @override
  String get formatBulletList => 'Λίστα με κουκκίδες';

  @override
  String get formatChecklist => 'Λίστα ελέγχου';

  @override
  String get formatQuote => 'Παράθεση';

  @override
  String get formatCodeBlock => 'Μπλοκ κώδικα';

  @override
  String get penFountainPen => 'Πένα';

  @override
  String get penGelPen => 'Στυλό γέλης';

  @override
  String get penPencil => 'Μολύβι';

  @override
  String get penHighlighter => 'Μαρκαδόρος υπογράμμισης';

  @override
  String get penEraser => 'Γόμα';

  @override
  String get penStrokeWidth => 'Πάχος γραμμής';

  @override
  String get toggleHandwritingMode =>
      'Εναλλαγή μεταξύ πληκτρολόγησης και σχεδίασης';

  @override
  String get biometricLockReason => 'Ξεκλειδώστε για να δείτε τη σημείωση';

  @override
  String get noteLockedMessage => 'Αυτή η σημείωση είναι κλειδωμένη';

  @override
  String get unlockButton => 'Ξεκλείδωμα';

  @override
  String get noteLockTurnedOffMessage =>
      'Το κλείδωμα σημειώσεων απενεργοποιήθηκε επειδή αυτή η συσκευή δεν έχει ρυθμισμένο κλείδωμα οθόνης ή βιομετρικά.';

  @override
  String get biometricEnableReason =>
      'Επιβεβαιώστε την ταυτότητά σας για να ενεργοποιήσετε το κλείδωμα σημειώσεων';

  @override
  String get biometricDisableReason =>
      'Επιβεβαιώστε την ταυτότητά σας για να απενεργοποιήσετε το κλείδωμα σημειώσεων';

  @override
  String get biometricShareReason =>
      'Ξεκλειδώστε για να μοιραστείτε ή να εξαγάγετε τη σημείωση';

  @override
  String get biometricAuthFailedMessage =>
      'Δεν ήταν δυνατή η επαλήθευση της ταυτότητάς σας.';

  @override
  String get biometricSetupNeededMessage =>
      'Ρυθμίστε πρώτα ένα κλείδωμα οθόνης ή δακτυλικό αποτύπωμα στις ρυθμίσεις της συσκευής.';

  @override
  String get privacyChoicesTitle => 'Επιλογές απορρήτου';

  @override
  String get purchaseFailedMessage =>
      'Δεν ήταν δυνατή η ολοκλήρωση της αγοράς. Δοκιμάστε ξανά.';

  @override
  String get restoreSuccessMessage => 'Η αγορά σας επαναφέρθηκε.';

  @override
  String get restoreNothingFoundMessage =>
      'Δεν βρέθηκε προηγούμενη αγορά για αυτόν τον λογαριασμό.';

  @override
  String get restoreFailedMessage =>
      'Δεν ήταν δυνατή η επαναφορά των αγορών. Ελέγξτε τη σύνδεσή σας και δοκιμάστε ξανά.';

  @override
  String get reminderScheduleFailedMessage =>
      'Δεν ήταν δυνατός ο προγραμματισμός της υπενθύμισης. Δοκιμάστε ξανά.';

  @override
  String get storageIssueNotebooksLoad =>
      'Ορισμένα τετράδια δεν φορτώθηκαν. Εμφανίζονται όσα είναι διαθέσιμα.';

  @override
  String get storageIssueNotebookSave =>
      'Αυτό το τετράδιο ίσως δεν αποθηκεύτηκε. Δοκιμάστε ξανά.';

  @override
  String get storageIssueNotebookChange =>
      'Αυτή η αλλαγή ίσως δεν αποθηκεύτηκε. Δοκιμάστε ξανά.';

  @override
  String get storageIssueNotebookDelete =>
      'Δεν ήταν δυνατή η διαγραφή του τετραδίου. Δοκιμάστε ξανά.';

  @override
  String get storageIssueNotebookOrder =>
      'Η νέα σειρά ίσως δεν αποθηκεύτηκε. Δοκιμάστε ξανά.';

  @override
  String get storageIssueNotesLoad =>
      'Ορισμένες σημειώσεις δεν φορτώθηκαν. Εμφανίζονται όσες είναι διαθέσιμες.';

  @override
  String get storageIssueSearch =>
      'Τα αποτελέσματα αναζήτησης ενδέχεται να είναι ελλιπή αυτή τη στιγμή.';

  @override
  String get storageIssueNoteSave =>
      'Αυτή η σημείωση ίσως δεν αποθηκεύτηκε. Ελέγξτε τον αποθηκευτικό χώρο της συσκευής.';

  @override
  String get storageIssueNoteDelete =>
      'Δεν ήταν δυνατή η διαγραφή της σημείωσης. Δοκιμάστε ξανά.';

  @override
  String get purchaseUnavailableMessage =>
      'Αυτή η αγορά δεν είναι διαθέσιμη αυτή τη στιγμή. Δοκιμάστε ξανά αργότερα.';

  @override
  String get exportTitle => 'Εξαγωγή';

  @override
  String get exportAsTxt => 'Εξαγωγή ως κείμενο';

  @override
  String get exportAsPdf => 'Εξαγωγή ως PDF';

  @override
  String get paperStyleSectionTitle => 'Στυλ χαρτιού';

  @override
  String get paperStyleLined => 'Με γραμμές';

  @override
  String get paperStyleDotGrid => 'Με τελείες';

  @override
  String get paperStyleGrid => 'Καρέ';

  @override
  String get paperStyleBlank => 'Λευκό';

  @override
  String get paperStyleCream => 'Κρεμ';

  @override
  String get paperStyleParchment => 'Περγαμηνή';

  @override
  String get paperStyleVellum => 'Μεμβράνη';

  @override
  String get fontSectionTitle => 'Γραμματοσειρά σημειώσεων';

  @override
  String get fontSystem => 'Συστήματος';

  @override
  String get fontSerif => 'Με πατούρες';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Εμφάνιση';

  @override
  String get themeLight => 'Φωτεινό';

  @override
  String get themeDark => 'Σκούρο';

  @override
  String get themeParchment => 'Περγαμηνή';

  @override
  String get themeSystem => 'Συστήματος';

  @override
  String get verseSectionTitle => 'Εμφάνιση στίχου της ημέρας';

  @override
  String get verseModeWatermark => 'Υδατογράφημα';

  @override
  String get verseModeHeader => 'Κεφαλίδα';

  @override
  String get verseModeFooter => 'Υποσέλιδο';

  @override
  String get verseModeOff => 'Ανενεργό';

  @override
  String get notificationsSectionTitle => 'Ειδοποιήσεις';

  @override
  String get dailyReminderToggle => 'Καθημερινή υπενθύμιση στίχου';

  @override
  String get reminderTimeLabel => 'Ώρα υπενθύμισης';

  @override
  String get notificationPermissionDenied =>
      'Οι ειδοποιήσεις είναι απενεργοποιημένες στις ρυθμίσεις του συστήματος.';

  @override
  String get dailyReminderBody => 'Ο στίχος της ημέρας είναι έτοιμος.';

  @override
  String get privacySectionTitle => 'Απόρρητο';

  @override
  String get biometricLockToggle =>
      'Κλείδωμα σημειώσεων με Face ID / δακτυλικό αποτύπωμα';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Κατάργηση διαφημίσεων';

  @override
  String get restorePurchasesButton => 'Επαναφορά αγορών';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Περισσότερα';

  @override
  String get rateAppTitle => 'Αξιολογήστε το Atrament';

  @override
  String get rateAppSubtitle => 'Σας αρέσει η εφαρμογή; Αφήστε μια κριτική';

  @override
  String get shareAppTitle => 'Κοινοποιήστε το Atrament';

  @override
  String get shareAppSubtitle => 'Πείτε το σε έναν φίλο';

  @override
  String get shareAppMessage =>
      'Δοκιμάστε το Atrament — ένα σημειωματάριο χωρίς περισπασμούς με υφές χαρτιού.';

  @override
  String get languageSectionTitle => 'Γλώσσα';

  @override
  String get languageFollowsSystem => 'Ακολουθεί τη γλώσσα της συσκευής';

  @override
  String get languageSystem => 'Προεπιλογή συστήματος';

  @override
  String get languagePickerTitle => 'Επιλογή γλώσσας';

  @override
  String get premiumScreenTitle => 'Κατάργηση διαφημίσεων';

  @override
  String get premiumHeadline => 'Γράψτε χωρίς περισπασμούς';

  @override
  String get premiumBody =>
      'Το Atrament είναι δωρεάν και εμφανίζει ένα μικρό διαφημιστικό μπάνερ. Η κατάργηση των διαφημίσεων είναι μια εφάπαξ αγορά που δεν ξεκλειδώνει τίποτα άλλο — όλες οι λειτουργίες είναι ήδη δικές σας.';

  @override
  String get premiumRestoreButton => 'Επαναφορά αγορών';

  @override
  String get premiumAlreadyProMessage =>
      'Έχετε ήδη την επιλογή «Κατάργηση διαφημίσεων». Ευχαριστούμε!';

  @override
  String get supportSectionTitle => 'Υποστήριξη';

  @override
  String get shareDebugLogButton => 'Κοινοποίηση αρχείου καταγραφής';

  @override
  String get shareDebugLogSubtitle =>
      'Στείλτε μια τεχνική αναφορά αν κάτι δεν λειτουργεί';

  @override
  String get noDebugLogMessage => 'Δεν υπάρχει ακόμη τίποτα προς αναφορά.';

  @override
  String get clearDebugLogButton => 'Εκκαθάριση αρχείου καταγραφής';

  @override
  String get clearDebugLogTitle =>
      'Να γίνει εκκαθάριση του αρχείου καταγραφής;';

  @override
  String get clearDebugLogBody =>
      'Η αποθηκευμένη τεχνική αναφορά θα αφαιρεθεί από τη συσκευή σας.';

  @override
  String get debugLogClearedMessage => 'Το αρχείο καταγραφής εκκαθαρίστηκε.';

  @override
  String get premiumUnlockLabel => 'Κατάργηση διαφημίσεων για πάντα';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Όλα';

  @override
  String get chipNotebooks => 'Τετράδια';

  @override
  String get chipRecent => 'Πρόσφατα';

  @override
  String get emptyAllNotesTitle => 'Δεν υπάρχουν ακόμη σημειώσεις';

  @override
  String get emptyAllNotesBody =>
      'Πατήστε + για να γράψετε την πρώτη σας σημείωση.';

  @override
  String get emptyRecentNotesTitle => 'Τίποτα πρόσφατο';

  @override
  String get emptyRecentNotesBody =>
      'Οι σημειώσεις που επεξεργάζεστε θα εμφανίζονται εδώ.';

  @override
  String get noteActionRename => 'Μετονομασία';

  @override
  String get noteActionMoveToNotebook => 'Μετακίνηση σε τετράδιο';

  @override
  String get noteActionEdit => 'Επεξεργασία';

  @override
  String get noteActionExport => 'Εξαγωγή';

  @override
  String get noteActionShare => 'Κοινοποίηση';

  @override
  String get moveToNotebookTitle => 'Μετακίνηση σε τετράδιο';

  @override
  String get moveToNotebookEmptyBody =>
      'Δεν υπάρχουν ακόμη άλλα τετράδια. Δημιουργήστε ένα για να οργανώσετε αυτή τη σημείωση.';

  @override
  String get moveToNotebookCreateRow => 'Δημιουργία νέου τετραδίου';

  @override
  String get notebookActionRename => 'Μετονομασία';

  @override
  String get notebookActionChangeCover => 'Αλλαγή εξωφύλλου';

  @override
  String get notebookRenameDialogTitle => 'Μετονομασία τετραδίου';

  @override
  String get notebookCoverPickerTitle => 'Επιλέξτε χρώμα εξωφύλλου';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Το τετράδιο θα διαγραφεί μαζί με όλες τις σημειώσεις του (σύνολο: $count). Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Νομικά και υποστήριξη';

  @override
  String get privacyPolicyRow => 'Πολιτική απορρήτου';

  @override
  String get termsOfServiceRow => 'Όροι χρήσης';

  @override
  String get supportRow => 'Υποστήριξη';

  @override
  String get openLinkFailedMessage =>
      'Δεν ήταν δυνατό το άνοιγμα του συνδέσμου. Δοκιμάστε ξανά.';

  @override
  String get openSourceLicensesRow => 'Άδειες ανοιχτού κώδικα';
}
