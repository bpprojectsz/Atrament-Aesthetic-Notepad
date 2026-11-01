// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'ફરી પ્રયાસ કરો';

  @override
  String get errorGeneric => 'કંઈક ખોટું થયું';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get undo => 'પૂર્વવત્ કરો';

  @override
  String get redo => 'ફરી કરો';

  @override
  String get untitledNote => 'શીર્ષક વગરનું';

  @override
  String get deleteConfirmBody => 'આ ક્રિયા પૂર્વવત્ કરી શકાશે નહીં.';

  @override
  String get deleteNoteTitle => 'આ નોંધ કાઢી નાખવી છે?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” કાઢી નાખવું છે?';
  }

  @override
  String get saveFailedMessage =>
      'સાચવી શકાયું નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get exportFailedMessage =>
      'આ નોંધ નિકાસ કરી શકાઈ નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get shareFailedMessage =>
      'શેર મેનૂ ખોલી શકાયું નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get settingsTitle => 'સેટિંગ્સ';

  @override
  String get searchHint => 'નોંધોમાં શોધો';

  @override
  String get emptyNotebooksTitle => 'હજી કોઈ નોટબુક નથી';

  @override
  String get emptyNotebooksBody =>
      'લખવાનું શરૂ કરવા માટે તમારી પ્રથમ નોટબુક બનાવો.';

  @override
  String get emptySearchTitle => 'કોઈ પરિણામ નથી';

  @override
  String get emptySearchBody => 'બીજો શોધ શબ્દ અજમાવો.';

  @override
  String get emptyNotebookTitle => 'હજી કોઈ નોંધ નથી';

  @override
  String get emptyNotebookBody => 'તમારી પ્રથમ નોંધ લખવા માટે + પર ટૅપ કરો.';

  @override
  String get newNotebookTitle => 'નવી નોટબુક';

  @override
  String get notebookNameHint => 'નોટબુકનું નામ';

  @override
  String get newNoteTitle => 'નવી નોંધ';

  @override
  String get sortOptionsTitle => 'ક્રમમાં ગોઠવો';

  @override
  String get sortByModified => 'છેલ્લે સંપાદિત';

  @override
  String get sortByCreated => 'બનાવ્યાની તારીખ';

  @override
  String get sortByTitle => 'શીર્ષક';

  @override
  String get formatBold => 'ઘાટા';

  @override
  String get formatItalic => 'ત્રાંસા';

  @override
  String get formatUnderline => 'રેખાંકિત';

  @override
  String get formatHeading => 'મથાળું';

  @override
  String get formatBulletList => 'બુલેટ સૂચિ';

  @override
  String get formatChecklist => 'ચેકલિસ્ટ';

  @override
  String get formatQuote => 'અવતરણ';

  @override
  String get formatCodeBlock => 'કોડ બ્લૉક';

  @override
  String get penFountainPen => 'ફાઉન્ટન પેન';

  @override
  String get penGelPen => 'જેલ પેન';

  @override
  String get penPencil => 'પેન્સિલ';

  @override
  String get penHighlighter => 'હાઇલાઇટર';

  @override
  String get penEraser => 'રબર';

  @override
  String get penStrokeWidth => 'રેખાની જાડાઈ';

  @override
  String get toggleHandwritingMode => 'ટાઇપિંગ અને ચિત્રકામ વચ્ચે બદલો';

  @override
  String get biometricLockReason => 'નોંધ જોવા માટે અનલૉક કરો';

  @override
  String get noteLockedMessage => 'આ નોંધ લૉક કરેલી છે';

  @override
  String get unlockButton => 'અનલૉક કરો';

  @override
  String get noteLockTurnedOffMessage =>
      'આ ઉપકરણ પર સ્ક્રીન લૉક અથવા બાયોમેટ્રિક સેટ કરેલું ન હોવાથી નોંધ લૉક બંધ કર્યું છે.';

  @override
  String get biometricEnableReason =>
      'નોંધ લૉક ચાલુ કરવા માટે તમારી ઓળખની પુષ્ટિ કરો';

  @override
  String get biometricDisableReason =>
      'નોંધ લૉક બંધ કરવા માટે તમારી ઓળખની પુષ્ટિ કરો';

  @override
  String get biometricShareReason =>
      'આ નોંધ શેર અથવા નિકાસ કરવા માટે અનલૉક કરો';

  @override
  String get biometricAuthFailedMessage => 'તમારી ઓળખ ચકાસી શકાઈ નહીં.';

  @override
  String get biometricSetupNeededMessage =>
      'પહેલાં ઉપકરણ સેટિંગ્સમાં સ્ક્રીન લૉક અથવા ફિંગરપ્રિન્ટ સેટ કરો.';

  @override
  String get privacyChoicesTitle => 'ગોપનીયતા વિકલ્પો';

  @override
  String get purchaseFailedMessage =>
      'ખરીદી પૂર્ણ કરી શકાઈ નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get restoreSuccessMessage => 'તમારી ખરીદી પુનઃસ્થાપિત કરવામાં આવી છે.';

  @override
  String get restoreNothingFoundMessage =>
      'આ એકાઉન્ટ માટે અગાઉની કોઈ ખરીદી મળી નથી.';

  @override
  String get restoreFailedMessage =>
      'ખરીદીઓ પુનઃસ્થાપિત કરી શકાઈ નહીં. તમારું કનેક્શન તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get reminderScheduleFailedMessage =>
      'રિમાઇન્ડર શેડ્યૂલ કરી શકાયું નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get storageIssueNotebooksLoad =>
      'કેટલીક નોટબુક લોડ થઈ શકી નહીં. ઉપલબ્ધ હોય તે બતાવવામાં આવી રહ્યું છે.';

  @override
  String get storageIssueNotebookSave =>
      'આ નોટબુક કદાચ સાચવાઈ નથી. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get storageIssueNotebookChange =>
      'આ ફેરફાર કદાચ સાચવાયો નથી. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get storageIssueNotebookDelete =>
      'નોટબુક કાઢી નાખી શકાઈ નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get storageIssueNotebookOrder =>
      'નવો ક્રમ કદાચ સાચવાયો નથી. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get storageIssueNotesLoad =>
      'કેટલીક નોંધો લોડ થઈ શકી નહીં. ઉપલબ્ધ હોય તે બતાવવામાં આવી રહ્યું છે.';

  @override
  String get storageIssueSearch => 'હાલમાં શોધ પરિણામો અધૂરાં હોઈ શકે છે.';

  @override
  String get storageIssueNoteSave =>
      'આ નોંધ કદાચ સાચવાઈ નથી. તમારા ઉપકરણનો સ્ટોરેજ તપાસો.';

  @override
  String get storageIssueNoteDelete =>
      'નોંધ કાઢી નાખી શકાઈ નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get purchaseUnavailableMessage =>
      'આ ખરીદી હાલમાં ઉપલબ્ધ નથી. કૃપા કરીને પછીથી ફરી પ્રયાસ કરો.';

  @override
  String get exportTitle => 'નિકાસ કરો';

  @override
  String get exportAsTxt => 'ટેક્સ્ટ તરીકે નિકાસ કરો';

  @override
  String get exportAsPdf => 'PDF તરીકે નિકાસ કરો';

  @override
  String get paperStyleSectionTitle => 'કાગળની શૈલી';

  @override
  String get paperStyleLined => 'લીટીવાળું';

  @override
  String get paperStyleDotGrid => 'ટપકાંવાળું';

  @override
  String get paperStyleGrid => 'ચોકડીવાળું';

  @override
  String get paperStyleBlank => 'કોરું';

  @override
  String get paperStyleCream => 'ક્રીમ';

  @override
  String get paperStyleParchment => 'પાર્ચમેન્ટ';

  @override
  String get paperStyleVellum => 'વેલમ';

  @override
  String get fontSectionTitle => 'નોંધનો ફૉન્ટ';

  @override
  String get fontSystem => 'સિસ્ટમ';

  @override
  String get fontSerif => 'સેરિફ';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'દેખાવ';

  @override
  String get themeLight => 'આછો';

  @override
  String get themeDark => 'ઘેરો';

  @override
  String get themeParchment => 'પાર્ચમેન્ટ';

  @override
  String get themeSystem => 'સિસ્ટમ';

  @override
  String get verseSectionTitle => 'આજના વચનનું પ્રદર્શન';

  @override
  String get verseModeWatermark => 'વૉટરમાર્ક';

  @override
  String get verseModeHeader => 'હેડર';

  @override
  String get verseModeFooter => 'ફૂટર';

  @override
  String get verseModeOff => 'બંધ';

  @override
  String get notificationsSectionTitle => 'સૂચનાઓ';

  @override
  String get dailyReminderToggle => 'દૈનિક વચન રિમાઇન્ડર';

  @override
  String get reminderTimeLabel => 'રિમાઇન્ડરનો સમય';

  @override
  String get notificationPermissionDenied =>
      'સિસ્ટમ સેટિંગ્સમાં સૂચનાઓ બંધ છે.';

  @override
  String get dailyReminderBody => 'તમારું આજનું વચન તૈયાર છે.';

  @override
  String get privacySectionTitle => 'ગોપનીયતા';

  @override
  String get biometricLockToggle => 'Face ID / ફિંગરપ્રિન્ટથી નોંધો લૉક કરો';

  @override
  String get premiumSectionTitle => 'પ્રીમિયમ';

  @override
  String get removeAdsTitle => 'જાહેરાતો દૂર કરો';

  @override
  String get restorePurchasesButton => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get proLabel => 'પ્રો';

  @override
  String get engagementSectionTitle => 'વધુ';

  @override
  String get rateAppTitle => 'Atrament ને રેટિંગ આપો';

  @override
  String get rateAppSubtitle => 'ઍપ ગમી? એક સમીક્ષા લખો';

  @override
  String get shareAppTitle => 'Atrament શેર કરો';

  @override
  String get shareAppSubtitle => 'મિત્રને કહો';

  @override
  String get shareAppMessage =>
      'Atrament અજમાવો — કાગળની રચના સાથેનું વિક્ષેપ-રહિત નોટપેડ.';

  @override
  String get languageSectionTitle => 'ભાષા';

  @override
  String get languageFollowsSystem => 'ઉપકરણની ભાષા સેટિંગને અનુસરે છે';

  @override
  String get languageSystem => 'સિસ્ટમ ડિફૉલ્ટ';

  @override
  String get languagePickerTitle => 'ભાષા પસંદ કરો';

  @override
  String get premiumScreenTitle => 'જાહેરાતો દૂર કરો';

  @override
  String get premiumHeadline => 'વિક્ષેપ વિના લખો';

  @override
  String get premiumBody =>
      'Atrament મફત છે અને માત્ર એક નાનું જાહેરાત બેનર બતાવે છે. જાહેરાતો દૂર કરવી એ એક વારની ખરીદી છે જે બીજું કંઈ અનલૉક કરતી નથી — બધી સુવિધાઓ પહેલેથી જ તમારી છે.';

  @override
  String get premiumRestoreButton => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get premiumAlreadyProMessage =>
      'તમારી પાસે પહેલેથી જ “જાહેરાતો દૂર કરો” છે. આભાર!';

  @override
  String get supportSectionTitle => 'સહાય';

  @override
  String get shareDebugLogButton => 'ડિબગ લૉગ શેર કરો';

  @override
  String get shareDebugLogSubtitle => 'કંઈ કામ ન કરે તો તકનીકી અહેવાલ મોકલો';

  @override
  String get noDebugLogMessage => 'હજી જાણ કરવા જેવું કંઈ નથી.';

  @override
  String get clearDebugLogButton => 'ડિબગ લૉગ સાફ કરો';

  @override
  String get clearDebugLogTitle => 'ડિબગ લૉગ સાફ કરવો છે?';

  @override
  String get clearDebugLogBody =>
      'સાચવેલો તકનીકી અહેવાલ તમારા ઉપકરણમાંથી દૂર કરવામાં આવશે.';

  @override
  String get debugLogClearedMessage => 'ડિબગ લૉગ સાફ કર્યો.';

  @override
  String get premiumUnlockLabel => 'જાહેરાતો કાયમ માટે દૂર કરો';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'બધા';

  @override
  String get chipNotebooks => 'નોટબુક';

  @override
  String get chipRecent => 'તાજેતરના';

  @override
  String get emptyAllNotesTitle => 'હજી કોઈ નોંધ નથી';

  @override
  String get emptyAllNotesBody => 'તમારી પ્રથમ નોંધ લખવા માટે + પર ટૅપ કરો.';

  @override
  String get emptyRecentNotesTitle => 'તાજેતરનું કંઈ નથી';

  @override
  String get emptyRecentNotesBody => 'તમે સંપાદિત કરેલી નોંધો અહીં દેખાશે.';

  @override
  String get noteActionRename => 'નામ બદલો';

  @override
  String get noteActionMoveToNotebook => 'નોટબુકમાં ખસેડો';

  @override
  String get noteActionEdit => 'સંપાદિત કરો';

  @override
  String get noteActionExport => 'નિકાસ કરો';

  @override
  String get noteActionShare => 'શેર કરો';

  @override
  String get moveToNotebookTitle => 'નોટબુકમાં ખસેડો';

  @override
  String get moveToNotebookEmptyBody =>
      'હજી બીજી કોઈ નોટબુક નથી. આ નોંધ ગોઠવવા માટે એક બનાવો.';

  @override
  String get moveToNotebookCreateRow => 'નવી નોટબુક બનાવો';

  @override
  String get notebookActionRename => 'નામ બદલો';

  @override
  String get notebookActionChangeCover => 'કવર બદલો';

  @override
  String get notebookRenameDialogTitle => 'નોટબુકનું નામ બદલો';

  @override
  String get notebookCoverPickerTitle => 'કવરનો રંગ પસંદ કરો';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'નોટબુક તેની બધી નોંધો સાથે કાઢી નાખવામાં આવશે (કુલ: $count). આ ક્રિયા પૂર્વવત્ કરી શકાશે નહીં.';
  }

  @override
  String get legalAndSupportSectionTitle => 'કાનૂની અને સહાય';

  @override
  String get privacyPolicyRow => 'ગોપનીયતા નીતિ';

  @override
  String get termsOfServiceRow => 'સેવાની શરતો';

  @override
  String get supportRow => 'સહાય';

  @override
  String get openLinkFailedMessage =>
      'લિંક ખોલી શકાઈ નહીં. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get openSourceLicensesRow => 'ઓપન સોર્સ લાઇસન્સ';
}
