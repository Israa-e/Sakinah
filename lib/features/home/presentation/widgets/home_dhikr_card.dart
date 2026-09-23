import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../providers/home_providers.dart';

class HomeDhikrCard extends ConsumerWidget {
  const HomeDhikrCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final dhikr = ref.watch(todaysDhikrProvider);

    return SakinahCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.todaysDhikr, style: context.textStyles.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  dhikr.arabicText,
                  style: context.sakinahTypography.arabicHeading,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${dhikr.targetCount}',
                  style: context.textStyles.bodyMedium
                      ?.copyWith(color: context.colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SakinahOutlinedButton(
            label: l10n.start,
            expand: false,
            onPressed: () => context.go(AppRoutes.dhikr),
          ),
        ],
      ),
    );
  }
}
