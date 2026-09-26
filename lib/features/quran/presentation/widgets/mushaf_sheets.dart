import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/states.dart';
import '../../data/tafsir_remote_data_source.dart';
import '../../domain/mushaf_page.dart';
import '../../domain/quran_models.dart';
import '../../domain/quran_page_index.dart';
import '../../domain/surah_search.dart';
import '../providers/quran_providers.dart';
import 'mushaf_ornaments.dart';
import 'mushaf_theme.dart';

Future<T?> _showMushafSheet<T>({
  required BuildContext context,
  required MushafTheme theme,
  required String title,
  required IconData icon,
  required Widget child,
  double heightFactor = 0.86,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: theme.paper,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => FractionallySizedBox(
      heightFactor: heightFactor,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                IconButton(
                  tooltip: context.l10n.quranClose,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: theme.frame),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.plaque,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: theme.frameSoft),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, size: 20, color: theme.frame),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textStyles.titleSmall?.copyWith(color: theme.ink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    ),
  );
}

// ------------------------------------------------------------------ tafseer

/// Tafsir al-Muyassar for [ayah], always with its attribution.
Future<void> showTafsirSheet(
  BuildContext context, {
  required Surah surah,
  required Ayah ayah,
  required MushafTheme theme,
}) {
  return _showMushafSheet<void>(
    context: context,
    theme: theme,
    title: context.l10n.quranMenuTafseer,
    icon: Icons.menu_book_outlined,
    child: _TafsirBody(surah: surah, ayah: ayah, theme: theme),
  );
}

class _TafsirBody extends ConsumerWidget {
  const _TafsirBody({required this.surah, required this.ayah, required this.theme});

  final Surah surah;
  final Ayah ayah;
  final MushafTheme theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final provider = ayahTafsirProvider(ayah.surahNumber, ayah.numberInSurah);
    final tafsir = ref.watch(provider);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      children: [
        _ArabicAyah(ayah: ayah, theme: theme),
        const SizedBox(height: 4),
        Text(
          l10n.quranSurahCitation(surah.nameEn, ayah.reference),
          style: context.textStyles.labelMedium?.copyWith(color: theme.frame),
        ),
        const SizedBox(height: 14),
        tafsir.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => ErrorState(
            message: l10n.quranTafsirLoadError,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(provider),
          ),
          data: (text) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: theme.plaque, borderRadius: BorderRadius.circular(16)),
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: context.sakinahTypography.arabicUi.copyWith(
                fontSize: 17,
                height: 1.9,
                color: theme.ink,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.verified_outlined, size: 16, color: theme.frame),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                isArabic ? TafsirSource.nameAr : TafsirSource.nameEn,
                style: context.textStyles.bodySmall?.copyWith(color: theme.frame),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ArabicAyah extends StatelessWidget {
  const _ArabicAyah({required this.ayah, required this.theme, this.fontSize = 21});

  final Ayah ayah;
  final MushafTheme theme;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${ayah.textAr} '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: AyahMarker(number: ayah.numberInSurah, theme: theme, size: fontSize * 1.25),
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: context.sakinahTypography.quranText.copyWith(
        fontSize: fontSize,
        height: 2,
        color: theme.ink,
      ),
    );
  }
}

// -------------------------------------------------------------- translation

/// All ayahs of the page with their translation cards; scrolls to [focus].
Future<void> showTranslationSheet(
  BuildContext context, {
  required MushafPageContent content,
  required MushafTheme theme,
  (int, int)? focus,
}) {
  return _showMushafSheet<void>(
    context: context,
    theme: theme,
    title: context.l10n.quranMenuTranslate,
    icon: Icons.translate,
    child: _TranslationBody(content: content, theme: theme, focus: focus),
  );
}

class _TranslationBody extends StatefulWidget {
  const _TranslationBody({required this.content, required this.theme, this.focus});

  final MushafPageContent content;
  final MushafTheme theme;
  final (int, int)? focus;

  @override
  State<_TranslationBody> createState() => _TranslationBodyState();
}

class _TranslationBodyState extends State<_TranslationBody> {
  final _focusKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _focusKey.currentContext;
      if (ctx != null && ctx.mounted) unawaited(Scrollable.ensureVisible(ctx, alignment: 0.05));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final ayahs = widget.content.ayahs;
    final translator = ayahs.isEmpty ? '' : ayahs.first.translatorName;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.quranTranslationBy(translator),
            textAlign: TextAlign.center,
            style: context.textStyles.labelMedium?.copyWith(color: theme.frame),
          ),
          const SizedBox(height: 8),
          for (final ayah in ayahs)
            Padding(
              key: (ayah.surahNumber, ayah.numberInSurah) == widget.focus ? _focusKey : null,
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ArabicAyah(ayah: ayah, theme: theme, fontSize: 20),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (ayah.surahNumber, ayah.numberInSurah) == widget.focus
                          ? theme.highlight
                          : theme.plaque,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${ayah.translation} (${ayah.numberInSurah})',
                      textDirection: TextDirection.ltr,
                      style: context.textStyles.bodyLarge?.copyWith(color: theme.ink),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------- index / search

/// Surah list with starting pages; resolves to the chosen page.
Future<int?> showSurahJumpSheet(
  BuildContext context, {
  required MushafTheme theme,
  required QuranPageIndex index,
  bool search = false,
}) {
  final l10n = context.l10n;
  return _showMushafSheet<int>(
    context: context,
    theme: theme,
    title: search ? l10n.quranSearchTitle : l10n.quranIndexTitle,
    icon: search ? Icons.search : Icons.format_list_numbered,
    child: _SurahJumpBody(theme: theme, index: index, search: search),
  );
}

class _SurahJumpBody extends ConsumerStatefulWidget {
  const _SurahJumpBody({required this.theme, required this.index, required this.search});

  final MushafTheme theme;
  final QuranPageIndex index;
  final bool search;

  @override
  ConsumerState<_SurahJumpBody> createState() => _SurahJumpBodyState();
}

class _SurahJumpBodyState extends ConsumerState<_SurahJumpBody> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = widget.theme;
    final surahs = ref.watch(surahListProvider).valueOrNull ?? const <Surah>[];
    final filtered = filterSurahs(surahs, _query);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            autofocus: widget.search,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: l10n.quranSearchHint,
              prefixIcon: Icon(Icons.search, color: theme.frame),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? EmptyState(icon: Icons.search_off, title: l10n.quranNoSearchResults(_query.trim()))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: theme.frameSoft.withValues(alpha: 0.5)),
                  itemBuilder: (context, i) {
                    final s = filtered[i];
                    final page = widget.index.firstPageOfSurah(s.number);
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Navigator.of(context).pop(page),
                      leading: SizedBox.square(
                        dimension: 36,
                        child: Center(
                          child: AyahMarker(number: s.number, theme: theme, size: 36),
                        ),
                      ),
                      title: Text(
                        s.nameEn,
                        style: context.textStyles.titleSmall?.copyWith(color: theme.ink),
                      ),
                      subtitle: Text(
                        '${l10n.quranPageLabel(page)} • ${l10n.quranAyahCount(s.ayahCount)}',
                        style: context.textStyles.bodySmall?.copyWith(color: theme.frame),
                      ),
                      trailing: Text(
                        s.nameAr,
                        textDirection: TextDirection.rtl,
                        style: context.sakinahTypography.quranTextMedium.copyWith(
                          fontSize: 18,
                          height: 1.4,
                          color: theme.ink,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// --------------------------------------------------------- reference marks

/// Bookmarked ayahs; resolves to the chosen (surah, ayah).
Future<(int, int)?> showReferenceMarksSheet(
  BuildContext context, {
  required MushafTheme theme,
  required QuranPageIndex index,
}) {
  return _showMushafSheet<(int, int)>(
    context: context,
    theme: theme,
    title: context.l10n.quranReferenceMarks,
    icon: Icons.bookmarks_outlined,
    child: _ReferenceMarksBody(theme: theme, index: index),
  );
}

class _ReferenceMarksBody extends ConsumerWidget {
  const _ReferenceMarksBody({required this.theme, required this.index});

  final MushafTheme theme;
  final QuranPageIndex index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final bookmarks = ref.watch(quranBookmarksProvider);
    final surahs = ref.watch(surahListProvider).valueOrNull ?? const <Surah>[];
    final byNumber = {for (final s in surahs) s.number: s};
    return bookmarks.when(
      loading: () => const LoadingState(),
      error: (_, _) => ErrorState(message: l10n.errorGeneric),
      data: (list) => list.isEmpty
          ? EmptyState(
              icon: Icons.bookmark_border,
              title: l10n.quranBookmarksEmptyTitle,
              message: l10n.quranBookmarksEmptyBody,
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: list.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: theme.frameSoft.withValues(alpha: 0.5)),
              itemBuilder: (context, i) {
                final b = list[i];
                final reference = '${b.surahNumber}:${b.ayahNumber}';
                final surah = byNumber[b.surahNumber];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  onTap: () => Navigator.of(context).pop((b.surahNumber, b.ayahNumber)),
                  leading: Icon(Icons.bookmark, color: theme.frame),
                  title: Text(
                    surah == null ? reference : l10n.quranSurahCitation(surah.nameEn, reference),
                    style: context.textStyles.titleSmall?.copyWith(color: theme.ink),
                  ),
                  subtitle: Text(
                    l10n.quranPageLabel(index.pageOf(b.surahNumber, b.ayahNumber)),
                    style: context.textStyles.bodySmall?.copyWith(color: theme.frame),
                  ),
                  trailing: b.ayah == null
                      ? null
                      : SizedBox(
                          width: 120,
                          child: Text(
                            b.ayah!.textAr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: context.sakinahTypography.quranTextMedium.copyWith(
                              fontSize: 16,
                              height: 1.4,
                              color: theme.ink,
                            ),
                          ),
                        ),
                );
              },
            ),
    );
  }
}

/// Friendly message for a failed page load.
String pageLoadErrorMessage(BuildContext context, Object? error) =>
    error is NetworkFailure ? context.l10n.quranOfflineNotCached : context.l10n.quranLoadError;
