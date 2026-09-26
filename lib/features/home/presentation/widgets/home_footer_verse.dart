import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../data/home_verse.dart';

/// Quiet closing verse (Quran 13:28, verified — see [homeFooterVerse]).
class HomeFooterVerse extends StatelessWidget {
  const HomeFooterVerse({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        children: [
          Text(
            homeFooterVerse.arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: context.sakinahTypography.quranTextMedium.copyWith(
              color: colors.secondary,
              fontSize: 18,
            ),
          ),
          if (!isArabic)
            Text(
              '"${homeFooterVerse.translation}"',
              textAlign: TextAlign.center,
              style: context.textStyles.labelSmall?.copyWith(
                color: colors.secondary.withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 2),
          Text(
            context.l10n.homeVerseSource(homeFooterVerse.reference),
            textAlign: TextAlign.center,
            style: context.textStyles.labelSmall?.copyWith(
              color: colors.secondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
