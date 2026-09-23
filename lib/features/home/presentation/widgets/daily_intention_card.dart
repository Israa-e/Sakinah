import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';

class DailyIntentionCard extends StatelessWidget {
  const DailyIntentionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SakinahCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.dailyIntentionTitle, style: context.textStyles.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.dailyIntentionText, style: context.textStyles.bodyLarge),
          const SizedBox(height: AppSpacing.md),
          SakinahOutlinedButton(
            label: l10n.begin,
            expand: false,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.comingSoonTitle)),
              );
            },
          ),
        ],
      ),
    );
  }
}
