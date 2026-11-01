// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Jaribu tena';

  @override
  String get errorGeneric => 'Hitilafu imetokea';

  @override
  String get cancel => 'Ghairi';

  @override
  String get save => 'Hifadhi';

  @override
  String get delete => 'Futa';

  @override
  String get undo => 'Tendua';

  @override
  String get redo => 'Rudia';

  @override
  String get untitledNote => 'Bila kichwa';

  @override
  String get deleteConfirmBody => 'Kitendo hiki hakiwezi kutenduliwa.';

  @override
  String get deleteNoteTitle => 'Futa dokezo hili?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Futa “$name”?';
  }

  @override
  String get saveFailedMessage =>
      'Imeshindwa kuhifadhi. Tafadhali jaribu tena.';

  @override
  String get exportFailedMessage =>
      'Imeshindwa kusafirisha dokezo hili. Tafadhali jaribu tena.';

  @override
  String get shareFailedMessage =>
      'Imeshindwa kufungua menyu ya kushiriki. Tafadhali jaribu tena.';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get searchHint => 'Tafuta madokezo';

  @override
  String get emptyNotebooksTitle => 'Bado hakuna daftari';

  @override
  String get emptyNotebooksBody =>
      'Tengeneza daftari lako la kwanza ili uanze kuandika.';

  @override
  String get emptySearchTitle => 'Hakuna matokeo';

  @override
  String get emptySearchBody => 'Jaribu neno lingine la kutafuta.';

  @override
  String get emptyNotebookTitle => 'Bado hakuna madokezo';

  @override
  String get emptyNotebookBody => 'Gusa + ili uandike dokezo lako la kwanza.';

  @override
  String get newNotebookTitle => 'Daftari jipya';

  @override
  String get notebookNameHint => 'Jina la daftari';

  @override
  String get newNoteTitle => 'Dokezo jipya';

  @override
  String get sortOptionsTitle => 'Panga';

  @override
  String get sortByModified => 'Ilihaririwa mwisho';

  @override
  String get sortByCreated => 'Tarehe ya kuundwa';

  @override
  String get sortByTitle => 'Kichwa';

  @override
  String get formatBold => 'Herufi nzito';

  @override
  String get formatItalic => 'Mlalo';

  @override
  String get formatUnderline => 'Mstari chini';

  @override
  String get formatHeading => 'Kichwa cha habari';

  @override
  String get formatBulletList => 'Orodha ya vitone';

  @override
  String get formatChecklist => 'Orodha ya kukagua';

  @override
  String get formatQuote => 'Nukuu';

  @override
  String get formatCodeBlock => 'Kizuizi cha msimbo';

  @override
  String get penFountainPen => 'Kalamu ya wino';

  @override
  String get penGelPen => 'Kalamu ya jeli';

  @override
  String get penPencil => 'Penseli';

  @override
  String get penHighlighter => 'Kialamisho cha kung’arisha';

  @override
  String get penEraser => 'Kifutio';

  @override
  String get penStrokeWidth => 'Unene wa mstari';

  @override
  String get toggleHandwritingMode => 'Badilisha kati ya kuandika na kuchora';

  @override
  String get biometricLockReason => 'Fungua ili uone dokezo';

  @override
  String get noteLockedMessage => 'Dokezo hili limefungwa';

  @override
  String get unlockButton => 'Fungua';

  @override
  String get noteLockTurnedOffMessage =>
      'Kufunga madokezo kumezimwa kwa sababu kifaa hiki hakina kufunga skrini wala bayometriki.';

  @override
  String get biometricEnableReason =>
      'Thibitisha utambulisho wako ili uwashe kufunga madokezo';

  @override
  String get biometricDisableReason =>
      'Thibitisha utambulisho wako ili uzime kufunga madokezo';

  @override
  String get biometricShareReason =>
      'Fungua ili ushiriki au usafirishe dokezo hili';

  @override
  String get biometricAuthFailedMessage =>
      'Utambulisho wako haukuweza kuthibitishwa.';

  @override
  String get biometricSetupNeededMessage =>
      'Weka kufunga skrini au alama ya kidole kwenye mipangilio ya kifaa kwanza.';

  @override
  String get privacyChoicesTitle => 'Chaguo za faragha';

  @override
  String get purchaseFailedMessage =>
      'Ununuzi haukuweza kukamilika. Tafadhali jaribu tena.';

  @override
  String get restoreSuccessMessage => 'Ununuzi wako umerejeshwa.';

  @override
  String get restoreNothingFoundMessage =>
      'Hakuna ununuzi wa awali uliopatikana kwa akaunti hii.';

  @override
  String get restoreFailedMessage =>
      'Ununuzi haukuweza kurejeshwa. Angalia muunganisho wako kisha ujaribu tena.';

  @override
  String get reminderScheduleFailedMessage =>
      'Kikumbusho hakikuweza kupangwa. Tafadhali jaribu tena.';

  @override
  String get storageIssueNotebooksLoad =>
      'Baadhi ya madaftari hayakuweza kupakiwa. Inaonyesha yaliyopo.';

  @override
  String get storageIssueNotebookSave =>
      'Daftari hili huenda halikuhifadhiwa. Tafadhali jaribu tena.';

  @override
  String get storageIssueNotebookChange =>
      'Badiliko hili huenda halikuhifadhiwa. Tafadhali jaribu tena.';

  @override
  String get storageIssueNotebookDelete =>
      'Daftari halikuweza kufutwa. Tafadhali jaribu tena.';

  @override
  String get storageIssueNotebookOrder =>
      'Mpangilio mpya huenda haukuhifadhiwa. Tafadhali jaribu tena.';

  @override
  String get storageIssueNotesLoad =>
      'Baadhi ya madokezo hayakuweza kupakiwa. Inaonyesha yaliyopo.';

  @override
  String get storageIssueSearch =>
      'Matokeo ya utafutaji yanaweza kuwa pungufu kwa sasa.';

  @override
  String get storageIssueNoteSave =>
      'Dokezo hili huenda halikuhifadhiwa. Angalia hifadhi ya kifaa chako.';

  @override
  String get storageIssueNoteDelete =>
      'Dokezo halikuweza kufutwa. Tafadhali jaribu tena.';

  @override
  String get purchaseUnavailableMessage =>
      'Ununuzi huu haupatikani kwa sasa. Tafadhali jaribu tena baadaye.';

  @override
  String get exportTitle => 'Safirisha';

  @override
  String get exportAsTxt => 'Safirisha kama maandishi';

  @override
  String get exportAsPdf => 'Safirisha kama PDF';

  @override
  String get paperStyleSectionTitle => 'Mtindo wa karatasi';

  @override
  String get paperStyleLined => 'Yenye mistari';

  @override
  String get paperStyleDotGrid => 'Yenye nukta';

  @override
  String get paperStyleGrid => 'Yenye miraba';

  @override
  String get paperStyleBlank => 'Tupu';

  @override
  String get paperStyleCream => 'Krimu';

  @override
  String get paperStyleParchment => 'Ngozi ya karatasi';

  @override
  String get paperStyleVellum => 'Velamu';

  @override
  String get fontSectionTitle => 'Fonti ya madokezo';

  @override
  String get fontSystem => 'Mfumo';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Mwonekano';

  @override
  String get themeLight => 'Mwanga';

  @override
  String get themeDark => 'Giza';

  @override
  String get themeParchment => 'Ngozi ya karatasi';

  @override
  String get themeSystem => 'Mfumo';

  @override
  String get verseSectionTitle => 'Onyesho la aya ya siku';

  @override
  String get verseModeWatermark => 'Alama ya maji';

  @override
  String get verseModeHeader => 'Kichwa';

  @override
  String get verseModeFooter => 'Kijachini';

  @override
  String get verseModeOff => 'Imezimwa';

  @override
  String get notificationsSectionTitle => 'Arifa';

  @override
  String get dailyReminderToggle => 'Kikumbusho cha kila siku cha aya';

  @override
  String get reminderTimeLabel => 'Muda wa kikumbusho';

  @override
  String get notificationPermissionDenied =>
      'Arifa zimezimwa kwenye mipangilio ya mfumo.';

  @override
  String get dailyReminderBody => 'Aya yako ya siku iko tayari.';

  @override
  String get privacySectionTitle => 'Faragha';

  @override
  String get biometricLockToggle =>
      'Funga madokezo kwa Face ID / alama ya kidole';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Ondoa matangazo';

  @override
  String get restorePurchasesButton => 'Rejesha ununuzi';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Zaidi';

  @override
  String get rateAppTitle => 'Kadiria Atrament';

  @override
  String get rateAppSubtitle => 'Unaipenda programu? Acha maoni';

  @override
  String get shareAppTitle => 'Shiriki Atrament';

  @override
  String get shareAppSubtitle => 'Mwambie rafiki';

  @override
  String get shareAppMessage =>
      'Jaribu Atrament, daftari lisilo na usumbufu lenye mwonekano wa karatasi.';

  @override
  String get languageSectionTitle => 'Lugha';

  @override
  String get languageFollowsSystem =>
      'Hufuata mipangilio ya lugha ya kifaa chako';

  @override
  String get languageSystem => 'Chaguomsingi la mfumo';

  @override
  String get languagePickerTitle => 'Chagua lugha';

  @override
  String get premiumScreenTitle => 'Ondoa matangazo';

  @override
  String get premiumHeadline => 'Andika bila usumbufu';

  @override
  String get premiumBody =>
      'Atrament ni bure na huonyesha tangazo moja dogo. Kuondoa matangazo ni ununuzi wa mara moja usiofungua kitu kingine: vipengele vyote tayari ni vyako.';

  @override
  String get premiumRestoreButton => 'Rejesha ununuzi';

  @override
  String get premiumAlreadyProMessage => 'Tayari una Ondoa matangazo. Asante!';

  @override
  String get supportSectionTitle => 'Msaada';

  @override
  String get shareDebugLogButton => 'Shiriki kumbukumbu za utatuzi';

  @override
  String get shareDebugLogSubtitle =>
      'Tuma ripoti ya kiufundi ikiwa kuna kitu hakifanyi kazi';

  @override
  String get noDebugLogMessage => 'Bado hakuna cha kuripoti.';

  @override
  String get clearDebugLogButton => 'Futa kumbukumbu za utatuzi';

  @override
  String get clearDebugLogTitle => 'Futa kumbukumbu za utatuzi?';

  @override
  String get clearDebugLogBody =>
      'Ripoti ya kiufundi iliyohifadhiwa itaondolewa kwenye kifaa chako.';

  @override
  String get debugLogClearedMessage => 'Kumbukumbu za utatuzi zimefutwa.';

  @override
  String get premiumUnlockLabel => 'Ondoa matangazo milele';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Yote';

  @override
  String get chipNotebooks => 'Madaftari';

  @override
  String get chipRecent => 'Za hivi karibuni';

  @override
  String get emptyAllNotesTitle => 'Bado hakuna madokezo';

  @override
  String get emptyAllNotesBody => 'Gusa + ili uandike dokezo lako la kwanza.';

  @override
  String get emptyRecentNotesTitle => 'Hakuna cha hivi karibuni';

  @override
  String get emptyRecentNotesBody => 'Madokezo unayohariri yataonekana hapa.';

  @override
  String get noteActionRename => 'Badilisha jina';

  @override
  String get noteActionMoveToNotebook => 'Hamishia kwenye daftari';

  @override
  String get noteActionEdit => 'Hariri';

  @override
  String get noteActionExport => 'Safirisha';

  @override
  String get noteActionShare => 'Shiriki';

  @override
  String get moveToNotebookTitle => 'Hamishia kwenye daftari';

  @override
  String get moveToNotebookEmptyBody =>
      'Bado hakuna madaftari mengine. Tengeneza moja ili upange dokezo hili.';

  @override
  String get moveToNotebookCreateRow => 'Tengeneza daftari jipya';

  @override
  String get notebookActionRename => 'Badilisha jina';

  @override
  String get notebookActionChangeCover => 'Badilisha jalada';

  @override
  String get notebookRenameDialogTitle => 'Badilisha jina la daftari';

  @override
  String get notebookCoverPickerTitle => 'Chagua rangi ya jalada';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Daftari litafutwa pamoja na madokezo yake yote (jumla: $count). Kitendo hiki hakiwezi kutenduliwa.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Sheria na msaada';

  @override
  String get privacyPolicyRow => 'Sera ya Faragha';

  @override
  String get termsOfServiceRow => 'Masharti ya Huduma';

  @override
  String get supportRow => 'Msaada';

  @override
  String get openLinkFailedMessage =>
      'Kiungo hakikuweza kufunguliwa. Tafadhali jaribu tena.';

  @override
  String get openSourceLicensesRow => 'Leseni za chanzo huria';
}
