import 'dart:io' show Platform;

import 'package:atrament/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/models/paper_style_model.dart';
import '../core/providers/locale_provider.dart';
import '../core/providers/subscription_provider.dart';
import '../core/providers/theme_provider.dart';
import '../core/providers/verse_provider.dart';
import '../core/services/app_lock.dart';
import '../core/services/engagement_service.dart';
import '../core/services/iap_service.dart';
import '../core/services/reminder_scheduler.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';
import '../core/utils/locale_utils.dart';
import '../platform/admob_service.dart';
import '../platform/consent_service.dart';
import '../platform/debug_log_service.dart';
import '../platform/notification_service.dart';
import '../platform/share_service.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/font_selector.dart';
import '../widgets/language_picker.dart';
import '../widgets/paper_selector.dart';
import '../widgets/pro_badge.dart';
import 'premium_screen.dart';

/// Theme selection, paper default, font selection, verse display mode,
/// notification toggle, daily reminder time, biometric lock toggle,
/// premium upgrade, restore purchases, and language display.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ShareService _shareService = const ShareService();

  String _defaultPaperStyleId = 'cream';
  NoteFontChoice _fontChoice = NoteFontChoice.system;
  bool _notificationsEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);
  bool _biometricLockEnabled = false;
  bool _biometricSupported = false;
  bool _loadingPrefs = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final supported = await AppLock.instance.isSupported();
      await AppLock.instance.init();

      if (!mounted) return;
      setState(() {
        _defaultPaperStyleId =
            prefs.getString(AppConstants.prefPaperStyleDefault) ?? 'cream';
        _fontChoice = noteFontChoiceFromString(
          prefs.getString(AppConstants.prefFontChoice),
        );
        _notificationsEnabled =
            prefs.getBool(AppConstants.prefNotificationsEnabled) ?? false;
        _reminderTime = TimeOfDay(
          hour: prefs.getInt(AppConstants.prefReminderHour) ?? 8,
          minute: prefs.getInt(AppConstants.prefReminderMinute) ?? 0,
        );
        _biometricLockEnabled = AppLock.instance.enabled;
        _biometricSupported = supported;
        _loadingPrefs = false;
      });
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to load settings preferences',
        context: 'settings_screen.loadPrefs',
        severity: ErrorSeverity.warning,
      );
      if (mounted) setState(() => _loadingPrefs = false);
    }
  }

  Future<void> _setDefaultPaperStyle(String id) async {
    setState(() => _defaultPaperStyleId = id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefPaperStyleDefault, id);
  }

  Future<void> _setFontChoice(NoteFontChoice choice) async {
    setState(() => _fontChoice = choice);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.prefFontChoice,
      choice.name,
    );
  }

  Future<void> _setNotificationsEnabled(bool enabled) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    if (enabled) {
      final granted = await NotificationService.instance.requestPermission();
      if (!granted) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.notificationPermissionDenied)),
        );
        return;
      }
      final scheduled = await ReminderScheduler.instance.schedule(
        hour: _reminderTime.hour,
        minute: _reminderTime.minute,
        fallbackTitle: l10n.appName,
        fallbackBody: l10n.dailyReminderBody,
      );
      if (!scheduled) {
        // Don't show the toggle as ON when nothing is actually scheduled.
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.reminderScheduleFailedMessage)),
        );
        return;
      }
    } else {
      await ReminderScheduler.instance.cancel();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefNotificationsEnabled, enabled);
    if (!mounted) return;
    setState(() => _notificationsEnabled = enabled);
  }

  Future<void> _pickReminderTime() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefReminderHour, picked.hour);
    await prefs.setInt(AppConstants.prefReminderMinute, picked.minute);
    if (!mounted) return;
    setState(() => _reminderTime = picked);

    if (_notificationsEnabled) {
      final scheduled = await ReminderScheduler.instance.schedule(
        hour: picked.hour,
        minute: picked.minute,
        fallbackTitle: l10n.appName,
        fallbackBody: l10n.dailyReminderBody,
      );
      if (!scheduled) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.reminderScheduleFailedMessage)),
        );
      }
    }
  }

  Future<void> _rateApp() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final opened = await EngagementService.instance.openStoreListingForReview();
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.openLinkFailedMessage)));
    }
  }

  Future<void> _restorePurchases(SubscriptionProvider provider) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final outcome = await provider.restore();
    final message = switch (outcome) {
      RestoreOutcome.restored => l10n.restoreSuccessMessage,
      RestoreOutcome.nothingFound => l10n.restoreNothingFoundMessage,
      RestoreOutcome.failed => l10n.restoreFailedMessage,
    };
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openPrivacyChoices() async {
    await ConsentService.instance.showPrivacyOptions();
    await AdMobService.instance.onConsentChanged();
  }

  /// Turning the lock on or off requires authenticating, so a phone that
  /// is merely left unlocked can't have its note lock removed.
  Future<void> _setBiometricLockEnabled(bool enabled) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    final outcome = await AppLock.instance.changeEnabled(
      enabled,
      reason: enabled ? l10n.biometricEnableReason : l10n.biometricDisableReason,
    );
    if (!mounted) return;

    switch (outcome) {
      case LockChangeOutcome.changed:
        setState(() => _biometricLockEnabled = AppLock.instance.enabled);
      case LockChangeOutcome.notSupported:
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.biometricSetupNeededMessage)),
        );
      case LockChangeOutcome.denied:
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.biometricAuthFailedMessage)),
        );
    }
  }

  Future<void> _openUrl(String url) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.openLinkFailedMessage)),
      );
    }
  }

  Future<void> _shareDebugLog() async {
    final l10n = AppLocalizations.of(context)!;
    final path = await DebugLogService.instance.exportableLogPath();

    if (!mounted) return;

    if (path == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.noDebugLogMessage)));
      return;
    }

    final result = await _shareService.shareFile(
      path,
      subject: '${l10n.appName} debug log',
    );

    if (!mounted) return;
    if (result.failed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.shareFailedMessage)));
    }
  }

  Future<void> _clearDebugLog() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await ConfirmationDialog.show(
      context,
      title: l10n.clearDebugLogTitle,
      body: l10n.clearDebugLogBody,
      cancelLabel: l10n.cancel,
      confirmLabel: l10n.delete,
    );
    if (confirmed != true) return;

    await DebugLogService.instance.clearLog();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.debugLogClearedMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = context.read<LocaleProvider>();
    final themeProvider = context.read<ThemeProvider>();
    final verseProvider = context.read<VerseProvider>();
    final subscriptionProvider = context.read<SubscriptionProvider>();

    if (_loadingPrefs) {
      return AppScaffold(
        title: l10n.settingsTitle,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return AppScaffold(
      title: l10n.settingsTitle,
      bottomAdSlot: BannerAdWidget(subscriptionProvider: subscriptionProvider),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _SectionHeader(l10n.themeSectionTitle),
          ListenableBuilder(
            listenable: themeProvider.preference,
            builder: (context, _) {
              return SegmentedButton<ThemePreference>(
                segments: [
                  ButtonSegment(
                    value: ThemePreference.system,
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(l10n.themeSystem, maxLines: 1, softWrap: false),
                    ),
                  ),
                  ButtonSegment(
                    value: ThemePreference.light,
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(l10n.themeLight, maxLines: 1, softWrap: false),
                    ),
                  ),
                  ButtonSegment(
                    value: ThemePreference.dark,
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(l10n.themeDark, maxLines: 1, softWrap: false),
                    ),
                  ),
                  ButtonSegment(
                    value: ThemePreference.parchment,
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(l10n.themeParchment, maxLines: 1, softWrap: false),
                    ),
                  ),
                ],
                selected: {themeProvider.preference.value},
                onSelectionChanged: (selection) =>
                    themeProvider.setPreference(selection.first),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.paperStyleSectionTitle),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(_paperStyleLabel(l10n, _defaultPaperStyleId)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => PaperSelector.show(
              context,
              selectedId: _defaultPaperStyleId,
              sectionTitle: l10n.paperStyleSectionTitle,
              styleLabels: {
                for (final style in PaperStyleCatalog.all)
                  style.id: _paperStyleLabel(l10n, style.id),
              },
              onSelected: _setDefaultPaperStyle,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.fontSectionTitle),
          FontSelector(
            value: _fontChoice,
            systemLabel: l10n.fontSystem,
            serifLabel: l10n.fontSerif,
            interLabel: l10n.fontInter,
            loraLabel: l10n.fontLora,
            onChanged: _setFontChoice,
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.verseSectionTitle),
          ListenableBuilder(
            listenable: verseProvider.displayMode,
            builder: (context, _) {
              return RadioGroup<VerseDisplayMode>(
                groupValue: verseProvider.displayMode.value,
                onChanged: (value) {
                  if (value != null) verseProvider.setDisplayMode(value);
                },
                child: Column(
                  children: [
                    for (final displayMode in VerseDisplayMode.values)
                      RadioListTile<VerseDisplayMode>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_verseModeLabel(l10n, displayMode)),
                        value: displayMode,
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.notificationsSectionTitle),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.dailyReminderToggle),
            value: _notificationsEnabled,
            onChanged: _setNotificationsEnabled,
          ),
          if (_notificationsEnabled)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.reminderTimeLabel),
              trailing: Text(_reminderTime.format(context)),
              onTap: _pickReminderTime,
            ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.privacySectionTitle),
          // Stay visible while the lock is on, even if the device stopped
          // supporting it, so the user can always turn it off.
          if (_biometricSupported || _biometricLockEnabled)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.biometricLockToggle),
              value: _biometricLockEnabled,
              onChanged: _setBiometricLockEnabled,
            ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.premiumSectionTitle),
          ListenableBuilder(
            listenable: subscriptionProvider.status,
            builder: (context, _) {
              final isPro =
                  subscriptionProvider.status.value == SubscriptionStatus.pro;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPro)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: ProBadge(label: l10n.proLabel),
                    )
                  else
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.removeAdsTitle),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PremiumScreen(
                              subscriptionProvider: subscriptionProvider,
                            ),
                          ),
                        );
                      },
                    ),
                  TextButton(
                    onPressed: () => _restorePurchases(subscriptionProvider),
                    child: Text(l10n.restorePurchasesButton),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.engagementSectionTitle),
          ValueListenableBuilder<bool>(
            valueListenable: ConsentService.instance.privacyOptionsRequired,
            builder: (context, required, _) {
              if (!required) return const SizedBox.shrink();
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.privacy_tip_outlined),
                title: Text(l10n.privacyChoicesTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openPrivacyChoices,
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.star_outline),
            title: Text(l10n.rateAppTitle),
            subtitle: Text(l10n.rateAppSubtitle),
            onTap: _rateApp,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.favorite_outline),
            title: Text(l10n.shareAppTitle),
            subtitle: Text(l10n.shareAppSubtitle),
            onTap: _shareApp,
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.languageSectionTitle),
          ListenableBuilder(
            listenable: localeProvider.preference,
            builder: (context, _) {
              final current = localeProvider.preference.value;
              final title = current == null
                  ? l10n.languageSystem
                  : nativeNameFor(localeTag(current)) ??
                        localeTag(current);
              final subtitle = current == null
                  ? l10n.languageFollowsSystem
                  : null;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(title),
                subtitle: subtitle == null ? null : Text(subtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showLanguagePicker(context, localeProvider),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.legalAndSupportSectionTitle),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.open_in_new),
            title: Text(l10n.privacyPolicyRow),
            onTap: () => _openUrl(AppConstants.privacyPolicyUrl),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.open_in_new),
            title: Text(l10n.termsOfServiceRow),
            onTap: () => _openUrl(AppConstants.termsUrl),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.open_in_new),
            title: Text(l10n.supportRow),
            onTap: () => _openUrl(AppConstants.supportUrl),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.bug_report_outlined),
            title: Text(l10n.shareDebugLogButton),
            subtitle: Text(l10n.shareDebugLogSubtitle),
            onTap: _shareDebugLog,
          ),
          TextButton(
            onPressed: _clearDebugLog,
            child: Text(l10n.clearDebugLogButton),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.article_outlined),
            title: Text(l10n.openSourceLicensesRow),
            onTap: () => showLicensePage(
              context: context,
              applicationName: AppConstants.appName,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp() async {
    final l10n = AppLocalizations.of(context)!;
    final url = Platform.isIOS
        ? AppConstants.appStoreUrl
        : AppConstants.playStoreUrl;
    await _shareService.shareText(
      '${l10n.shareAppMessage}\n$url',
      subject: l10n.shareAppTitle,
    );
  }

  String _paperStyleLabel(AppLocalizations l10n, String id) {
    switch (id) {
      case 'lined':
        return l10n.paperStyleLined;
      case 'dot_grid':
        return l10n.paperStyleDotGrid;
      case 'grid':
        return l10n.paperStyleGrid;
      case 'blank':
        return l10n.paperStyleBlank;
      case 'cream':
        return l10n.paperStyleCream;
      case 'parchment':
        return l10n.paperStyleParchment;
      case 'vellum':
        return l10n.paperStyleVellum;
      default:
        return id;
    }
  }

  String _verseModeLabel(AppLocalizations l10n, VerseDisplayMode mode) {
    switch (mode) {
      case VerseDisplayMode.watermark:
        return l10n.verseModeWatermark;
      case VerseDisplayMode.header:
        return l10n.verseModeHeader;
      case VerseDisplayMode.footer:
        return l10n.verseModeFooter;
      case VerseDisplayMode.off:
        return l10n.verseModeOff;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final mode = context.appMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppTypography.title2.size,
          fontWeight: AppTypography.title2.weight,
          color: AppColors.textPrimary.resolve(mode),
        ),
      ),
    );
  }
}
