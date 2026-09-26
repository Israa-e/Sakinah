import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/theme/sakinah_palette.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';
import '../../widgets/onboarding_widgets.dart';

/// Mockup 13. Requests location permission; a denial keeps the user on the
/// step with an explanation and a path to system settings instead of
/// silently moving on.
class LocationStep extends ConsumerStatefulWidget {
  const LocationStep({
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
  ConsumerState<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends ConsumerState<LocationStep> {
  bool _busy = false;
  bool _denied = false;

  Future<void> _allow() async {
    setState(() => _busy = true);
    final controller = ref.read(onboardingControllerProvider.notifier);
    await controller.requestLocationPermission();
    if (!mounted) return;
    final granted = ref.read(onboardingControllerProvider).locationGranted ?? false;
    setState(() {
      _busy = false;
      _denied = !granted;
    });
    if (granted) widget.onNext();
  }

  Future<void> _later() async {
    await ref.read(onboardingControllerProvider.notifier).skipLocationPermission();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;

    return OnboardingScaffold(
      stepIndex: widget.stepIndex,
      stepCount: widget.stepCount,
      onBack: widget.onBack,
      onSkip: widget.onSkip,
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_denied)
            OnboardingPillButton(label: l10n.continueLabel, onPressed: widget.onNext)
          else ...[
            OnboardingPillButton(
              label: l10n.allowLocation,
              leadingIcon: Icons.location_on_outlined,
              showArrow: false,
              isLoading: _busy,
              onPressed: _allow,
            ),
            const SizedBox(height: AppSpacing.sm),
            OnboardingSecondaryButton(label: l10n.maybeLater, onPressed: _busy ? null : _later),
          ],
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.onboardingSettingsHint,
            textAlign: TextAlign.center,
            style: context.textStyles.labelSmall?.copyWith(
              color: colors.outline,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingHeading(
            icon: Icons.explore,
            title: l10n.onboardingLocationHeadline,
            subtitle: l10n.onboardingLocationTitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          _AutoPrecisionCard(),
          if (_denied) ...[
            const SizedBox(height: AppSpacing.md),
            OnboardingNote(
              key: const ValueKey('location-denied'),
              icon: Icons.location_off_outlined,
              iconColor: colors.error,
              text: l10n.onboardingLocationDenied,
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

class _AutoPrecisionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final accent = onboardingAccent(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.cardAll,
        border: Border.all(color: accent, width: 2),
        boxShadow: context.palette.whisperShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer.withValues(alpha: context.isDark ? 0.25 : 1),
                  borderRadius: AppRadius.mediumAll,
                ),
                child: Icon(Icons.near_me, size: 22, color: accent),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xxs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          l10n.onboardingLocationAutoTitle,
                          style: context.textStyles.titleMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        OnboardingTag(l10n.onboardingRecommended, strong: true),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.onboardingLocationAutoBody,
                      style: context.textStyles.bodySmall?.copyWith(color: colors.secondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: AppRadius.mediumAll,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user, size: 18, color: accent),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.onboardingLocationPrivacy,
                    style: context.textStyles.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
