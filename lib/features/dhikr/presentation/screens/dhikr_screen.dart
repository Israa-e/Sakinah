import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../providers/dhikr_providers.dart';
import '../widgets/dhikr_category_chips.dart';
import '../widgets/dhikr_cycle_card.dart';
import '../widgets/dhikr_garden_summary.dart';
import '../widgets/dhikr_item_card.dart';
import '../widgets/dhikr_segmented_toggle.dart';
import '../widgets/dhikr_top_bar.dart';

/// Dhikr tab root: adhkar sanctuary (list + counter entry points) and a
/// compact garden summary, switched by the segmented toggle.
class DhikrScreen extends ConsumerWidget {
  const DhikrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final mode = ref.watch(dhikrViewProvider);
    final filter = ref.watch(dhikrCategoryFilterProvider);
    final items = ref
        .watch(dhikrCatalogProvider)
        .where((i) => filter == null || i.category == filter)
        .toList();

    const gutter = EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.lg);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const DhikrTopBar(),
            Expanded(
              child: CustomScrollView(
                key: const ValueKey('dhikr-scroll'),
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(child: _Header()),
                  ),
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: DhikrSegmentedToggle<DhikrViewMode>(
                        selected: mode,
                        onChanged: ref.read(dhikrViewProvider.notifier).select,
                        segments: [
                          DhikrSegment(
                            value: DhikrViewMode.counter,
                            label: l10n.dhikrTabCounter,
                            icon: Icons.touch_app_outlined,
                          ),
                          DhikrSegment(
                            value: DhikrViewMode.garden,
                            label: l10n.dhikrTabGarden,
                            icon: Icons.local_florist_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (mode == DhikrViewMode.counter) ...[
                    const SliverPadding(
                      padding: gutter,
                      sliver: SliverToBoxAdapter(child: DhikrCycleCard()),
                    ),
                    SliverPadding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lg,
                        AppSpacing.xl,
                        AppSpacing.lg,
                        AppSpacing.sm,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.dhikrSectionTitle,
                                style: context.textStyles.titleLarge?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                            ),
                            CardEyebrow(l10n.dhikrAuthenticBadge, icon: Icons.verified_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: gutter,
                      sliver: SliverToBoxAdapter(child: DhikrCategoryChips()),
                    ),
                    SliverPadding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lg,
                        AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.xxl,
                      ),
                      sliver: SliverList.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) => DhikrItemCard(item: items[index]),
                      ),
                    ),
                  ] else
                    const SliverPadding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.xxl,
                      ),
                      sliver: SliverToBoxAdapter(child: DhikrGardenSummary()),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardEyebrow(l10n.dhikrEyebrow),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.dhikrTitle,
                style: context.textStyles.headlineLarge?.copyWith(color: context.colors.primary),
              ),
            ],
          ),
        ),
        if (!context.isRtl) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.dhikrTitleArabic,
            textDirection: TextDirection.rtl,
            style: context.sakinahTypography.arabicUi.copyWith(color: context.palette.gold),
          ),
        ],
      ],
    );
  }
}
