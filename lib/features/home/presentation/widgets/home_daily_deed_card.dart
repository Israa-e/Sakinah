import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../data/drift_home_repository.dart';
import '../providers/home_providers.dart';

class HomeDailyDeedCard extends ConsumerWidget {
  const HomeDailyDeedCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final deedAsync = ref.watch(dailyDeedProvider);

    return SakinahCard(
      child: deedAsync.when(
        loading: () => const SizedBox(
          height: 72,
          child: Column(
            children: [
              SkeletonLoader(width: 140),
              SizedBox(height: AppSpacing.sm),
              SkeletonLoader(),
            ],
          ),
        ),
        error: (e, st) => ErrorState(message: l10n.errorGeneric),
        data: (deed) {
          final text = locale == 'ar' ? deed.textAr : deed.textEn;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.dailyDeedTitle, style: context.textStyles.labelLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      text,
                      style: context.textStyles.bodyLarge?.copyWith(
                        decoration: deed.completed ? TextDecoration.lineThrough : null,
                        color: deed.completed ? context.colors.onSurfaceVariant : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Checkbox(
                value: deed.completed,
                onChanged: (value) {
                  ref
                      .read(homeRepositoryProvider)
                      .setDailyDeedCompleted(deed.day, value ?? false);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
