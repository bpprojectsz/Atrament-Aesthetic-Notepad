import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/paper_style_model.dart';
import '../core/providers/subscription_provider.dart';
import '../core/providers/theme_provider.dart';
import '../core/providers/verse_provider.dart';
import '../core/services/iap_service.dart';
import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';
import '../platform/biometric_service.dart';
import '../platform/notification_service.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/font_selector.dart';
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
  final BiometricService _biometricService = BiometricService();

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
      final supported = await _biometricService.isSupported();

      if (!mounted) return;
      setState(() {
        _defaultPaperStyleId =
            prefs.getString(AppConstants.prefPaperStyleDefault) ?? 'cream';
        _fontChoice =
            (prefs.getString(AppConstants.prefFontChoice) ?? 'system') ==
                'serif'
            ? NoteFontChoice.serif
            : NoteFontChoice.system;
        _notificationsEnabled =
            prefs.getBool(AppConstants.prefNotificationsEnabled) ?? false;
        _reminderTime = TimeOfDay(
          hour: prefs.getInt(AppConstants.prefReminderHour) ?? 8,
          minute: prefs.getInt(AppConstants.prefReminderMinute) ?? 0,
        );
        _biometricLockEnabled =
            prefs.getBool(AppConstants.prefBiometricLockEnabled) ?? false;
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
      choice == NoteFontChoice.serif ? 'serif' : 'system',
    );
  }

  Future<void> _setNotificationsEnabled(bool enabled) async {
    final l10n = AppLocalizations.of(context)!;

    if (enabled) {
      final granted = await NotificationService.instance.requestPermission();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.notificationPermissionDenied)),
          );
        }
        return;
      }
      await NotificationService.instance.scheduleDailyReminder(
        hour: _reminderTime.hour,
        minute: _reminderTime.minute,
        verseTitle: l10n.appName,
        verseBody: l10n.dailyReminderBody,
      );
    } else {
      await NotificationService.instance.cancelDailyReminder();
    }

    setState(() => _notificationsEnabled = enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefNotificationsEnabled, enabled);
  }

  Future<void> _pickReminderTime() async {
    final l10n = AppLocalizations.of(context)!;
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked == null) return;

    setState(() => _reminderTime = picked);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefReminderHour, picked.hour);
    await prefs.setInt(AppConstants.prefReminderMinute, picked.minute);

    if (_notificationsEnabled) {
      await NotificationService.instance.scheduleDailyReminder(
        hour: picked.hour,
        minute: picked.minute,
        verseTitle: l10n.appName,
        verseBody: l10n.dailyReminderBody,
      );
    }
  }

  Future<void> _setBiometricLockEnabled(bool enabled) async {
    setState(() => _biometricLockEnabled = enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefBiometricLockEnabled, enabled);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = context.read<ThemeProvider>();
    final verseProvider = context.read<VerseProvider>();
    final subscriptionProvider = context.read<SubscriptionProvider>();
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    if (_loadingPrefs) {
      return AppScaffold(
        title: l10n.settingsTitle,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return AppScaffold(
      title: l10n.settingsTitle,
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          _SectionHeader(l10n.themeSectionTitle),
          ListenableBuilder(
            listenable: themeProvider.mode,
            builder: (context, _) {
              return SegmentedButton<AppThemeMode>(
                segments: [
                  ButtonSegment(
                    value: AppThemeMode.light,
                    label: Text(l10n.themeLight),
                  ),
                  ButtonSegment(
                    value: AppThemeMode.dark,
                    label: Text(l10n.themeDark),
                  ),
                  ButtonSegment(
                    value: AppThemeMode.parchment,
                    label: Text(l10n.themeParchment),
                  ),
                ],
                selected: {themeProvider.mode.value},
                onSelectionChanged: (selection) =>
                    themeProvider.setMode(selection.first),
              );
            },
          ),
          SizedBox(height: AppSpacing.lg),

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
          SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.fontSectionTitle),
          FontSelector(
            value: _fontChoice,
            systemLabel: l10n.fontSystem,
            serifLabel: l10n.fontSerif,
            onChanged: _setFontChoice,
          ),
          SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.verseSectionTitle),
          ListenableBuilder(
            listenable: verseProvider.displayMode,
            builder: (context, _) {
              return Column(
                children: [
                  for (final displayMode in VerseDisplayMode.values)
                    RadioListTile<VerseDisplayMode>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_verseModeLabel(l10n, displayMode)),
                      value: displayMode,
                      groupValue: verseProvider.displayMode.value,
                      onChanged: (value) {
                        if (value != null) verseProvider.setDisplayMode(value);
                      },
                    ),
                ],
              );
            },
          ),
          SizedBox(height: AppSpacing.lg),

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
          SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.privacySectionTitle),
          if (_biometricSupported)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.biometricLockToggle),
              value: _biometricLockEnabled,
              onChanged: _setBiometricLockEnabled,
            ),
          SizedBox(height: AppSpacing.lg),

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
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
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
                    onPressed: subscriptionProvider.restore,
                    child: Text(l10n.restorePurchasesButton),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: AppSpacing.lg),

          _SectionHeader(l10n.languageSectionTitle),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(Localizations.localeOf(context).toLanguageTag()),
            subtitle: Text(l10n.languageFollowsSystem),
          ),
        ],
      ),
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
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
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
