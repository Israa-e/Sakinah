import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/theme/sakinah_palette.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';
import '../../widgets/onboarding_widgets.dart';

/// Mockup 15. Only reminders the app actually schedules (prayer times) are
/// offered — no toggles for features that don't exist.
class NotificationsStep extends ConsumerStatefulWidget {
  const NotificationsStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
    this.onSkip,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback? onSkip;

  @override
  ConsumerState<NotificationsStep> createState() => _NotificationsStepState();
}

class _NotificationsStepState extends ConsumerState<NotificationsStep> {
  bool _busy = false;
  bool _denied = false;

  Future<void> _enable() async {
    setState(() => _busy = true);
    await ref.read(onboardingControllerProvider.notifier).requestNotificationPermission();
    if (!mounted) return;
    final granted = ref.read(onboardingControllerProvider).notificationsGranted ?? false;
    setState(() {
      _busy = false;
      _denied = !granted;
    });
    if (granted) widget.onNext();
  }

  Future<void> _later() async {
    await ref.read(onboardingControllerProvider.notifier).skipNotificationPermission();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final palette = context.palette;
    final accent = onboardingAccent(context);

    return OnboardingScaffold(
      stepIndex: widget.stepIndex,
      stepCount: widget.stepCount,
      onBack: widget.onBack,
      onSkip: widget.onSkip,
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, size: 15, color: colors.tertiaryFixedDim),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  l10n.onboardingNotifReassurance,
                  textAlign: TextAlign.center,
                  style: context.textStyles.labelSmall?.copyWith(
                    color: colors.onSecondaryContainer,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_denied)
            OnboardingPillButton(label: l10n.continueLabel, onPressed: widget.onNext)
          else ...[
            OnboardingPillButton(
              label: l10n.onboardingNotifEnable,
              leadingIcon: Icons.notifications_active_outlined,
              showArrow: false,
              isLoading: _busy,
              onPressed: _enable,
            ),
            const SizedBox(height: AppSpacing.xxs),
            TextButton(
              onPressed: _busy ? null : _later,
              style: TextButton.styleFrom(foregroundColor: colors.outline),
              child: Text(l10n.onboardingDecideLater),
            ),
          ],
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingHeading(
            icon: Icons.notifications_active,
            title: l10n.onboardingNotificationsHeadline,
            subtitle: l10n.onboardingNotificationsTitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: AppRadius.cardAll,
              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
              boxShadow: palette.whisperShadow,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.mosque, size: 20, color: accent),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.onboardingNotifPrayerTitle, style: context.textStyles.titleMedium),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        l10n.onboardingNotifPrayerBody,
                        style: context.textStyles.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_denied) ...[
            const SizedBox(height: AppSpacing.md),
            OnboardingNote(
              key: const ValueKey('notifications-denied'),
              icon: Icons.notifications_off_outlined,
              iconColor: colors.error,
              text: l10n.onboardingNotifDenied,
              action: Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () =>
                      ref.read(onboardingControllerProvider.notifier).openSystemSettings(),
                  child: Text(l10n.openSettings),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
