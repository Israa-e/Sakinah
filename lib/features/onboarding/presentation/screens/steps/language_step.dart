import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/config/locale_provider.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../widgets/onboarding_scaffold.dart';
import '../../widgets/onboarding_widgets.dart';

/// Mockup 12. Tapping a card flips the app locale (and text direction) live.
class LanguageStep extends ConsumerWidget {
  const LanguageStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
    this.onSkip,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentLocale = ref.watch(appLocaleProvider);

    void select(Locale locale) {
      ref.read(appLocaleProvider.notifier).setLocale(locale);
    }

    final isEn = currentLocale.languageCode == 'en';
    final isAr = currentLocale.languageCode == 'ar';

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      onSkip: onSkip,
      footer: OnboardingPillButton(label: l10n.continueLabel, onPressed: onNext),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingHeading(
            icon: Icons.translate,
            badge: l10n.onboardingLanguageBadge,
            title: l10n.onboardingLanguageTitle,
            subtitle: l10n.onboardingLanguageSubtitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          SelectableOptionCard(
            key: const ValueKey('language-en'),
            selected: isEn,
            onTap: () => select(const Locale('en')),
            leading: OptionLeadingBadge(
              selected: isEn,
              child: const Text('En', textDirection: TextDirection.ltr),
            ),
            title: l10n.languageEnglish,
            subtitle: l10n.onboardingLanguageEnglishDesc,
          ),
          const SizedBox(height: AppSpacing.sm),
          SelectableOptionCard(
            key: const ValueKey('language-ar'),
            selected: isAr,
            onTap: () => select(const Locale('ar')),
            leading: OptionLeadingBadge(
              selected: isAr,
              child: const Text('ع', textDirection: TextDirection.rtl),
            ),
            title: l10n.languageArabic,
            subtitle: l10n.onboardingLanguageArabicDesc,
          ),
          const SizedBox(height: AppSpacing.md),
          OnboardingNote(icon: Icons.auto_stories, text: l10n.onboardingLanguageNote),
        ],
      ),
    );
  }
}
