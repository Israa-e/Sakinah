import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../profile/presentation/profile_routes.dart';

/// Brand top bar from the mockup: spa mark, "Sakīnah" + Arabic subtitle,
/// profile shortcut.
class DhikrTopBar extends StatelessWidget {
  const DhikrTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.palette.cardBorder)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.spa_outlined, color: context.colors.primary),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.appName,
                    style: context.textStyles.titleLarge?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    l10n.dhikrBrandSubtitle,
                    style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: l10n.dhikrProfileTooltip,
              icon: Icon(Icons.account_circle_outlined, color: context.colors.secondary),
              onPressed: () => context.go(ProfilePaths.root),
            ),
          ],
        ),
      ),
    );
  }
}
