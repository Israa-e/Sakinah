import 'package:flutter/material.dart';

import '../../../../../app/theme/app_typography.dart';
import '../../../../../app/theme/sakinah_palette.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../widgets/onboarding_widgets.dart';

/// "Sanctuary of the heart" welcome (mockup 11): calm brand emblem, dual
/// wordmark, tagline and a single primary pill into the setup steps.
class WelcomeStep extends StatelessWidget {
  const WelcomeStep({required this.onNext, super.key});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final palette = context.palette;

    return Scaffold(
      body: Stack(
        children: [
          // Soft radial wash + warm gold horizon glow.
          PositionedDirectional(
            top: -160,
            start: -80,
            end: -80,
            child: IgnorePointer(
              child: Container(
                height: 420,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.secondaryContainer.withValues(alpha: context.isDark ? 0.10 : 0.35),
                      colors.secondaryContainer.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.tertiaryFixed.withValues(alpha: context.isDark ? 0.05 : 0.22),
                      colors.tertiaryFixed.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - AppSpacing.xl * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OnboardingBadge(l10n.onboardingWelcomeBadge),
                      const SizedBox(height: AppSpacing.xxl),
                      Column(
                        children: [
                          _HaloEmblem(palette: palette),
                          const SizedBox(height: AppSpacing.xl),
                          Text(
                            l10n.appName,
                            textAlign: TextAlign.center,
                            style: context.textStyles.displayMedium?.copyWith(
                              color: colors.primary,
                            ),
                          ),
                          if (!context.isRtl) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              l10n.onboardingWelcomeWordmark,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: context.sakinahTypography.arabicHeading.copyWith(
                                color: onboardingAccent(context),
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          Container(
                            width: 48,
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  palette.gold.withValues(alpha: 0),
                                  palette.gold.withValues(alpha: 0.5),
                                  palette.gold.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              l10n.appTagline,
                              textAlign: TextAlign.center,
                              style: context.textStyles.bodyLarge?.copyWith(
                                color: colors.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Column(
                        children: [
                          OnboardingPillButton(label: l10n.getStarted, onPressed: onNext),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.spa, size: 14, color: palette.gold),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  l10n.onboardingWelcomeFootnote.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: context.textStyles.labelSmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HaloEmblem extends StatelessWidget {
  const _HaloEmblem({required this.palette});

  final SakinahPalette palette;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox.square(
      dimension: 144,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.secondaryContainer.withValues(alpha: context.isDark ? 0.12 : 0.4),
            ),
          ),
          Container(
            width: 112,
            height: 112,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surfaceContainerLowest,
              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
              boxShadow: palette.whisperShadow,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.pillAll,
                border: Border.all(color: palette.gold.withValues(alpha: 0.3)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.nightlight_round, size: 52, color: onboardingAccent(context)),
                  PositionedDirectional(
                    end: 26,
                    bottom: 30,
                    child: Icon(Icons.eco, size: 22, color: palette.gold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
