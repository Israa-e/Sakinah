import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/states.dart';
import '../../../dhikr/presentation/dhikr_routes.dart';
import '../../domain/dua.dart';
import '../providers/duas_providers.dart';
import '../widgets/dua_actions.dart';
import '../widgets/dua_cards.dart';
import '../widgets/dua_category_chips.dart';

class DuasLibraryScreen extends ConsumerStatefulWidget {
  const DuasLibraryScreen({super.key, this.initialCategory, this.initialSavedOnly = false});

  final DuaCategory? initialCategory;
  final bool initialSavedOnly;

  @override
  ConsumerState<DuasLibraryScreen> createState() => _DuasLibraryScreenState();
}

class _DuasLibraryScreenState extends ConsumerState<DuasLibraryScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null || widget.initialSavedOnly) {
      // Providers can't be modified while the tree is building.
      unawaited(Future.microtask(() {
        if (!mounted) return;
        final notifier = ref.read(duaLibraryFilterProvider.notifier)
          ..setCategory(widget.initialCategory);
        if (widget.initialSavedOnly) notifier.setSavedOnly(savedOnly: true);
      }));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(duaLibraryFilterProvider);
    final notifier = ref.read(duaLibraryFilterProvider.notifier);
    final results = ref.watch(filteredDuasProvider);
    final featured = ref.watch(featuredDuaProvider).valueOrNull;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: _LibraryHeader(
                savedOnly: filter.savedOnly,
                onToggleSaved: notifier.toggleSavedOnly,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.md),
                child: _SearchCapsule(
                  controller: _searchController,
                  onChanged: notifier.setQuery,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DuaCategoryChips(selected: filter.category, onSelected: notifier.setCategory),
            ),
            if (!filter.isFiltering && featured != null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, 0),
                sliver: SliverToBoxAdapter(
                  child: FeaturedDuaCard(dua: featured, eyebrow: l10n.duasFeaturedLabel),
                ),
              ),
            ...results.when(
              loading: () => [const SliverFillRemaining(hasScrollBody: false, child: LoadingState())],
              error: (e, _) => [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorState(
                    message: l10n.duasLoadError,
                    retryLabel: l10n.retry,
                    onRetry: () => ref.invalidate(duaCatalogProvider),
                  ),
                ),
              ],
              data: (duas) => [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.md),
                  sliver: SliverToBoxAdapter(
                    child: _SectionHeader(
                      title: filter.savedOnly ? l10n.duasSavedTitle : l10n.duasQuranSectionTitle,
                      subtitle: filter.savedOnly ? null : l10n.duasQuranSectionSubtitle,
                      trailing: l10n.duasCount(duas.length),
                    ),
                  ),
                ),
                if (duas.isEmpty)
                  SliverToBoxAdapter(
                    child: filter.savedOnly && filter.query.trim().isEmpty && filter.category == null
                        ? EmptyState(
                            icon: Icons.bookmark_border,
                            title: l10n.duasNoSavedTitle,
                            message: l10n.duasNoSavedMessage,
                          )
                        : EmptyState(
                            icon: Icons.search_off,
                            title: l10n.duasNoResultsTitle,
                            message: l10n.duasNoResultsMessage,
                          ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverList.separated(
                      itemCount: duas.length,
                      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, i) => DuaTile(dua: duas[i], index: i + 1),
                    ),
                  ),
              ],
            ),
            if (!filter.isFiltering)
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, 0),
                sliver: SliverToBoxAdapter(child: _DhikrInviteCard()),
              ),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl + context.viewPadding.bottom)),
          ],
        ),
      ),
    );
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader({required this.savedOnly, required this.onToggleSaved});

  final bool savedOnly;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
      child: Column(
        children: [
          Row(
            children: [
              DuaRoundIconButton(
                icon: Icons.arrow_back,
                tooltip: l10n.back,
                size: 40,
                onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_stories, size: 18, color: context.palette.gold),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        l10n.duasLibraryTitle,
                        style: context.textStyles.titleLarge?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              DuaRoundIconButton(
                icon: savedOnly ? Icons.bookmarks : Icons.bookmarks_outlined,
                tooltip: savedOnly ? l10n.duasShowAll : l10n.duasShowSaved,
                color: savedOnly ? context.palette.gold : null,
                size: 40,
                onPressed: onToggleSaved,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.duasLibrarySubtitle,
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SearchCapsule extends StatefulWidget {
  const _SearchCapsule({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<_SearchCapsule> createState() => _SearchCapsuleState();
}

class _SearchCapsuleState extends State<_SearchCapsule> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.md, end: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colors.primary, size: 22),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: (v) {
                setState(() {});
                widget.onChanged(v);
              },
              textInputAction: TextInputAction.search,
              style: context.textStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: context.l10n.duasSearchHint,
                hintStyle: context.textStyles.bodyMedium?.copyWith(color: colors.outline),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            IconButton(
              tooltip: context.l10n.duasClearSearch,
              icon: Icon(Icons.close, size: 20, color: colors.outline),
              onPressed: () {
                widget.controller.clear();
                setState(() {});
                widget.onChanged('');
              },
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing, this.subtitle});

  final String title;
  final String? subtitle;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(Icons.menu_book, size: 20, color: context.palette.gold),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: context.textStyles.bodySmall?.copyWith(color: context.colors.secondary),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          trailing,
          style: context.textStyles.labelMedium?.copyWith(color: context.palette.gold),
        ),
      ],
    );
  }
}

/// Deep-green invitation to the dhikr tab (mockup's closing card).
class _DhikrInviteCard extends StatelessWidget {
  const _DhikrInviteCard();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: palette.hero,
        borderRadius: AppRadius.cardAll,
        boxShadow: palette.heroShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.duasDhikrCardEyebrow.toUpperCase(),
                      style: context.textStyles.labelSmall?.copyWith(color: palette.heroAccent),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.duasDhikrCardTitle,
                      style: context.textStyles.headlineMedium?.copyWith(color: palette.onHero),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      l10n.duasDhikrCardBody,
                      style: context.textStyles.bodySmall?.copyWith(color: palette.onHeroMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.heroAccent, width: 2),
                ),
                child: Icon(Icons.touch_app, color: palette.heroAccent),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: palette.heroAccent,
              foregroundColor: palette.hero,
              shape: const StadiumBorder(),
            ),
            onPressed: () => context.go(DhikrPaths.root),
            child: Text(l10n.duasDhikrCardAction),
          ),
        ],
      ),
    );
  }
}
