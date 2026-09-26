import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/states.dart';
import '../../domain/ask_models.dart';
import '../../domain/ask_repository.dart';
import '../providers/ask_conversation.dart';

/// Rounded-3xl "sanctuary" container used by the Ask cards.
BoxDecoration askCardDecoration(BuildContext context) => BoxDecoration(
      color: context.colors.surfaceContainerLowest,
      borderRadius: AppRadius.xLargeAll,
      border: Border.all(color: context.palette.cardBorder),
      boxShadow: context.palette.whisperShadow,
    );

class AskTopBar extends StatelessWidget {
  const AskTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.xs, AppSpacing.xs, AppSpacing.lg, AppSpacing.xs),
      color: colors.surface,
      child: Row(
        children: [
          IconButton(
            tooltip: context.l10n.back,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.spa, color: colors.primary),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.appName,
                  style: context.textStyles.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  context.l10n.askTopBarSubtitle,
                  style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AskTitleSegment extends StatelessWidget {
  const AskTitleSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, size: 20, color: context.palette.gold),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                context.l10n.askTitle,
                style: context.textStyles.headlineLarge?.copyWith(color: context.colors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          context.l10n.askSubtitle,
          style: context.textStyles.bodySmall?.copyWith(color: context.colors.secondary),
        ),
      ],
    );
  }
}

/// Input capsule + suggested questions.
class AskPromptCard extends StatelessWidget {
  const AskPromptCard({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final void Function([String? text]) onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final suggestions = [
      (Icons.chat_bubble_outline, l10n.askSuggestionAnxiety),
      (Icons.menu_book, l10n.askSuggestionAyah),
      (Icons.schedule, l10n.askSuggestionFasting),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: askCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.askKnowledgeEyebrow.toUpperCase(),
                  style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
                ),
              ),
              _Pill(
                leading: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: colors.surfaceTint, shape: BoxShape.circle),
                ),
                label: l10n.askVerifiedSources,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.sm, 6, 6, 6),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow.withValues(alpha: 0.7),
              borderRadius: AppRadius.largeAll,
              border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 20, color: colors.surfaceTint),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: TextField(
                    key: const Key('ask-input'),
                    controller: controller,
                    focusNode: focusNode,
                    enabled: enabled,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSubmit(),
                    style: context.textStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: l10n.askInputHint,
                      hintStyle: context.textStyles.bodyMedium?.copyWith(color: colors.secondary),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: false,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Tooltip(
                  message: l10n.askSend,
                  child: Material(
                    color: enabled ? context.palette.hero : colors.surfaceContainerHighest,
                    shape: const CircleBorder(),
                    child: InkWell(
                      key: const Key('ask-send'),
                      customBorder: const CircleBorder(),
                      onTap: enabled ? onSubmit : null,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.arrow_upward,
                          size: 20,
                          color: enabled ? context.palette.onHero : colors.outline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.askSuggestedTitle,
            style: context.textStyles.labelSmall?.copyWith(color: colors.secondary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final (icon, text) in suggestions)
                ActionChip(
                  avatar: Icon(icon, size: 14, color: context.palette.gold),
                  label: Text(text),
                  labelStyle: context.textStyles.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  backgroundColor: colors.surfaceContainerLow,
                  side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.3)),
                  shape: const StadiumBorder(),
                  onPressed: enabled ? () => onSubmit(text) : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.leading});

  final String label;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 6)],
          Text(label, style: context.textStyles.labelSmall?.copyWith(color: colors.secondary)),
        ],
      ),
    );
  }
}

class AskDisclaimerBanner extends StatelessWidget {
  const AskDisclaimerBanner({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppRadius.mediumAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 18, color: colors.secondary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(text, style: context.textStyles.bodySmall?.copyWith(color: colors.secondary)),
          ),
        ],
      ),
    );
  }
}

/// Calm, honest state when no backend is configured for this build.
class AskUnavailableCard extends StatelessWidget {
  const AskUnavailableCard({required this.onBrowseDuas, super.key});

  final VoidCallback onBrowseDuas;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      key: const Key('ask-unavailable'),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: askCardDecoration(context),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.secondaryContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.hourglass_empty, color: colors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.askUnavailableTitle,
            style: context.textStyles.titleMedium?.copyWith(color: colors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.l10n.askUnavailableMessage,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          SakinahButton(
            label: context.l10n.askBrowseDuas,
            icon: Icons.auto_stories_outlined,
            expand: false,
            onPressed: onBrowseDuas,
          ),
        ],
      ),
    );
  }
}

/// A question bubble followed by its answer / loading / failure card.
class AskExchangeView extends StatelessWidget {
  const AskExchangeView({required this.exchange, required this.onRetry, super.key});

  final AskExchange exchange;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final answer = exchange.answer;
    final failure = exchange.failure;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _QuestionBubble(text: exchange.question),
        const SizedBox(height: AppSpacing.md),
        if (answer != null)
          AskAnswerCard(answer: answer)
        else if (failure != null)
          _FailureCard(failure: failure, onRetry: onRetry)
        else
          const _PendingCard(),
      ],
    );
  }
}

class _QuestionBubble extends StatelessWidget {
  const _QuestionBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: palette.hero,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(AppRadius.xLarge),
              topEnd: Radius.circular(AppRadius.xLarge),
              bottomStart: Radius.circular(AppRadius.xLarge),
              bottomEnd: Radius.circular(AppRadius.small),
            ).resolve(Directionality.of(context)),
          ),
          child: Semantics(
            label: context.l10n.askYou,
            child: Text(text, style: context.textStyles.bodyMedium?.copyWith(color: palette.onHero)),
          ),
        ),
      ),
    );
  }
}

class _AnswerHeader extends StatelessWidget {
  const _AnswerHeader({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colors.secondaryContainer.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.psychology_alt, size: 18, color: colors.primaryContainer),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.askAnswerTitle,
                style: context.textStyles.titleMedium?.copyWith(color: colors.primary),
              ),
              Text(subtitle, style: context.textStyles.bodySmall?.copyWith(color: colors.secondary)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Renders a backend answer verbatim with its sources and disclaimer.
class AskAnswerCard extends StatelessWidget {
  const AskAnswerCard({required this.answer, super.key});

  final AskAnswer answer;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: askCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AnswerHeader(subtitle: l10n.askAnswerSubtitle),
          const SizedBox(height: AppSpacing.sm),
          Divider(height: 1, color: colors.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: AppSpacing.md),
          SelectableText(
            answer.answer,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurface, height: 1.6),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.askSourcesTitle,
            style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
          ),
          const SizedBox(height: AppSpacing.xs),
          if (answer.sources.isEmpty)
            Text(
              l10n.askNoSources,
              style: context.textStyles.bodySmall?.copyWith(color: colors.error),
            )
          else
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final s in answer.sources) AskSourceChip(source: s),
              ],
            ),
          const SizedBox(height: AppSpacing.md),
          AskDisclaimerBanner(text: answer.disclaimer ?? l10n.askDisclaimer),
        ],
      ),
    );
  }
}

class AskSourceChip extends StatelessWidget {
  const AskSourceChip({required this.source, super.key});

  final AskSource source;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final label = switch (source.type) {
      AskSourceType.quran => l10n.askSourceQuran(source.reference),
      AskSourceType.hadith => l10n.askSourceHadith(source.reference),
      AskSourceType.other => source.reference,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withValues(alpha: 0.4),
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 16, color: colors.surfaceTint),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: context.textStyles.labelSmall?.copyWith(color: colors.onSecondaryFixedVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingCard extends StatelessWidget {
  const _PendingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('ask-pending'),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: askCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AnswerHeader(subtitle: context.l10n.askThinking),
          const SizedBox(height: AppSpacing.lg),
          const SkeletonLoader(height: 14),
          const SizedBox(height: AppSpacing.xs),
          const SkeletonLoader(height: 14),
          const SizedBox(height: AppSpacing.xs),
          const SkeletonLoader(height: 14, width: 180),
        ],
      ),
    );
  }
}

class _FailureCard extends StatelessWidget {
  const _FailureCard({required this.failure, required this.onRetry});

  final AppFailure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final (icon, message) = switch (failure) {
      _ when isAskServiceNotConfigured(failure) => (Icons.hourglass_empty, l10n.askUnavailableTitle),
      NetworkFailure() => (Icons.cloud_off_outlined, l10n.askErrorOffline),
      TimeoutFailure() => (Icons.timer_off_outlined, l10n.askErrorTimeout),
      ServerFailure() => (Icons.error_outline, l10n.askErrorServer),
      _ => (Icons.error_outline, l10n.askErrorGeneric),
    };
    return Container(
      key: const Key('ask-failure'),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: askCardDecoration(context),
      child: Column(
        children: [
          Icon(icon, color: colors.onSurfaceVariant, size: 32),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          if (!isAskServiceNotConfigured(failure)) ...[
            const SizedBox(height: AppSpacing.md),
            SakinahOutlinedButton(label: l10n.retry, onPressed: onRetry, expand: false),
          ],
        ],
      ),
    );
  }
}
