import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_button.dart';
import '../../controllers/onboarding_controller.dart';
import '../../widgets/onboarding_scaffold.dart';

class NotificationsStep extends ConsumerWidget {
  const NotificationsStep({
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
            label: l10n.allowNotifications,
            icon: Icons.notifications_none,
            onPressed: () async {
              await controller.requestNotificationPermission();
              onNext();
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: () async {
              await controller.skipNotificationPermission();
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
            Icon(Icons.notifications_active_outlined, size: 72, color: colorScheme.primary),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.onboardingNotificationsTitle,
              style: context.textStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
