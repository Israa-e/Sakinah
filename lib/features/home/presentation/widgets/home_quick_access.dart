import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../duas/presentation/duas_routes.dart';

/// Three quick doors out of Home: Qibla, the Du'as library, Ask Sakīnah.
/// (Quran and Dhikr already have their own tabs.)
class HomeQuickAccess extends StatelessWidget {
  const HomeQuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _QuickTile(
              icon: Icons.explore_outlined,
              label: l10n.homeQuickQibla,
              onTap: () => context.push(AppRoutes.qibla),
            ),
          ),
          const SizedBox(width: AppSpacing.sm - 2),
          Expanded(
            child: _QuickTile(
              icon: Icons.volunteer_activism_outlined,
              label: l10n.homeQuickDuas,
              onTap: () => context.push(DuasPaths.library),
            ),
          ),
          const SizedBox(width: AppSpacing.sm - 2),
          Expanded(
            child: _QuickTile(
              icon: Icons.auto_awesome_outlined,
              label: l10n.homeQuickAsk,
              onTap: () => context.push(DuasPaths.ask),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: SakinahCard(
        onTap: onTap,
        borderRadius: AppRadius.largeAll,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors.primary, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.textStyles.labelMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
