import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/date_formatting.dart';
import '../../../../core/widgets/sakinah_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final now = DateTime.now();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${l10n.homeGreeting} 🌿', style: context.textStyles.headlineMedium),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                AppDateFormat.gregorianLong(now, locale),
                style: context.textStyles.bodyMedium
                    ?.copyWith(color: context.colors.onSurfaceVariant),
              ),
              Text(
                AppDateFormat.hijriShort(now, locale),
                style: context.textStyles.bodySmall
                    ?.copyWith(color: context.colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
        SakinahIconButton(
          icon: Icons.person_outline,
          semanticLabel: l10n.navProfile,
          filled: true,
          onPressed: () => context.go(AppRoutes.profile),
        ),
      ],
    );
  }
}
