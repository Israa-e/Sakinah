import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../dhikr/presentation/dhikr_routes.dart';
import '../providers/home_providers.dart';
import 'home_pill_button.dart';

class HomeDhikrCard extends ConsumerWidget {
  const HomeDhikrCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.colors;
    final dhikr = ref.watch(todaysDhikrProvider);
    final count = dhikr.countToday;
    final reference = dhikr.reference;

    return SakinahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: CardEyebrow(l10n.todaysDhikr)),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  l10n.homeDhikrTarget(dhikr.targetCount),
                  style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            dhikr.arabicText,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: context.sakinahTypography.quranTextMedium.copyWith(color: colors.primary),
          ),
          if (reference != null)
            Text(
              reference,
              textAlign: TextAlign.center,
              style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
            ),
          const SizedBox(height: AppSpacing.sm),
          Divider(height: 1, color: colors.surfaceContainer),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (count != null) ...[
                CircularProgress(
                  value: dhikr.targetCount == 0 ? 0 : count / dhikr.targetCount,
                  size: 36,
                  strokeWidth: 3,
                  color: context.palette.heroAccent,
                  trackColor: colors.surfaceContainerHigh,
                  child: Text(
                    '$count',
                    style: context.textStyles.labelSmall?.copyWith(color: colors.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.homeDhikrProgress(count, dhikr.targetCount),
                    style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ),
              ] else
                const Spacer(),
              HomePillButton(
                label: l10n.start,
                style: HomePillStyle.hero,
                icon: Icons.arrow_forward,
                onPressed: () => context.go(DhikrPaths.counter(dhikr.key)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
