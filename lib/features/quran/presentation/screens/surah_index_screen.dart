import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../data/quran_page_index_loader.dart';
import '../../domain/quran_models.dart';
import '../../domain/surah_search.dart';
import '../providers/quran_providers.dart';
import '../quran_routes.dart';
import '../widgets/quran_ornaments.dart';

/// Quran tab root: search, continue-reading hero, bookmarks entry and the
/// list of all 114 surahs (available offline from the bundled index).
class SurahIndexScreen extends ConsumerStatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  ConsumerState<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends ConsumerState<SurahIndexScreen> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final surahsAsync = ref.watch(surahListProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: surahsAsync.when(
          loading: () => const LoadingState(),
          error: (_, _) => ErrorState(
            message: l10n.errorGeneric,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(surahListProvider),
          ),
          data: (surahs) {
            final filtered = filterSurahs(surahs, _query);
            final searching = _query.trim().isNotEmpty;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    0,
                  ),
                  sliver: SliverList.list(
                    children: [
                      const _IndexHeader(),
                      const SizedBox(height: AppSpacing.md),
                      _SearchCapsule(
                        controller: _search,
                        onChanged: (v) => setState(() => _query = v),
                        onClear: () {
                          _search.clear();
                          setState(() => _query = '');
                        },
                      ),
                      if (!searching) ...[
                        const SizedBox(height: AppSpacing.lg),
                        _ContinueReadingCard(surahs: surahs),
                        const SizedBox(height: AppSpacing.sm),
                        const _BookmarksEntry(),
                      ],
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        l10n.quranSurahsHeader.toUpperCase(),
                        style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ),
                ),
                if (filtered.isEmpty)
                  SliverToBoxAdapter(
                    child: EmptyState(
                      icon: Icons.search_off,
                      title: l10n.quranNoSearchResults(_query.trim()),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      0,
                      AppSpacing.lg,
                      AppSpacing.xxl,
                    ),
                    sliver: SliverList.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, i) => _SurahRow(surah: filtered[i]),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _IndexHeader extends StatelessWidget {
  const _IndexHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.navQuran,
                style: context.textStyles.headlineMedium?.copyWith(color: context.colors.primary),
              ),
              Text(
                l10n.quranTitle,
                style: context.textStyles.bodyMedium?.copyWith(color: context.palette.gold),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: l10n.quranBookmarksTitle,
          onPressed: () => context.push(QuranPaths.bookmarks),
          icon: Icon(Icons.bookmarks_outlined, color: context.colors.primary),
        ),
      ],
    );
  }
}

class _SearchCapsule extends StatelessWidget {
  const _SearchCapsule({required this.controller, required this.onChanged, required this.onClear});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: context.colors.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: context.palette.whisperShadow,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: context.l10n.quranSearchHint,
          prefixIcon: Icon(Icons.search, color: context.colors.onSurfaceVariant),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
                    icon: const Icon(Icons.close),
                    onPressed: onClear,
                  ),
          ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _ContinueReadingCard extends ConsumerWidget {
  const _ContinueReadingCard({required this.surahs});

  final List<Surah> surahs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final progress = ref.watch(quranReadingProgressProvider).valueOrNull;
    final fatiha = surahs.first;

    final title = progress?.surahNameEn ?? l10n.quranStartReadingTitle;
    final subtitleAr = progress?.surahNameAr ?? fatiha.nameAr;
    final target = progress == null
        ? QuranPaths.surah(1)
        : QuranPaths.surah(progress.surahNumber, ayah: progress.ayahNumber);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadius.heroAll,
        onTap: () => context.push(target),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: palette.hero,
            borderRadius: AppRadius.heroAll,
            boxShadow: palette.heroShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardEyebrow(
                progress == null ? l10n.yourQuran : l10n.continueReading,
                icon: Icons.auto_stories_outlined,
                color: palette.heroAccent,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textStyles.titleLarge?.copyWith(color: palette.onHero),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitleAr,
                          textDirection: TextDirection.rtl,
                          style: context.sakinahTypography.arabicUi.copyWith(
                            color: palette.onHeroMuted,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: palette.heroAccent, shape: BoxShape.circle),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: palette.hero,
                      semanticLabel: l10n.continueReading,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (progress == null)
                Text(
                  l10n.quranStartReadingBody,
                  style: context.textStyles.bodySmall?.copyWith(color: palette.onHeroMuted),
                )
              else ...[
                ClipRRect(
                  borderRadius: AppRadius.pillAll,
                  child: LinearProgressIndicator(
                    value: progress.fraction,
                    minHeight: 5,
                    color: palette.heroAccent,
                    backgroundColor: palette.onHero.withValues(alpha: 0.15),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.quranProgressAyahOf(progress.ayahNumber, progress.totalAyahs),
                  style: context.textStyles.labelMedium?.copyWith(color: palette.onHeroMuted),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BookmarksEntry extends ConsumerWidget {
  const _BookmarksEntry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final count = ref.watch(quranBookmarksProvider).valueOrNull?.length ?? 0;
    return SakinahCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      onTap: () => context.push(QuranPaths.bookmarks),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: context.colors.secondaryContainer.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.bookmark_outline, size: 20, color: context.colors.primary),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.quranBookmarksTitle, style: context.textStyles.titleSmall),
                Text(
                  l10n.quranBookmarksCount(count),
                  style: context.textStyles.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: context.colors.onSurfaceVariant),
        ],
      ),
    );
  }
}

class _SurahRow extends ConsumerWidget {
  const _SurahRow({required this.surah});

  final Surah surah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final page = ref.watch(quranPageIndexProvider).valueOrNull?.firstPageOfSurah(surah.number);
    return SakinahCard(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
      onTap: () =>
          context.push(page == null ? QuranPaths.surah(surah.number) : QuranPaths.page(page)),
      child: Row(
        children: [
          SurahNumberBadge(number: surah.number),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surah.nameEn,
                  style: context.textStyles.titleMedium?.copyWith(color: context.colors.primary),
                ),
                Text(
                  surah.meaningEn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (page != null) l10n.quranPageLabel(page),
                    l10n.quranAyahCount(surah.ayahCount),
                    revelationLabel(context, surah.revelationType),
                  ].join(' • '),
                  style: context.textStyles.labelSmall?.copyWith(color: context.colors.outline),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              surah.nameAr,
              textDirection: TextDirection.rtl,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: context.sakinahTypography.quranTextMedium.copyWith(
                fontSize: 20,
                height: 1.5,
                color: context.colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
