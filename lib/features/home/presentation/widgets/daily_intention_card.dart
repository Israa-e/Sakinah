import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../duas/presentation/duas_routes.dart';
import 'home_pill_button.dart';

/// "Today's intention" — a gentle prompt whose Begin opens Ask Sakīnah for a
/// quiet, guided moment of reflection.
class DailyIntentionCard extends StatelessWidget {
  const DailyIntentionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SakinahCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardEyebrow(l10n.dailyIntentionTitle, icon: Icons.light_mode_outlined),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.dailyIntentionText,
                  style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurface),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          HomePillButton(
            label: l10n.begin,
            style: HomePillStyle.tonal,
            onPressed: () => context.push(DuasPaths.ask),
          ),
        ],
      ),
    );
  }
}
