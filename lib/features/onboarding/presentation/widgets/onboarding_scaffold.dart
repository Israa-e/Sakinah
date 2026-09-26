import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';

/// Shared frame for every numbered onboarding step (mockups 12–15, 06):
/// circular back button, "Step n of m" pill, optional Skip, a segmented
/// progress bar, a scrollable content canvas and a bottom-pinned action area
/// so every step's primary pill lands in the same place.
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    required this.body,
    required this.stepIndex,
    required this.stepCount,
    super.key,
    this.onBack,
    this.onSkip,
    this.footer,
  });

  final Widget body;

  /// Zero-based position among the numbered steps.
  final int stepIndex;
  final int stepCount;
  final VoidCallback? onBack;
  final VoidCallback? onSkip;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 40,
                    child: onBack == null
                        ? null
                        : _CircleIconButton(
                            icon: Icons.arrow_back,
                            tooltip: l10n.back,
                            onPressed: onBack!,
                          ),
                  ),
                  Expanded(
                    child: Center(
                      child: _StepPill(label: l10n.onboardingStepOf(stepIndex + 1, stepCount)),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 40),
                    child: onSkip == null
                        ? const SizedBox(height: 40)
                        : TextButton(
                            onPressed: onSkip,
                            style: TextButton.styleFrom(
                              foregroundColor: context.colors.onSurfaceVariant,
                              minimumSize: const Size(40, 40),
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                            ),
                            child: Text(l10n.skip),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
              child: SegmentedProgress(current: stepIndex, count: stepCount),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: body,
              ),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xs,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}

/// Five-segment linear progress (`grid grid-cols-5 gap-1.5 h-1.5`).
class SegmentedProgress extends StatelessWidget {
  const SegmentedProgress({required this.current, required this.count, super.key});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    final active = context.isDark ? context.colors.primary : context.palette.hero;
    return Semantics(
      label: context.l10n.onboardingStepOf(current + 1, count),
      child: Row(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 6,
                decoration: BoxDecoration(
                  color: i <= current ? active : context.colors.surfaceContainerHigh,
                  borderRadius: AppRadius.pillAll,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHigh.withValues(alpha: 0.6),
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: context.colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: context.textStyles.labelSmall?.copyWith(color: context.colors.secondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.tooltip, required this.onPressed});

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surfaceContainerLowest,
        border: Border.all(color: context.colors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: context.palette.whisperShadow,
      ),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        iconSize: 20,
        color: context.colors.primary,
        icon: Icon(icon),
      ),
    );
  }
}
