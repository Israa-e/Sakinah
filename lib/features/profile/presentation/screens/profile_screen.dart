import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/config/locale_provider.dart';
import '../../../../app/config/theme_mode_provider.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/storage/preferences_service.dart';
import '../../../../core/widgets/sakinah_bottom_sheet.dart';
import '../../../duas/presentation/duas_routes.dart';
import '../../../onboarding/domain/onboarding_status_provider.dart';
import '../../../onboarding/presentation/widgets/prayer_preference_widgets.dart';
import '../../../prayer/domain/prayer_notifications_provider.dart';
import '../../../prayer/domain/prayer_settings_provider.dart';
import '../../domain/display_name_provider.dart';
import '../controllers/profile_actions.dart';
import '../profile_routes.dart';
import '../widgets/settings_widgets.dart';

/// App version shown in About (kept in sync with `pubspec.yaml`).
const appVersion = '1.0.0';

/// Profile tab root: identity header plus every user-facing setting.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(prayerSettingsControllerProvider);
    final notificationsOn = ref.watch(prayerNotificationsEnabledProvider);
    final themeMode = ref.watch(appThemeModeControllerProvider);
    final locale = ref.watch(appLocaleProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          key: const ValueKey('profile-list'),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            Text(
              l10n.navProfile,
              style: context.textStyles.headlineLarge?.copyWith(color: context.colors.primary),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _ProfileHeaderCard(),
            const SizedBox(height: AppSpacing.xl),
            SettingsSection(
              title: l10n.profileSectionPrayer,
              children: [
                SettingsRow(
                  key: const ValueKey('profile-calc-method'),
                  icon: Icons.calculate_outlined,
                  title: l10n.calculationMethodLabel,
                  value: calculationMethodName(l10n, settings.calculationMethod),
                  onTap: () => _pickCalculationMethod(context, ref),
                ),
                SettingsRow(
                  key: const ValueKey('profile-madhab'),
                  icon: Icons.wb_twilight,
                  title: l10n.onboardingMadhabSection,
                  value: madhabName(l10n, settings.madhab),
                  onTap: () => _pickMadhab(context, ref),
                ),
                SettingsRow(
                  icon: Icons.notifications_active_outlined,
                  title: l10n.profileNotifications,
                  subtitle: l10n.profileNotificationsBody,
                  trailing: Switch(
                    key: const ValueKey('profile-notifications'),
                    value: notificationsOn,
                    onChanged: (v) => _toggleNotifications(context, ref, v),
                  ),
                ),
                _RefreshLocationRow(),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionAppearance,
              children: [
                SettingsChoiceRow<AppThemeMode>(
                  key: const ValueKey('profile-theme'),
                  icon: Icons.contrast,
                  title: l10n.profileTheme,
                  value: themeMode,
                  options: [
                    (AppThemeMode.system, l10n.profileThemeSystem),
                    (AppThemeMode.light, l10n.profileThemeLight),
                    (AppThemeMode.dark, l10n.profileThemeDark),
                  ],
                  onChanged: (m) =>
                      ref.read(appThemeModeControllerProvider.notifier).setThemeMode(m),
                ),
                SettingsChoiceRow<String>(
                  key: const ValueKey('profile-language'),
                  icon: Icons.translate,
                  title: l10n.profileLanguage,
                  value: locale.languageCode,
                  options: [('en', l10n.languageEnglish), ('ar', l10n.languageArabic)],
                  onChanged: (code) => ref.read(appLocaleProvider.notifier).setLocale(Locale(code)),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionQuran,
              children: [
                SettingsRow(
                  icon: Icons.menu_book_outlined,
                  title: l10n.profileTranslation,
                  value: l10n.profileTranslationValue,
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionContent,
              children: [
                SettingsRow(
                  key: const ValueKey('profile-sources'),
                  icon: Icons.verified_outlined,
                  title: l10n.profileSources,
                  onTap: () => _showSources(context),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionExplore,
              children: [
                SettingsRow(
                  icon: Icons.volunteer_activism_outlined,
                  title: l10n.profileDuasLibrary,
                  onTap: () => context.push(DuasPaths.library),
                ),
                SettingsRow(
                  icon: Icons.psychology_alt_outlined,
                  title: l10n.profileAskSakinah,
                  onTap: () => context.push(DuasPaths.ask),
                ),
                SettingsRow(
                  key: const ValueKey('profile-reflections'),
                  icon: Icons.edit_note,
                  title: l10n.profileReflections,
                  onTap: () => context.push(ProfilePaths.reflections),
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionAbout,
              children: [
                SettingsRow(
                  icon: Icons.spa_outlined,
                  title: l10n.profileAbout,
                  subtitle: l10n.profileVersion(appVersion),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: l10n.appName,
                    applicationVersion: appVersion,
                    applicationLegalese: l10n.appTagline,
                  ),
                ),
                SettingsRow(
                  key: const ValueKey('profile-reset-onboarding'),
                  icon: Icons.restart_alt,
                  title: l10n.profileResetOnboarding,
                  subtitle: l10n.profileResetOnboardingBody,
                  destructive: true,
                  onTap: () => _confirmResetOnboarding(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCalculationMethod(BuildContext context, WidgetRef ref) {
    return showSakinahBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.75),
        child: Consumer(
          builder: (context, ref, _) {
            final current = ref.watch(prayerSettingsControllerProvider).calculationMethod;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.l10n.calculationMethodLabel, style: context.textStyles.titleLarge),
                const SizedBox(height: AppSpacing.md),
                Flexible(
                  child: SingleChildScrollView(
                    child: CalculationMethodList(
                      value: current,
                      onChanged: (m) async {
                        await ref
                            .read(prayerSettingsControllerProvider.notifier)
                            .setCalculationMethod(m);
                        if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickMadhab(BuildContext context, WidgetRef ref) {
    return showSakinahBottomSheet<void>(
      context: context,
      builder: (sheetContext) => Consumer(
        builder: (context, ref, _) {
          final current = ref.watch(prayerSettingsControllerProvider).madhab;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(context.l10n.onboardingMadhabSection, style: context.textStyles.titleLarge),
              const SizedBox(height: AppSpacing.md),
              MadhabSelector(
                value: current,
                onChanged: (m) async {
                  await ref.read(prayerSettingsControllerProvider.notifier).setMadhab(m);
                  if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _toggleNotifications(BuildContext context, WidgetRef ref, bool value) async {
    final actions = ref.read(profileActionsProvider.notifier);
    final outcome = await actions.setPrayerNotifications(value);
    if (!context.mounted || outcome != NotificationToggleOutcome.permissionDenied) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.profileNotificationsDenied),
        action: SnackBarAction(
          label: context.l10n.openSettings,
          onPressed: actions.openSystemSettings,
        ),
      ),
    );
  }

  void _showSources(BuildContext context) {
    showSakinahBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.profileSources, style: context.textStyles.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            context.l10n.profileSourcesBody,
            style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmResetOnboarding(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profileResetConfirmTitle),
        content: Text(l10n.profileResetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.profileCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.profileResetConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(onboardingStatusProvider.notifier).reset();
    if (context.mounted) context.go(AppRoutes.onboarding);
  }
}

class _RefreshLocationRow extends ConsumerStatefulWidget {
  @override
  ConsumerState<_RefreshLocationRow> createState() => _RefreshLocationRowState();
}

class _RefreshLocationRowState extends ConsumerState<_RefreshLocationRow> {
  bool _busy = false;

  Future<void> _refresh() async {
    setState(() => _busy = true);
    final actions = ref.read(profileActionsProvider.notifier);
    final outcome = await actions.refreshLocation();
    if (!mounted) return;
    setState(() => _busy = false);
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(switch (outcome) {
          LocationRefreshOutcome.updated => l10n.profileLocationUpdated,
          LocationRefreshOutcome.permissionDenied => l10n.profileLocationDenied,
          LocationRefreshOutcome.failed => l10n.profileLocationFailed,
        }),
        action: outcome == LocationRefreshOutcome.permissionDenied
            ? SnackBarAction(label: l10n.openSettings, onPressed: actions.openSystemSettings)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      key: const ValueKey('profile-refresh-location'),
      icon: Icons.my_location,
      title: context.l10n.profileRefreshLocation,
      subtitle: context.l10n.profileRefreshLocationBody,
      trailing: _busy
          ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
          : null,
      onTap: _busy ? null : _refresh,
    );
  }
}

/// Deep-green hero identity card: avatar initial, name (tap to edit).
class _ProfileHeaderCard extends ConsumerWidget {
  const _ProfileHeaderCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final name = ref.watch(displayNameProvider);
    final initial = (name == null || name.isEmpty) ? null : name.characters.first.toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: palette.hero,
        borderRadius: AppRadius.heroAll,
        boxShadow: palette.heroShadow,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          key: const ValueKey('profile-edit-name'),
          borderRadius: AppRadius.heroAll,
          onTap: () => _editName(context, ref, name),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: palette.onHero.withValues(alpha: 0.1),
                    border: Border.all(color: palette.heroAccent.withValues(alpha: 0.6)),
                  ),
                  child: initial == null
                      ? Icon(Icons.person_outline, color: palette.heroAccent, size: 28)
                      : Text(
                          initial,
                          style: context.textStyles.headlineMedium?.copyWith(
                            color: palette.heroAccent,
                          ),
                        ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? l10n.profileAddName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyles.titleLarge?.copyWith(color: palette.onHero),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.profileHeaderSubtitle,
                        style: context.textStyles.bodySmall?.copyWith(color: palette.onHeroMuted),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: l10n.profileEditName,
                  child: Icon(Icons.edit_outlined, color: palette.onHeroMuted, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editName(BuildContext context, WidgetRef ref, String? current) async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => _NameDialog(initial: current ?? ''),
    );
    if (result != null) await ref.read(displayNameProvider.notifier).setName(result);
  }
}

class _NameDialog extends StatefulWidget {
  const _NameDialog({required this.initial});

  final String initial;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final TextEditingController _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.profileNameDialogTitle),
      content: TextField(
        key: const ValueKey('profile-name-field'),
        controller: _controller,
        autofocus: true,
        maxLength: 40,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(hintText: l10n.onboardingNameHint, counterText: ''),
        onSubmitted: (v) => Navigator.of(context).pop(v),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.profileCancel)),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.profileSave),
        ),
      ],
    );
  }
}
