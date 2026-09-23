import 'package:flutter/material.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../widgets/onboarding_scaffold.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colors;

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      footer: SakinahButton(label: l10n.getStarted, onPressed: onNext),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.spa_outlined, size: 40, color: colorScheme.primary),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.appName, style: context.textStyles.displayMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.appTagline,
              style: context.textStyles.bodyLarge
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
