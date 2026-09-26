import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../duas/domain/dua.dart';
import '../../../duas/presentation/duas_routes.dart';
import '../../../duas/presentation/providers/duas_providers.dart';
import '../../../duas/presentation/widgets/dua_cards.dart';
import '../../../duas/presentation/widgets/dua_category_chips.dart';
import '../../domain/ask_models.dart';
import '../providers/ask_conversation.dart';
import '../widgets/ask_widgets.dart';

/// Ask Sakīnah: sourced Q&A (answers come only from our backend) plus a
/// du'a sanctuary that links into the library.
class AskScreen extends ConsumerStatefulWidget {
  const AskScreen({super.key});

  @override
  ConsumerState<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends ConsumerState<AskScreen> {
  final _input = TextEditingController();
  final _focus = FocusNode();
  final _latestKey = GlobalKey();

  @override
  void dispose() {
    _input.dispose();
    _focus.dispose();
    super.dispose();
  }

  AskLanguage get _language =>
      Localizations.localeOf(context).languageCode == 'ar' ? AskLanguage.ar : AskLanguage.en;

  void _submit([String? text]) {
    final question = (text ?? _input.text).trim();
    if (question.isEmpty) return;
    final notifier = ref.read(askConversationProvider.notifier);
    if (notifier.isBusy) return;
    _input.clear();
    _focus.unfocus();
    notifier.ask(question, _language);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _latestKey.currentContext;
      if (ctx != null && ctx.mounted) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: 0.1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final configured = ref.watch(askServiceConfiguredProvider);
    final exchanges = ref.watch(askConversationProvider);
    final busy = exchanges.any((e) => e.isPending);
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AskTopBar(),
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.xxl + context.viewPadding.bottom,
                ),
                children: [
                  const AskTitleSegment(),
                  const SizedBox(height: AppSpacing.xl),
                  AskPromptCard(
                    controller: _input,
                    focusNode: _focus,
                    enabled: configured && !busy,
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AskDisclaimerBanner(text: l10n.askDisclaimer),
                  const SizedBox(height: AppSpacing.xl),
                  if (!configured)
                    AskUnavailableCard(onBrowseDuas: () => context.push(DuasPaths.library))
                  else
                    for (var i = 0; i < exchanges.length; i++) ...[
                      KeyedSubtree(
                        key: i == exchanges.length - 1 ? _latestKey : ValueKey(exchanges[i].id),
                        child: AskExchangeView(
                          exchange: exchanges[i],
                          onRetry: () => ref.read(askConversationProvider.notifier).retry(exchanges[i].id),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  const _DuaSanctuary(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The mockup's "Explore du'as" + featured du'a section.
class _DuaSanctuary extends ConsumerWidget {
  const _DuaSanctuary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final featured = ref.watch(featuredDuaProvider).valueOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.askExploreDuasTitle,
                style: context.textStyles.titleMedium?.copyWith(color: context.colors.primary),
              ),
            ),
            Text(
              l10n.askCollections(DuaCategory.values.length),
              style: context.textStyles.labelSmall?.copyWith(color: context.colors.secondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        DuaCategoryChips(
          selected: null,
          padding: EdgeInsets.zero,
          onSelected: (c) => context.push(
            c == null ? DuasPaths.library : DuasPaths.libraryCategory(c.name),
          ),
        ),
        if (featured != null) ...[
          const SizedBox(height: AppSpacing.lg),
          FeaturedDuaCard(dua: featured, eyebrow: l10n.askFeaturedDuaLabel),
        ],
        const SizedBox(height: AppSpacing.md),
        SakinahOutlinedButton(
          label: l10n.askViewLibrary,
          icon: Icons.auto_stories_outlined,
          onPressed: () => context.push(DuasPaths.library),
        ),
      ],
    );
  }
}
