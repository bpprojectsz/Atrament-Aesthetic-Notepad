// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get errorGeneric => 'Jokin meni pieleen';

  @override
  String get cancel => 'Peruuta';

  @override
  String get save => 'Tallenna';

  @override
  String get delete => 'Poista';

  @override
  String get undo => 'Kumoa';

  @override
  String get redo => 'Tee uudelleen';

  @override
  String get untitledNote => 'Nimetön';

  @override
  String get deleteConfirmBody => 'Tätä toimintoa ei voi kumota.';

  @override
  String get deleteNoteTitle => 'Poistetaanko tämä muistiinpano?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Poistetaanko ”$name”?';
  }

  @override
  String get saveFailedMessage => 'Tallennus epäonnistui. Yritä uudelleen.';

  @override
  String get exportFailedMessage =>
      'Muistiinpanon vienti epäonnistui. Yritä uudelleen.';

  @override
  String get shareFailedMessage =>
      'Jakovalikkoa ei voitu avata. Yritä uudelleen.';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get searchHint => 'Hae muistiinpanoista';

  @override
  String get emptyNotebooksTitle => 'Ei vielä muistikirjoja';

  @override
  String get emptyNotebooksBody =>
      'Luo ensimmäinen muistikirjasi aloittaaksesi kirjoittamisen.';

  @override
  String get emptySearchTitle => 'Ei tuloksia';

  @override
  String get emptySearchBody => 'Kokeile toista hakusanaa.';

  @override
  String get emptyNotebookTitle => 'Ei vielä muistiinpanoja';

  @override
  String get emptyNotebookBody =>
      'Napauta +, niin voit kirjoittaa ensimmäisen muistiinpanosi.';

  @override
  String get newNotebookTitle => 'Uusi muistikirja';

  @override
  String get notebookNameHint => 'Muistikirjan nimi';

  @override
  String get newNoteTitle => 'Uusi muistiinpano';

  @override
  String get sortOptionsTitle => 'Lajittelu';

  @override
  String get sortByModified => 'Viimeksi muokattu';

  @override
  String get sortByCreated => 'Luontipäivä';

  @override
  String get sortByTitle => 'Otsikko';

  @override
  String get formatBold => 'Lihavointi';

  @override
  String get formatItalic => 'Kursivointi';

  @override
  String get formatUnderline => 'Alleviivaus';

  @override
  String get formatHeading => 'Otsikko';

  @override
  String get formatBulletList => 'Luettelo';

  @override
  String get formatChecklist => 'Tarkistuslista';

  @override
  String get formatQuote => 'Lainaus';

  @override
  String get formatCodeBlock => 'Koodilohko';

  @override
  String get penFountainPen => 'Täytekynä';

  @override
  String get penGelPen => 'Geelikynä';

  @override
  String get penPencil => 'Lyijykynä';

  @override
  String get penHighlighter => 'Korostuskynä';

  @override
  String get penEraser => 'Pyyhekumi';

  @override
  String get penStrokeWidth => 'Viivan paksuus';

  @override
  String get toggleHandwritingMode =>
      'Vaihda kirjoittamisen ja piirtämisen välillä';

  @override
  String get biometricLockReason => 'Avaa lukitus nähdäksesi muistiinpanon';

  @override
  String get noteLockedMessage => 'Tämä muistiinpano on lukittu';

  @override
  String get unlockButton => 'Avaa lukitus';

  @override
  String get noteLockTurnedOffMessage =>
      'Muistiinpanojen lukitus on poistettu käytöstä, koska tälle laitteelle ei ole määritetty näytön lukitusta tai biometriikkaa.';

  @override
  String get biometricEnableReason =>
      'Vahvista henkilöllisyytesi ottaaksesi muistiinpanojen lukituksen käyttöön';

  @override
  String get biometricDisableReason =>
      'Vahvista henkilöllisyytesi poistaaksesi muistiinpanojen lukituksen käytöstä';

  @override
  String get biometricShareReason =>
      'Avaa lukitus jakaaksesi tai viedäksesi muistiinpanon';

  @override
  String get biometricAuthFailedMessage =>
      'Henkilöllisyyttäsi ei voitu vahvistaa.';

  @override
  String get biometricSetupNeededMessage =>
      'Määritä ensin näytön lukitus tai sormenjälki laitteen asetuksissa.';

  @override
  String get privacyChoicesTitle => 'Tietosuojavalinnat';

  @override
  String get purchaseFailedMessage =>
      'Ostoa ei voitu viimeistellä. Yritä uudelleen.';

  @override
  String get restoreSuccessMessage => 'Ostoksesi palautettiin.';

  @override
  String get restoreNothingFoundMessage =>
      'Tälle tilille ei löytynyt aiempia ostoksia.';

  @override
  String get restoreFailedMessage =>
      'Ostoksia ei voitu palauttaa. Tarkista yhteytesi ja yritä uudelleen.';

  @override
  String get reminderScheduleFailedMessage =>
      'Muistutusta ei voitu ajoittaa. Yritä uudelleen.';

  @override
  String get storageIssueNotebooksLoad =>
      'Joitakin muistikirjoja ei voitu ladata. Näytetään saatavilla olevat.';

  @override
  String get storageIssueNotebookSave =>
      'Tätä muistikirjaa ei ehkä tallennettu. Yritä uudelleen.';

  @override
  String get storageIssueNotebookChange =>
      'Tätä muutosta ei ehkä tallennettu. Yritä uudelleen.';

  @override
  String get storageIssueNotebookDelete =>
      'Muistikirjaa ei voitu poistaa. Yritä uudelleen.';

  @override
  String get storageIssueNotebookOrder =>
      'Uutta järjestystä ei ehkä tallennettu. Yritä uudelleen.';

  @override
  String get storageIssueNotesLoad =>
      'Joitakin muistiinpanoja ei voitu ladata. Näytetään saatavilla olevat.';

  @override
  String get storageIssueSearch =>
      'Hakutulokset voivat olla tällä hetkellä puutteellisia.';

  @override
  String get storageIssueNoteSave =>
      'Tätä muistiinpanoa ei ehkä tallennettu. Tarkista laitteen tallennustila.';

  @override
  String get storageIssueNoteDelete =>
      'Muistiinpanoa ei voitu poistaa. Yritä uudelleen.';

  @override
  String get purchaseUnavailableMessage =>
      'Tämä osto ei ole tällä hetkellä käytettävissä. Yritä myöhemmin uudelleen.';

  @override
  String get exportTitle => 'Vie';

  @override
  String get exportAsTxt => 'Vie tekstinä';

  @override
  String get exportAsPdf => 'Vie PDF-tiedostona';

  @override
  String get paperStyleSectionTitle => 'Paperityyli';

  @override
  String get paperStyleLined => 'Viivoitettu';

  @override
  String get paperStyleDotGrid => 'Pisteruudukko';

  @override
  String get paperStyleGrid => 'Ruudukko';

  @override
  String get paperStyleBlank => 'Tyhjä';

  @override
  String get paperStyleCream => 'Kermanvärinen';

  @override
  String get paperStyleParchment => 'Pergamentti';

  @override
  String get paperStyleVellum => 'Veliini';

  @override
  String get fontSectionTitle => 'Muistiinpanojen fontti';

  @override
  String get fontSystem => 'Järjestelmä';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Ulkoasu';

  @override
  String get themeLight => 'Vaalea';

  @override
  String get themeDark => 'Tumma';

  @override
  String get themeParchment => 'Pergamentti';

  @override
  String get themeSystem => 'Järjestelmä';

  @override
  String get verseSectionTitle => 'Päivän jakeen näyttö';

  @override
  String get verseModeWatermark => 'Vesileima';

  @override
  String get verseModeHeader => 'Ylätunniste';

  @override
  String get verseModeFooter => 'Alatunniste';

  @override
  String get verseModeOff => 'Pois';

  @override
  String get notificationsSectionTitle => 'Ilmoitukset';

  @override
  String get dailyReminderToggle => 'Päivittäinen jaemuistutus';

  @override
  String get reminderTimeLabel => 'Muistutuksen aika';

  @override
  String get notificationPermissionDenied =>
      'Ilmoitukset on poistettu käytöstä järjestelmän asetuksissa.';

  @override
  String get dailyReminderBody => 'Päivän jakeesi on valmis.';

  @override
  String get privacySectionTitle => 'Tietosuoja';

  @override
  String get biometricLockToggle =>
      'Lukitse muistiinpanot Face ID:llä / sormenjäljellä';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Poista mainokset';

  @override
  String get restorePurchasesButton => 'Palauta ostokset';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Lisää';

  @override
  String get rateAppTitle => 'Arvioi Atrament';

  @override
  String get rateAppSubtitle => 'Pidätkö sovelluksesta? Jätä arvostelu';

  @override
  String get shareAppTitle => 'Jaa Atrament';

  @override
  String get shareAppSubtitle => 'Kerro ystävälle';

  @override
  String get shareAppMessage =>
      'Kokeile Atramentia – häiriötön muistilehtiö paperitekstuureilla.';

  @override
  String get languageSectionTitle => 'Kieli';

  @override
  String get languageFollowsSystem => 'Noudattaa laitteen kieliasetusta';

  @override
  String get languageSystem => 'Järjestelmän oletus';

  @override
  String get languagePickerTitle => 'Valitse kieli';

  @override
  String get premiumScreenTitle => 'Poista mainokset';

  @override
  String get premiumHeadline => 'Kirjoita ilman häiriöitä';

  @override
  String get premiumBody =>
      'Atrament on ilmainen ja näyttää yhden pienen mainosbannerin. Mainosten poisto on kertaostos, joka ei avaa mitään muuta – kaikki ominaisuudet ovat jo sinun.';

  @override
  String get premiumRestoreButton => 'Palauta ostokset';

  @override
  String get premiumAlreadyProMessage =>
      'Sinulla on jo Poista mainokset. Kiitos!';

  @override
  String get supportSectionTitle => 'Tuki';

  @override
  String get shareDebugLogButton => 'Jaa virheenkorjausloki';

  @override
  String get shareDebugLogSubtitle =>
      'Lähetä tekninen raportti, jos jokin ei toimi';

  @override
  String get noDebugLogMessage => 'Ei vielä mitään ilmoitettavaa.';

  @override
  String get clearDebugLogButton => 'Tyhjennä virheenkorjausloki';

  @override
  String get clearDebugLogTitle => 'Tyhjennetäänkö virheenkorjausloki?';

  @override
  String get clearDebugLogBody =>
      'Tallennettu tekninen raportti poistetaan laitteeltasi.';

  @override
  String get debugLogClearedMessage => 'Virheenkorjausloki tyhjennettiin.';

  @override
  String get premiumUnlockLabel => 'Poista mainokset pysyvästi';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Kaikki';

  @override
  String get chipNotebooks => 'Muistikirjat';

  @override
  String get chipRecent => 'Viimeisimmät';

  @override
  String get emptyAllNotesTitle => 'Ei vielä muistiinpanoja';

  @override
  String get emptyAllNotesBody =>
      'Napauta +, niin voit kirjoittaa ensimmäisen muistiinpanosi.';

  @override
  String get emptyRecentNotesTitle => 'Ei viimeaikaisia';

  @override
  String get emptyRecentNotesBody => 'Muokkaamasi muistiinpanot näkyvät tässä.';

  @override
  String get noteActionRename => 'Nimeä uudelleen';

  @override
  String get noteActionMoveToNotebook => 'Siirrä muistikirjaan';

  @override
  String get noteActionEdit => 'Muokkaa';

  @override
  String get noteActionExport => 'Vie';

  @override
  String get noteActionShare => 'Jaa';

  @override
  String get moveToNotebookTitle => 'Siirrä muistikirjaan';

  @override
  String get moveToNotebookEmptyBody =>
      'Muita muistikirjoja ei vielä ole. Luo muistikirja järjestääksesi tämän muistiinpanon.';

  @override
  String get moveToNotebookCreateRow => 'Luo uusi muistikirja';

  @override
  String get notebookActionRename => 'Nimeä uudelleen';

  @override
  String get notebookActionChangeCover => 'Vaihda kansi';

  @override
  String get notebookRenameDialogTitle => 'Nimeä muistikirja uudelleen';

  @override
  String get notebookCoverPickerTitle => 'Valitse kannen väri';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Muistikirja poistetaan kaikkine muistiinpanoineen (yhteensä: $count). Tätä toimintoa ei voi kumota.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Oikeudelliset tiedot ja tuki';

  @override
  String get privacyPolicyRow => 'Tietosuojakäytäntö';

  @override
  String get termsOfServiceRow => 'Käyttöehdot';

  @override
  String get supportRow => 'Tuki';

  @override
  String get openLinkFailedMessage =>
      'Linkkiä ei voitu avata. Yritä uudelleen.';

  @override
  String get openSourceLicensesRow => 'Avoimen lähdekoodin lisenssit';
}
