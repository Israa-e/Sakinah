import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/config/locale_provider.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/widgets/sakinah_card.dart';
import '../../widgets/onboarding_scaffold.dart';

class LanguageStep extends ConsumerWidget {
  const LanguageStep({
    required this.stepIndex,
    required this.stepCount,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final int stepIndex;
  final int stepCount;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentLocale = ref.watch(appLocaleProvider);

    Future<void> select(Locale locale) async {
      await ref.read(appLocaleProvider.notifier).setLocale(locale);
      onNext();
    }

    return OnboardingScaffold(
      stepIndex: stepIndex,
      stepCount: stepCount,
      onBack: onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingLanguageTitle, style: context.textStyles.headlineLarge),
          const SizedBox(height: AppSpacing.xl),
          _LanguageOption(
            label: l10n.languageArabic,
            selected: currentLocale.languageCode == 'ar',
            onTap: () => select(const Locale('ar')),
          ),
          const SizedBox(height: AppSpacing.md),
          _LanguageOption(
            label: l10n.languageEnglish,
            selected: currentLocale.languageCode == 'en',
            onTap: () => select(const Locale('en')),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SakinahCard(
      onTap: onTap,
      border: Border.all(
        color: selected ? colorScheme.primary : colorScheme.outlineVariant,
        width: selected ? 1.5 : 1,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: context.textStyles.headlineSmall)),
          if (selected) Icon(Icons.check_circle, color: colorScheme.primary),
        ],
      ),
    );
  }
}
