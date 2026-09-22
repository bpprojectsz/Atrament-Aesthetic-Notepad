import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Atrament'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// No description provided for @untitledNote.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitledNote;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get deleteConfirmBody;

  /// No description provided for @deleteNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this note?'**
  String get deleteNoteTitle;

  /// No description provided for @deleteNotebookTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String deleteNotebookTitle(String name);

  /// No description provided for @saveFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save. Please try again.'**
  String get saveFailedMessage;

  /// No description provided for @exportFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t export this note. Please try again.'**
  String get exportFailedMessage;

  /// No description provided for @shareFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the share sheet. Please try again.'**
  String get shareFailedMessage;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search notes'**
  String get searchHint;

  /// No description provided for @emptyNotebooksTitle.
  ///
  /// In en, this message translates to:
  /// **'No notebooks yet'**
  String get emptyNotebooksTitle;

  /// No description provided for @emptyNotebooksBody.
  ///
  /// In en, this message translates to:
  /// **'Create your first notebook to start writing.'**
  String get emptyNotebooksBody;

  /// No description provided for @emptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get emptySearchTitle;

  /// No description provided for @emptySearchBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term.'**
  String get emptySearchBody;

  /// No description provided for @emptyNotebookTitle.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get emptyNotebookTitle;

  /// No description provided for @emptyNotebookBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to write your first note.'**
  String get emptyNotebookBody;

  /// No description provided for @newNotebookTitle.
  ///
  /// In en, this message translates to:
  /// **'New Notebook'**
  String get newNotebookTitle;

  /// No description provided for @notebookNameHint.
  ///
  /// In en, this message translates to:
  /// **'Notebook name'**
  String get notebookNameHint;

  /// No description provided for @newNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'New Note'**
  String get newNoteTitle;

  /// No description provided for @sortOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortOptionsTitle;

  /// No description provided for @sortByModified.
  ///
  /// In en, this message translates to:
  /// **'Last edited'**
  String get sortByModified;

  /// No description provided for @sortByCreated.
  ///
  /// In en, this message translates to:
  /// **'Date created'**
  String get sortByCreated;

  /// No description provided for @sortByTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get sortByTitle;

  /// No description provided for @formatBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get formatBold;

  /// No description provided for @formatItalic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get formatItalic;

  /// No description provided for @formatUnderline.
  ///
  /// In en, this message translates to:
  /// **'Underline'**
  String get formatUnderline;

  /// No description provided for @formatHeading.
  ///
  /// In en, this message translates to:
  /// **'Heading'**
  String get formatHeading;

  /// No description provided for @formatBulletList.
  ///
  /// In en, this message translates to:
  /// **'Bullet list'**
  String get formatBulletList;

  /// No description provided for @formatChecklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get formatChecklist;

  /// No description provided for @formatQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get formatQuote;

  /// No description provided for @formatCodeBlock.
  ///
  /// In en, this message translates to:
  /// **'Code block'**
  String get formatCodeBlock;

  /// No description provided for @penFountainPen.
  ///
  /// In en, this message translates to:
  /// **'Fountain Pen'**
  String get penFountainPen;

  /// No description provided for @penGelPen.
  ///
  /// In en, this message translates to:
  /// **'Gel Pen'**
  String get penGelPen;

  /// No description provided for @penPencil.
  ///
  /// In en, this message translates to:
  /// **'Pencil'**
  String get penPencil;

  /// No description provided for @penHighlighter.
  ///
  /// In en, this message translates to:
  /// **'Highlighter'**
  String get penHighlighter;

  /// No description provided for @penEraser.
  ///
  /// In en, this message translates to:
  /// **'Eraser'**
  String get penEraser;

  /// No description provided for @penStrokeWidth.
  ///
  /// In en, this message translates to:
  /// **'Stroke width'**
  String get penStrokeWidth;

  /// No description provided for @toggleHandwritingMode.
  ///
  /// In en, this message translates to:
  /// **'Switch between typing and drawing'**
  String get toggleHandwritingMode;

  /// No description provided for @biometricLockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock to view this note'**
  String get biometricLockReason;

  /// No description provided for @noteLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This note is locked'**
  String get noteLockedMessage;

  /// No description provided for @unlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockButton;

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportTitle;

  /// No description provided for @exportAsTxt.
  ///
  /// In en, this message translates to:
  /// **'Export as Text'**
  String get exportAsTxt;

  /// No description provided for @exportAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get exportAsPdf;

  /// No description provided for @paperStyleSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Paper Style'**
  String get paperStyleSectionTitle;

  /// No description provided for @paperStyleLined.
  ///
  /// In en, this message translates to:
  /// **'Lined'**
  String get paperStyleLined;

  /// No description provided for @paperStyleDotGrid.
  ///
  /// In en, this message translates to:
  /// **'Dot Grid'**
  String get paperStyleDotGrid;

  /// No description provided for @paperStyleGrid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get paperStyleGrid;

  /// No description provided for @paperStyleBlank.
  ///
  /// In en, this message translates to:
  /// **'Blank'**
  String get paperStyleBlank;

  /// No description provided for @paperStyleCream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get paperStyleCream;

  /// No description provided for @paperStyleParchment.
  ///
  /// In en, this message translates to:
  /// **'Parchment'**
  String get paperStyleParchment;

  /// No description provided for @paperStyleVellum.
  ///
  /// In en, this message translates to:
  /// **'Vellum'**
  String get paperStyleVellum;

  /// No description provided for @fontSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Note Font'**
  String get fontSectionTitle;

  /// No description provided for @fontSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get fontSystem;

  /// No description provided for @fontSerif.
  ///
  /// In en, this message translates to:
  /// **'Serif'**
  String get fontSerif;

  /// No description provided for @themeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeSectionTitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeParchment.
  ///
  /// In en, this message translates to:
  /// **'Parchment'**
  String get themeParchment;

  /// No description provided for @verseSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Verse Display'**
  String get verseSectionTitle;

  /// No description provided for @verseModeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Watermark'**
  String get verseModeWatermark;

  /// No description provided for @verseModeHeader.
  ///
  /// In en, this message translates to:
  /// **'Header'**
  String get verseModeHeader;

  /// No description provided for @verseModeFooter.
  ///
  /// In en, this message translates to:
  /// **'Footer'**
  String get verseModeFooter;

  /// No description provided for @verseModeOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get verseModeOff;

  /// No description provided for @notificationsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSectionTitle;

  /// No description provided for @dailyReminderToggle.
  ///
  /// In en, this message translates to:
  /// **'Daily verse reminder'**
  String get dailyReminderToggle;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTimeLabel;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off in system settings.'**
  String get notificationPermissionDenied;

  /// No description provided for @dailyReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Your daily verse is ready.'**
  String get dailyReminderBody;

  /// No description provided for @privacySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacySectionTitle;

  /// No description provided for @biometricLockToggle.
  ///
  /// In en, this message translates to:
  /// **'Lock notes with Face ID / fingerprint'**
  String get biometricLockToggle;

  /// No description provided for @premiumSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumSectionTitle;

  /// No description provided for @removeAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAdsTitle;

  /// No description provided for @restorePurchasesButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchasesButton;

  /// No description provided for @proLabel.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get proLabel;

  /// No description provided for @languageSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSectionTitle;

  /// No description provided for @languageFollowsSystem.
  ///
  /// In en, this message translates to:
  /// **'Follows your device language setting'**
  String get languageFollowsSystem;

  /// No description provided for @premiumScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get premiumScreenTitle;

  /// No description provided for @premiumHeadline.
  ///
  /// In en, this message translates to:
  /// **'Write without distraction'**
  String get premiumHeadline;

  /// No description provided for @premiumBody.
  ///
  /// In en, this message translates to:
  /// **'Atrament is free with one small banner ad. Removing it is a one-time purchase that doesn\'t unlock anything else — every feature is already yours.'**
  String get premiumBody;

  /// No description provided for @premiumRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get premiumRestoreButton;

  /// No description provided for @premiumAlreadyProMessage.
  ///
  /// In en, this message translates to:
  /// **'You already have Remove Ads. Thank you!'**
  String get premiumAlreadyProMessage;

  /// No description provided for @supportSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportSectionTitle;

  /// No description provided for @shareDebugLogButton.
  ///
  /// In en, this message translates to:
  /// **'Share Debug Log'**
  String get shareDebugLogButton;

  /// No description provided for @shareDebugLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send a technical report if something isn\'t working'**
  String get shareDebugLogSubtitle;

  /// No description provided for @noDebugLogMessage.
  ///
  /// In en, this message translates to:
  /// **'No issues to report yet.'**
  String get noDebugLogMessage;

  /// No description provided for @clearDebugLogButton.
  ///
  /// In en, this message translates to:
  /// **'Clear Debug Log'**
  String get clearDebugLogButton;

  /// No description provided for @clearDebugLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear the debug log?'**
  String get clearDebugLogTitle;

  /// No description provided for @clearDebugLogBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the saved technical report from your device.'**
  String get clearDebugLogBody;

  /// No description provided for @debugLogClearedMessage.
  ///
  /// In en, this message translates to:
  /// **'Debug log cleared.'**
  String get debugLogClearedMessage;

  /// No description provided for @premiumUnlockLabel.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads Forever'**
  String get premiumUnlockLabel;

  /// No description provided for @premiumUnlockPriceFallback.
  ///
  /// In en, this message translates to:
  /// **'\$14.99'**
  String get premiumUnlockPriceFallback;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'he',
        'hi',
        'ja',
        'ko',
        'pt',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
