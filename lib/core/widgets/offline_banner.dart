import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_spacing.dart';
import '../extensions/build_context_extensions.dart';
import '../network/network_info.dart';

/// Slim, non-blocking notice shown at the top of a screen while offline.
/// Sakīnah is offline-first, so this is informational, never an error.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(isOnlineProvider).valueOrNull ?? true;
    if (online) return const SizedBox.shrink();

    final colorScheme = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      color: colorScheme.secondaryContainer,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_outlined, size: 16, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              context.l10n.offlineNotice,
              style: context.textStyles.bodySmall
                  ?.copyWith(color: colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
