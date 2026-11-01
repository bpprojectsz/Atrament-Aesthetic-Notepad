// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Újrapróbálás';

  @override
  String get errorGeneric => 'Valami hiba történt';

  @override
  String get cancel => 'Mégse';

  @override
  String get save => 'Mentés';

  @override
  String get delete => 'Törlés';

  @override
  String get undo => 'Visszavonás';

  @override
  String get redo => 'Ismétlés';

  @override
  String get untitledNote => 'Cím nélkül';

  @override
  String get deleteConfirmBody => 'Ez a művelet nem vonható vissza.';

  @override
  String get deleteNoteTitle => 'Törlöd ezt a jegyzetet?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Törlöd a(z) „$name” jegyzetfüzetet?';
  }

  @override
  String get saveFailedMessage => 'A mentés nem sikerült. Próbáld újra.';

  @override
  String get exportFailedMessage =>
      'A jegyzet exportálása nem sikerült. Próbáld újra.';

  @override
  String get shareFailedMessage =>
      'A megosztás menü nem nyitható meg. Próbáld újra.';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get searchHint => 'Keresés a jegyzetekben';

  @override
  String get emptyNotebooksTitle => 'Még nincsenek jegyzetfüzetek';

  @override
  String get emptyNotebooksBody =>
      'Hozd létre az első jegyzetfüzeted, és kezdj el írni.';

  @override
  String get emptySearchTitle => 'Nincs találat';

  @override
  String get emptySearchBody => 'Próbálj meg másik keresőszót.';

  @override
  String get emptyNotebookTitle => 'Még nincsenek jegyzetek';

  @override
  String get emptyNotebookBody =>
      'Koppints a + gombra az első jegyzeted megírásához.';

  @override
  String get newNotebookTitle => 'Új jegyzetfüzet';

  @override
  String get notebookNameHint => 'Jegyzetfüzet neve';

  @override
  String get newNoteTitle => 'Új jegyzet';

  @override
  String get sortOptionsTitle => 'Rendezés';

  @override
  String get sortByModified => 'Utoljára szerkesztve';

  @override
  String get sortByCreated => 'Létrehozás dátuma';

  @override
  String get sortByTitle => 'Cím';

  @override
  String get formatBold => 'Félkövér';

  @override
  String get formatItalic => 'Dőlt';

  @override
  String get formatUnderline => 'Aláhúzott';

  @override
  String get formatHeading => 'Címsor';

  @override
  String get formatBulletList => 'Felsorolás';

  @override
  String get formatChecklist => 'Ellenőrzőlista';

  @override
  String get formatQuote => 'Idézet';

  @override
  String get formatCodeBlock => 'Kódblokk';

  @override
  String get penFountainPen => 'Töltőtoll';

  @override
  String get penGelPen => 'Zselés toll';

  @override
  String get penPencil => 'Ceruza';

  @override
  String get penHighlighter => 'Szövegkiemelő';

  @override
  String get penEraser => 'Radír';

  @override
  String get penStrokeWidth => 'Vonalvastagság';

  @override
  String get toggleHandwritingMode => 'Váltás a gépelés és a rajzolás között';

  @override
  String get biometricLockReason => 'Oldd fel a jegyzet megtekintéséhez';

  @override
  String get noteLockedMessage => 'Ez a jegyzet zárolva van';

  @override
  String get unlockButton => 'Feloldás';

  @override
  String get noteLockTurnedOffMessage =>
      'A jegyzetzár ki lett kapcsolva, mert ezen az eszközön nincs beállítva képernyőzár vagy biometrikus azonosítás.';

  @override
  String get biometricEnableReason =>
      'Igazold magad a jegyzetzár bekapcsolásához';

  @override
  String get biometricDisableReason =>
      'Igazold magad a jegyzetzár kikapcsolásához';

  @override
  String get biometricShareReason =>
      'Oldd fel a jegyzet megosztásához vagy exportálásához';

  @override
  String get biometricAuthFailedMessage =>
      'Nem sikerült igazolni a személyazonosságodat.';

  @override
  String get biometricSetupNeededMessage =>
      'Először állíts be képernyőzárat vagy ujjlenyomatot az eszköz beállításaiban.';

  @override
  String get privacyChoicesTitle => 'Adatvédelmi beállítások';

  @override
  String get purchaseFailedMessage =>
      'A vásárlást nem sikerült befejezni. Próbáld újra.';

  @override
  String get restoreSuccessMessage => 'A vásárlásod vissza lett állítva.';

  @override
  String get restoreNothingFoundMessage =>
      'Ehhez a fiókhoz nem található korábbi vásárlás.';

  @override
  String get restoreFailedMessage =>
      'A vásárlásokat nem sikerült visszaállítani. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get reminderScheduleFailedMessage =>
      'Az emlékeztetőt nem sikerült beütemezni. Próbáld újra.';

  @override
  String get storageIssueNotebooksLoad =>
      'Néhány jegyzetfüzetet nem sikerült betölteni. Az elérhető tartalom látható.';

  @override
  String get storageIssueNotebookSave =>
      'Lehet, hogy ez a jegyzetfüzet nem lett mentve. Próbáld újra.';

  @override
  String get storageIssueNotebookChange =>
      'Lehet, hogy ez a módosítás nem lett mentve. Próbáld újra.';

  @override
  String get storageIssueNotebookDelete =>
      'A jegyzetfüzetet nem sikerült törölni. Próbáld újra.';

  @override
  String get storageIssueNotebookOrder =>
      'Lehet, hogy az új sorrend nem lett mentve. Próbáld újra.';

  @override
  String get storageIssueNotesLoad =>
      'Néhány jegyzetet nem sikerült betölteni. Az elérhető tartalom látható.';

  @override
  String get storageIssueSearch =>
      'A keresési eredmények jelenleg hiányosak lehetnek.';

  @override
  String get storageIssueNoteSave =>
      'Lehet, hogy ez a jegyzet nem lett mentve. Ellenőrizd az eszköz tárhelyét.';

  @override
  String get storageIssueNoteDelete =>
      'A jegyzetet nem sikerült törölni. Próbáld újra.';

  @override
  String get purchaseUnavailableMessage =>
      'Ez a vásárlás jelenleg nem érhető el. Próbáld újra később.';

  @override
  String get exportTitle => 'Exportálás';

  @override
  String get exportAsTxt => 'Exportálás szövegként';

  @override
  String get exportAsPdf => 'Exportálás PDF-ként';

  @override
  String get paperStyleSectionTitle => 'Papírstílus';

  @override
  String get paperStyleLined => 'Vonalas';

  @override
  String get paperStyleDotGrid => 'Pontozott';

  @override
  String get paperStyleGrid => 'Négyzethálós';

  @override
  String get paperStyleBlank => 'Üres';

  @override
  String get paperStyleCream => 'Krémszínű';

  @override
  String get paperStyleParchment => 'Pergamen';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Jegyzetek betűtípusa';

  @override
  String get fontSystem => 'Rendszer';

  @override
  String get fontSerif => 'Talpas';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Megjelenés';

  @override
  String get themeLight => 'Világos';

  @override
  String get themeDark => 'Sötét';

  @override
  String get themeParchment => 'Pergamen';

  @override
  String get themeSystem => 'Rendszer';

  @override
  String get verseSectionTitle => 'A nap igéjének megjelenítése';

  @override
  String get verseModeWatermark => 'Vízjel';

  @override
  String get verseModeHeader => 'Fejléc';

  @override
  String get verseModeFooter => 'Lábléc';

  @override
  String get verseModeOff => 'Ki';

  @override
  String get notificationsSectionTitle => 'Értesítések';

  @override
  String get dailyReminderToggle => 'Napi igeemlékeztető';

  @override
  String get reminderTimeLabel => 'Emlékeztető időpontja';

  @override
  String get notificationPermissionDenied =>
      'Az értesítések ki vannak kapcsolva a rendszerbeállításokban.';

  @override
  String get dailyReminderBody => 'A nap igéje elkészült.';

  @override
  String get privacySectionTitle => 'Adatvédelem';

  @override
  String get biometricLockToggle =>
      'Jegyzetek zárolása Face ID-val / ujjlenyomattal';

  @override
  String get premiumSectionTitle => 'Prémium';

  @override
  String get removeAdsTitle => 'Hirdetések eltávolítása';

  @override
  String get restorePurchasesButton => 'Vásárlások visszaállítása';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Továbbiak';

  @override
  String get rateAppTitle => 'Atrament értékelése';

  @override
  String get rateAppSubtitle => 'Tetszik az alkalmazás? Írj értékelést';

  @override
  String get shareAppTitle => 'Atrament megosztása';

  @override
  String get shareAppSubtitle => 'Mondd el egy barátodnak';

  @override
  String get shareAppMessage =>
      'Próbáld ki az Atramentet – zavartalan jegyzetfüzet papírtextúrákkal.';

  @override
  String get languageSectionTitle => 'Nyelv';

  @override
  String get languageFollowsSystem => 'Követi az eszköz nyelvi beállítását';

  @override
  String get languageSystem => 'Rendszer alapértelmezése';

  @override
  String get languagePickerTitle => 'Nyelv kiválasztása';

  @override
  String get premiumScreenTitle => 'Hirdetések eltávolítása';

  @override
  String get premiumHeadline => 'Írj zavartalanul';

  @override
  String get premiumBody =>
      'Az Atrament ingyenes, és egyetlen kis hirdetési sávot jelenít meg. A hirdetések eltávolítása egyszeri vásárlás, amely semmi mást nem old fel – minden funkció már a tiéd.';

  @override
  String get premiumRestoreButton => 'Vásárlások visszaállítása';

  @override
  String get premiumAlreadyProMessage =>
      'A Hirdetések eltávolítása már megvan. Köszönjük!';

  @override
  String get supportSectionTitle => 'Támogatás';

  @override
  String get shareDebugLogButton => 'Hibakeresési napló megosztása';

  @override
  String get shareDebugLogSubtitle =>
      'Küldj műszaki jelentést, ha valami nem működik';

  @override
  String get noDebugLogMessage => 'Még nincs mit jelenteni.';

  @override
  String get clearDebugLogButton => 'Hibakeresési napló törlése';

  @override
  String get clearDebugLogTitle => 'Törlöd a hibakeresési naplót?';

  @override
  String get clearDebugLogBody =>
      'A mentett műszaki jelentés el lesz távolítva az eszközről.';

  @override
  String get debugLogClearedMessage => 'A hibakeresési napló törölve.';

  @override
  String get premiumUnlockLabel => 'Hirdetések végleges eltávolítása';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Mind';

  @override
  String get chipNotebooks => 'Jegyzetfüzetek';

  @override
  String get chipRecent => 'Legutóbbiak';

  @override
  String get emptyAllNotesTitle => 'Még nincsenek jegyzetek';

  @override
  String get emptyAllNotesBody =>
      'Koppints a + gombra az első jegyzeted megírásához.';

  @override
  String get emptyRecentNotesTitle => 'Nincs friss elem';

  @override
  String get emptyRecentNotesBody =>
      'Itt jelennek meg a szerkesztett jegyzeteid.';

  @override
  String get noteActionRename => 'Átnevezés';

  @override
  String get noteActionMoveToNotebook => 'Áthelyezés jegyzetfüzetbe';

  @override
  String get noteActionEdit => 'Szerkesztés';

  @override
  String get noteActionExport => 'Exportálás';

  @override
  String get noteActionShare => 'Megosztás';

  @override
  String get moveToNotebookTitle => 'Áthelyezés jegyzetfüzetbe';

  @override
  String get moveToNotebookEmptyBody =>
      'Még nincs másik jegyzetfüzet. Hozz létre egyet a jegyzet rendszerezéséhez.';

  @override
  String get moveToNotebookCreateRow => 'Új jegyzetfüzet létrehozása';

  @override
  String get notebookActionRename => 'Átnevezés';

  @override
  String get notebookActionChangeCover => 'Borító cseréje';

  @override
  String get notebookRenameDialogTitle => 'Jegyzetfüzet átnevezése';

  @override
  String get notebookCoverPickerTitle => 'Válassz borítószínt';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'A jegyzetfüzet az összes jegyzetével együtt törlődik (összesen: $count). Ez a művelet nem vonható vissza.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Jogi információk és támogatás';

  @override
  String get privacyPolicyRow => 'Adatvédelmi irányelvek';

  @override
  String get termsOfServiceRow => 'Felhasználási feltételek';

  @override
  String get supportRow => 'Támogatás';

  @override
  String get openLinkFailedMessage =>
      'A hivatkozás nem nyitható meg. Próbáld újra.';

  @override
  String get openSourceLicensesRow => 'Nyílt forráskódú licencek';
}
