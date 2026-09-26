import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../data/drift_home_repository.dart';
import '../providers/home_providers.dart';
import 'home_pill_button.dart';

class HomeDailyDeedCard extends ConsumerWidget {
  const HomeDailyDeedCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.colors;
    final locale = Localizations.localeOf(context).languageCode;
    final deedAsync = ref.watch(dailyDeedProvider);

    return SakinahCard(
      child: deedAsync.when(
        loading: () => const Column(
          children: [
            SkeletonLoader(width: 140),
            SizedBox(height: AppSpacing.sm),
            SkeletonLoader(),
          ],
        ),
        error: (e, st) => ErrorState(message: l10n.errorGeneric),
        data: (deed) {
          final text = locale == 'ar' ? deed.textAr : deed.textEn;
          final info = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.volunteer_activism_outlined, size: 18, color: colors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardEyebrow(l10n.dailyDeedTitle),
                    const SizedBox(height: 2),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: context.textStyles.bodyMedium!.copyWith(
                        color: deed.completed ? colors.onSurfaceVariant : colors.onSurface,
                        decoration: deed.completed ? TextDecoration.lineThrough : null,
                      ),
                      child: Text(text),
                    ),
                  ],
                ),
              ),
            ],
          );
          final button = HomePillButton(
            label: deed.completed ? l10n.markedAsDone : l10n.markAsDone,
            style: deed.completed ? HomePillStyle.tonal : HomePillStyle.outline,
            leadingIcon: deed.completed ? Icons.check : null,
            onPressed: () =>
                ref.read(homeRepositoryProvider).setDailyDeedCompleted(deed.day, !deed.completed),
          );

          return Semantics(
            toggled: deed.completed,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Side-by-side only when there's comfortable room (large text
                // or narrow phones stack the button under the text).
                final roomy =
                    constraints.maxWidth >= 300 &&
                    MediaQuery.textScalerOf(context).scale(14) <= 15.5;
                if (roomy) {
                  return Row(
                    children: [
                      Expanded(child: info),
                      const SizedBox(width: AppSpacing.sm),
                      button,
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    info,
                    const SizedBox(height: AppSpacing.sm),
                    Align(alignment: AlignmentDirectional.centerEnd, child: button),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
