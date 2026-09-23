// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get errorGeneric => 'Etwas ist schiefgelaufen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get undo => 'Rückgängig';

  @override
  String get redo => 'Wiederholen';

  @override
  String get untitledNote => 'Ohne Titel';

  @override
  String get deleteConfirmBody => 'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get deleteNoteTitle => 'Diese Notiz löschen?';

  @override
  String deleteNotebookTitle(String name) {
    return '„$name“ löschen?';
  }

  @override
  String get saveFailedMessage =>
      'Speichern fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get exportFailedMessage =>
      'Export der Notiz fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get shareFailedMessage =>
      'Teilen-Menü konnte nicht geöffnet werden. Bitte erneut versuchen.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get searchHint => 'Notizen durchsuchen';

  @override
  String get emptyNotebooksTitle => 'Noch keine Notizbücher';

  @override
  String get emptyNotebooksBody =>
      'Erstelle dein erstes Notizbuch, um mit dem Schreiben zu beginnen.';

  @override
  String get emptySearchTitle => 'Keine Ergebnisse';

  @override
  String get emptySearchBody => 'Versuche einen anderen Suchbegriff.';

  @override
  String get emptyNotebookTitle => 'Noch keine Notizen';

  @override
  String get emptyNotebookBody =>
      'Tippe auf +, um deine erste Notiz zu schreiben.';

  @override
  String get newNotebookTitle => 'Neues Notizbuch';

  @override
  String get notebookNameHint => 'Name des Notizbuchs';

  @override
  String get newNoteTitle => 'Neue Notiz';

  @override
  String get sortOptionsTitle => 'Sortieren';

  @override
  String get sortByModified => 'Zuletzt bearbeitet';

  @override
  String get sortByCreated => 'Erstellungsdatum';

  @override
  String get sortByTitle => 'Titel';

  @override
  String get formatBold => 'Fett';

  @override
  String get formatItalic => 'Kursiv';

  @override
  String get formatUnderline => 'Unterstrichen';

  @override
  String get formatHeading => 'Überschrift';

  @override
  String get formatBulletList => 'Aufzählung';

  @override
  String get formatChecklist => 'Checkliste';

  @override
  String get formatQuote => 'Zitat';

  @override
  String get formatCodeBlock => 'Codeblock';

  @override
  String get penFountainPen => 'Füllfederhalter';

  @override
  String get penGelPen => 'Gelstift';

  @override
  String get penPencil => 'Bleistift';

  @override
  String get penHighlighter => 'Textmarker';

  @override
  String get penEraser => 'Radiergummi';

  @override
  String get penStrokeWidth => 'Strichstärke';

  @override
  String get toggleHandwritingMode => 'Zwischen Tippen und Zeichnen wechseln';

  @override
  String get biometricLockReason => 'Entsperren, um diese Notiz anzuzeigen';

  @override
  String get noteLockedMessage => 'Diese Notiz ist gesperrt';

  @override
  String get unlockButton => 'Entsperren';

  @override
  String get exportTitle => 'Exportieren';

  @override
  String get exportAsTxt => 'Als Text exportieren';

  @override
  String get exportAsPdf => 'Als PDF exportieren';

  @override
  String get paperStyleSectionTitle => 'Papierstil';

  @override
  String get paperStyleLined => 'Liniert';

  @override
  String get paperStyleDotGrid => 'Punktraster';

  @override
  String get paperStyleGrid => 'Kariert';

  @override
  String get paperStyleBlank => 'Blanko';

  @override
  String get paperStyleCream => 'Creme';

  @override
  String get paperStyleParchment => 'Pergament';

  @override
  String get paperStyleVellum => 'Velin';

  @override
  String get fontSectionTitle => 'Notizschrift';

  @override
  String get fontSystem => 'System';

  @override
  String get fontSerif => 'Serif';

  @override
  String get themeSectionTitle => 'Erscheinungsbild';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeParchment => 'Pergament';

  @override
  String get themeSystem => 'System';

  @override
  String get verseSectionTitle => 'Anzeige des Tagesverses';

  @override
  String get verseModeWatermark => 'Wasserzeichen';

  @override
  String get verseModeHeader => 'Kopfzeile';

  @override
  String get verseModeFooter => 'Fußzeile';

  @override
  String get verseModeOff => 'Aus';

  @override
  String get notificationsSectionTitle => 'Benachrichtigungen';

  @override
  String get dailyReminderToggle => 'Tägliche Verserinnerung';

  @override
  String get reminderTimeLabel => 'Erinnerungszeit';

  @override
  String get notificationPermissionDenied =>
      'Benachrichtigungen sind in den Systemeinstellungen deaktiviert.';

  @override
  String get dailyReminderBody => 'Dein Tagesvers ist bereit.';

  @override
  String get privacySectionTitle => 'Datenschutz';

  @override
  String get biometricLockToggle =>
      'Notizen mit Face ID / Fingerabdruck sperren';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Werbung entfernen';

  @override
  String get restorePurchasesButton => 'Käufe wiederherstellen';

  @override
  String get proLabel => 'Pro';

  @override
  String get languageSectionTitle => 'Sprache';

  @override
  String get languageFollowsSystem =>
      'Folgt der Spracheinstellung deines Geräts';

  @override
  String get premiumScreenTitle => 'Werbung entfernen';

  @override
  String get premiumHeadline => 'Schreibe ohne Ablenkung';

  @override
  String get premiumBody =>
      'Atrament ist kostenlos mit einem kleinen Banner-Werbeplatz. Die Entfernung ist ein einmaliger Kauf, der nichts anderes freischaltet — alle Funktionen gehören dir bereits.';

  @override
  String get premiumRestoreButton => 'Käufe wiederherstellen';

  @override
  String get premiumAlreadyProMessage =>
      'Du hast bereits Werbung entfernen. Danke!';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get shareDebugLogButton => 'Debug-Protokoll teilen';

  @override
  String get shareDebugLogSubtitle =>
      'Sende einen technischen Bericht, wenn etwas nicht funktioniert';

  @override
  String get noDebugLogMessage => 'Bisher nichts zu melden.';

  @override
  String get clearDebugLogButton => 'Debug-Protokoll löschen';

  @override
  String get clearDebugLogTitle => 'Debug-Protokoll löschen?';

  @override
  String get clearDebugLogBody =>
      'Dadurch wird der gespeicherte technische Bericht von deinem Gerät entfernt.';

  @override
  String get debugLogClearedMessage => 'Debug-Protokoll gelöscht.';

  @override
  String get premiumUnlockLabel => 'Werbung dauerhaft entfernen';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';
}
