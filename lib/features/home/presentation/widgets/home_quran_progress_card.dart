import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../providers/home_providers.dart';

class HomeQuranProgressCard extends ConsumerWidget {
  const HomeQuranProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progressAsync = ref.watch(quranProgressProvider);

    return SakinahCard(
      child: progressAsync.when(
        loading: () => const SizedBox(
          height: 88,
          child: Column(
            children: [
              SkeletonLoader(height: 20, width: 160),
              SizedBox(height: AppSpacing.sm),
              SkeletonLoader(height: 8),
            ],
          ),
        ),
        error: (e, st) => ErrorState(message: l10n.errorGeneric),
        data: (progress) {
          if (progress == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.yourQuran, style: context.textStyles.labelLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.comingSoonBody,
                  style: context.textStyles.bodyMedium
                      ?.copyWith(color: context.colors.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.md),
                SakinahOutlinedButton(
                  label: l10n.continueReading,
                  expand: false,
                  onPressed: () => context.go(AppRoutes.quran),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.yourQuran, style: context.textStyles.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(progress.surahNameEn, style: context.textStyles.headlineSmall),
              Text(
                l10n.ayahLabel(progress.ayahNumber),
                style: context.textStyles.bodyMedium
                    ?.copyWith(color: context.colors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.md),
              ProgressBar(value: progress.progress),
              const SizedBox(height: AppSpacing.md),
              SakinahOutlinedButton(
                label: l10n.continueReading,
                expand: false,
                onPressed: () => context.go(AppRoutes.quran),
              ),
            ],
          );
        },
      ),
    );
  }
}
