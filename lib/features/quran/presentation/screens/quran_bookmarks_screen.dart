import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_app_bar.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../data/drift_quran_repository.dart';
import '../../domain/quran_models.dart';
import '../providers/quran_providers.dart';
import '../quran_routes.dart';
import '../widgets/quran_ornaments.dart';

/// Saved ayahs, newest first. Tap to open the reader at that ayah; swipe or
/// use the remove button to delete.
class QuranBookmarksScreen extends ConsumerWidget {
  const QuranBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final bookmarksAsync = ref.watch(quranBookmarksProvider);
    final surahs = ref.watch(surahListProvider).valueOrNull ?? const <Surah>[];
    final byNumber = {for (final s in surahs) s.number: s};

    return Scaffold(
      appBar: SakinahAppBar(title: l10n.quranBookmarksTitle, showBackButton: true),
      body: bookmarksAsync.when(
        loading: () => const LoadingState(),
        error: (_, _) => ErrorState(
          message: l10n.errorGeneric,
          retryLabel: l10n.retry,
          onRetry: () => ref.invalidate(quranBookmarksProvider),
        ),
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return EmptyState(
              icon: Icons.bookmark_border,
              title: l10n.quranBookmarksEmptyTitle,
              message: l10n.quranBookmarksEmptyBody,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            itemCount: bookmarks.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              final b = bookmarks[i];
              return _BookmarkTile(
                key: ValueKey('bookmark-${b.surahNumber}-${b.ayahNumber}'),
                bookmark: b,
                surah: byNumber[b.surahNumber],
                onRemove: () => _remove(context, ref, b),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, QuranBookmark b) async {
    final message = context.l10n.quranBookmarkRemoved;
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(quranRepositoryProvider).removeBookmark(b.surahNumber, b.ayahNumber);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile({
    required this.bookmark,
    required this.surah,
    required this.onRemove,
    super.key,
  });

  final QuranBookmark bookmark;
  final Surah? surah;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final ayah = bookmark.ayah;
    final reference = '${bookmark.surahNumber}:${bookmark.ayahNumber}';
    return Dismissible(
      key: ValueKey('dismiss-$reference'),
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: AppSpacing.xl),
        decoration: BoxDecoration(color: colors.errorContainer, borderRadius: AppRadius.cardAll),
        child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
      ),
      direction: DismissDirection.endToStart,
      child: SakinahCard(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 4, 16),
        onTap: () =>
            context.push(QuranPaths.surah(bookmark.surahNumber, ayah: bookmark.ayahNumber)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AyahGlyph(number: bookmark.ayahNumber),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    surah == null ? reference : l10n.quranSurahCitation(surah!.nameEn, reference),
                    style: context.textStyles.titleSmall?.copyWith(color: colors.primary),
                  ),
                ),
                IconButton(
                  tooltip: l10n.quranRemoveBookmark,
                  onPressed: onRemove,
                  icon: Icon(Icons.bookmark_remove_outlined, color: colors.onSurfaceVariant),
                ),
              ],
            ),
            if (ayah != null) ...[
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: Text(
                  ayah.textAr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: context.sakinahTypography.quranTextMedium.copyWith(
                    fontSize: 19,
                    color: colors.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: Text(
                  '${ayah.translation} (${ayah.translatorName})',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  style: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
