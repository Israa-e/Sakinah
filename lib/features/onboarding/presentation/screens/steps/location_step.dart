import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';

class LocationStep extends ConsumerWidget {
  const LocationStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colorScheme = context.colors;
    final controller = ref.read(onboardingControllerProvider.notifier);

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      footer: Column(
        children: [
          SakinahButton(
            label: l10n.allowLocation,
            icon: Icons.location_on_outlined,
            onPressed: () async {
              await controller.requestLocationPermission();
              onNext();
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: () async {
              await controller.skipLocationPermission();
              onNext();
            },
            child: Text(l10n.maybeLater),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.explore_outlined, size: 72, color: colorScheme.primary),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.onboardingLocationTitle,
              style: context.textStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
