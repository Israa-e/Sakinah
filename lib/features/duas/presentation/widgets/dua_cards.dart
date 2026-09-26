import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../domain/dua.dart';
import '../duas_routes.dart';
import 'dua_actions.dart';
import 'dua_category_x.dart';

/// Hero "daily featured" du'a card (library + Ask Sakīnah sanctuary).
class FeaturedDuaCard extends StatelessWidget {
  const FeaturedDuaCard({required this.dua, required this.eyebrow, super.key});

  final Dua dua;
  final String eyebrow;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      onTap: () => context.push(DuasPaths.detail(dua.key)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Flexible(child: DuaTag(label: eyebrow, icon: Icons.hotel_class, iconColor: context.palette.gold)),
              const SizedBox(width: AppSpacing.xs),
              const Spacer(),
              Icon(dua.category.icon, size: 16, color: context.palette.gold),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            dua.localizedTitle(context),
            style: context.textStyles.titleMedium?.copyWith(color: colors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            dua.arabic,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: context.sakinahTypography.quranText,
          ),
          const SizedBox(height: AppSpacing.md),
          const DuaDiamondDivider(),
          const SizedBox(height: AppSpacing.md),
          Text(
            dua.translation,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.3)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Flexible(child: _SourceBadge(dua: dua)),
              const SizedBox(width: AppSpacing.xs),
              const Spacer(),
              DuaSaveButton(dua: dua),
              const SizedBox(width: AppSpacing.xxs),
              DuaCopyButton(dua: dua),
            ],
          ),
        ],
      ),
    );
  }
}

class _SourceBadge extends StatelessWidget {
  const _SourceBadge({required this.dua});

  final Dua dua;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 14, color: context.colors.primary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              dua.surahLabel(context),
              style: context.textStyles.labelSmall?.copyWith(color: context.colors.secondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Library list tile ("du'a sanctuary tile").
class DuaTile extends StatelessWidget {
  const DuaTile({required this.dua, required this.index, super.key});

  final Dua dua;

  /// 1-based position shown in the numbered badge.
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SakinahCard(
      onTap: () => context.push(DuasPaths.detail(dua.key)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: colors.secondaryContainer, shape: BoxShape.circle),
                child: Text(
                  _localizedNumber(context, index),
                  style: context.textStyles.labelSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  dua.localizedTitle(context),
                  style: context.textStyles.titleMedium?.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: DuaTag(label: dua.category.label(context), icon: dua.category.icon),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            dua.arabic,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: context.sakinahTypography.quranTextMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            dua.translation,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.25)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: context.palette.gold),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  dua.surahLabel(context),
                  style: context.textStyles.labelSmall?.copyWith(color: colors.outline),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DuaSaveButton(dua: dua, size: 32),
              const SizedBox(width: AppSpacing.xs),
              DuaCopyButton(dua: dua, size: 32),
            ],
          ),
        ],
      ),
    );
  }
}

String _localizedNumber(BuildContext context, int n) {
  if (Localizations.localeOf(context).languageCode != 'ar') return '$n';
  const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return '$n'.split('').map((c) => digits[int.parse(c)]).join();
}
