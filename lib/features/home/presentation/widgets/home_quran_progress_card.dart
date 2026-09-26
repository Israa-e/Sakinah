import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/progress_indicators.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../../quran/presentation/quran_routes.dart';
import '../../domain/home_models.dart';
import '../providers/home_providers.dart';
import 'home_pill_button.dart';

class HomeQuranProgressCard extends ConsumerWidget {
  const HomeQuranProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final progressAsync = ref.watch(quranProgressProvider);
    return SakinahCard(
      child: progressAsync.when(
        loading: () => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(height: 20, width: 160),
            SizedBox(height: AppSpacing.sm),
            SkeletonLoader(height: 8),
          ],
        ),
        error: (e, st) => ErrorState(
          message: l10n.errorGeneric,
          retryLabel: l10n.retry,
          onRetry: () => ref.invalidate(quranProgressProvider),
        ),
        data: (progress) =>
            progress == null ? const _EmptyQuran() : _QuranProgress(progress: progress),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardEyebrow(context.l10n.yourQuran),
              const SizedBox(height: 2),
              Text(title, style: context.textStyles.titleMedium?.copyWith(color: colors.onSurface)),
              Text(
                subtitle,
                style: context.textStyles.bodySmall?.copyWith(color: colors.secondary),
              ),
            ],
          ),
        ),
        Icon(Icons.menu_book_outlined, color: colors.primary.withValues(alpha: 0.4), size: 24),
      ],
    );
  }
}

class _QuranProgress extends StatelessWidget {
  const _QuranProgress({required this.progress});

  final QuranProgressInfo progress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final juz = progress.juz;
    final percent = (progress.progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(
          // The stored Arabic name already reads "سورة …".
          title: isArabic ? progress.surahNameAr : l10n.homeQuranSurahName(progress.surahNameEn),
          subtitle: juz == null
              ? l10n.ayahLabel(progress.ayahNumber)
              : l10n.homeQuranAyahJuz(progress.ayahNumber, juz),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.homeQuranCompletion,
                style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
              ),
            ),
            Text(
              l10n.homeQuranPercent(percent),
              style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ProgressBar(
          value: progress.progress,
          color: context.isDark ? colors.primary : colors.primaryContainer,
          trackColor: colors.surfaceContainer,
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: HomePillButton(
            label: l10n.continueReading,
            icon: Icons.arrow_forward,
            onPressed: () =>
                context.go(QuranPaths.surah(progress.surahNumber, ayah: progress.ayahNumber)),
          ),
        ),
      ],
    );
  }
}

class _EmptyQuran extends StatelessWidget {
  const _EmptyQuran();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(title: l10n.homeQuranEmptyTitle, subtitle: l10n.homeQuranEmptyBody),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: HomePillButton(
            label: l10n.homeQuranStartReading,
            icon: Icons.arrow_forward,
            onPressed: () => context.go(QuranPaths.surah(1)),
          ),
        ),
      ],
    );
  }
}
