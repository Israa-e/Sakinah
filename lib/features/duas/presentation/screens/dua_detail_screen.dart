import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../../quran/presentation/quran_routes.dart';
import '../../domain/dua.dart';
import '../duas_routes.dart';
import '../providers/duas_providers.dart';
import '../widgets/dua_actions.dart';
import '../widgets/dua_category_x.dart';

/// Reading canvas for one du'a: large Arabic, translation, citation, save,
/// copy and a local "recite" counter.
class DuaDetailScreen extends ConsumerWidget {
  const DuaDetailScreen({required this.duaKey, super.key});

  final String duaKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dua = ref.watch(duaByKeyProvider(duaKey));
    final palette = context.palette;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: palette.paper,
      appBar: AppBar(
        backgroundColor: palette.paper,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: l10n.back,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go(DuasPaths.library),
        ),
        title: dua.valueOrNull == null ? null : Text(dua.valueOrNull!.category.label(context)),
        actions: [
          if (dua.valueOrNull case final d?) ...[
            DuaSaveButton(dua: d, size: 40),
            const SizedBox(width: AppSpacing.xs),
            DuaCopyButton(dua: d, size: 40),
            const SizedBox(width: AppSpacing.md),
          ],
        ],
      ),
      body: dua.when(
        loading: () => const LoadingState(),
        error: (_, _) => ErrorState(
          message: l10n.duasLoadError,
          retryLabel: l10n.retry,
          onRetry: () => ref.invalidate(duaCatalogProvider),
        ),
        data: (d) => d == null
            ? EmptyState(icon: Icons.search_off, title: l10n.duasNotFound)
            : _DuaBody(dua: d),
      ),
    );
  }
}

class _DuaBody extends ConsumerWidget {
  const _DuaBody({required this.dua});

  final Dua dua;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final l10n = context.l10n;
    final saved = ref.watch(isDuaSavedProvider(dua.key));

    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xxl + context.viewPadding.bottom,
      ),
      children: [
        Center(child: CardEyebrow(dua.category.label(context), icon: dua.category.icon)),
        const SizedBox(height: AppSpacing.xs),
        Text(
          dua.localizedTitle(context),
          style: context.textStyles.headlineMedium?.copyWith(color: colors.primary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          dua.arabic,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: context.sakinahTypography.quranText.copyWith(height: 2.1),
        ),
        const SizedBox(height: AppSpacing.xl),
        const DuaDiamondDivider(),
        const SizedBox(height: AppSpacing.xl),
        Text(
          dua.translation,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: context.textStyles.bodyLarge?.copyWith(color: colors.onSurfaceVariant, height: 1.6),
        ),
        const SizedBox(height: AppSpacing.xl),
        _CitationCard(dua: dua),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: saved
                  ? SakinahOutlinedButton(
                      label: l10n.duasSaved,
                      icon: Icons.bookmark,
                      onPressed: () => ref.read(savedDuaKeysProvider.notifier).toggle(dua.key),
                    )
                  : SakinahButton(
                      label: l10n.duasSave,
                      icon: Icons.bookmark_border,
                      onPressed: () => ref.read(savedDuaKeysProvider.notifier).toggle(dua.key),
                    ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: SakinahOutlinedButton(
                label: l10n.duasCopy,
                icon: Icons.content_copy_outlined,
                onPressed: () => copyDua(context, dua),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const _ReciteCounter(),
      ],
    );
  }
}

class _CitationCard extends StatelessWidget {
  const _CitationCard({required this.dua});

  final Dua dua;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SakinahCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(Icons.verified, color: colors.primary, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dua.surahLabel(context),
                  style: context.textStyles.titleSmall?.copyWith(color: colors.primary),
                ),
                const SizedBox(height: 2),
                Text(
                  context.l10n.duasTranslationBy(dua.translator),
                  style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (dua.isQuranic)
            Flexible(
              child: TextButton(
                onPressed: () => context.push(QuranPaths.surah(dua.surah!, ayah: dua.ayah)),
                child: Text(context.l10n.duasOpenInQuran, textAlign: TextAlign.center),
              ),
            ),
        ],
      ),
    );
  }
}

/// Tap-to-count mini counter. Local state only — nothing is persisted and no
/// prescribed repetition count is implied.
class _ReciteCounter extends StatefulWidget {
  const _ReciteCounter();

  @override
  State<_ReciteCounter> createState() => _ReciteCounterState();
}

class _ReciteCounterState extends State<_ReciteCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: palette.hero,
        borderRadius: AppRadius.cardAll,
        boxShadow: palette.heroShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.duasReciteTitle.toUpperCase(),
                  style: context.textStyles.labelSmall?.copyWith(color: palette.heroAccent),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.duasReciteHint,
                  style: context.textStyles.bodySmall?.copyWith(color: palette.onHeroMuted),
                ),
                if (_count > 0)
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: palette.onHero,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: () => setState(() => _count = 0),
                    child: Text(l10n.duasReciteReset),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Semantics(
            button: true,
            label: l10n.duasReciteCountSemantics(_count),
            excludeSemantics: true,
            child: Material(
              color: Colors.transparent,
              shape: CircleBorder(side: BorderSide(color: palette.heroAccent, width: 2)),
              child: InkWell(
                key: const Key('dua-recite-counter'),
                customBorder: const CircleBorder(),
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => _count++);
                },
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: Center(
                    child: Text(
                      '$_count',
                      style: context.sakinahTypography.counter.copyWith(
                        color: palette.onHero,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
