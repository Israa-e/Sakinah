import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_app_bar.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/dhikr_counter_controller.dart';
import '../dhikr_routes.dart';
import '../providers/dhikr_providers.dart';
import '../widgets/dhikr_category_x.dart';
import '../widgets/tasbeeh_ring.dart';

/// Tasbeeh counter for one catalog item.
class DhikrCounterScreen extends ConsumerWidget {
  const DhikrCounterScreen({required this.dhikrKey, super.key});

  final String dhikrKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final item = ref.watch(dhikrItemProvider(dhikrKey));
    if (item == null) {
      return Scaffold(
        appBar: const SakinahAppBar(showBackButton: true),
        body: EmptyState(title: l10n.dhikrNotFound, icon: Icons.search_off),
      );
    }

    final siblings = ref
        .watch(dhikrCatalogProvider)
        .where((i) => i.category == item.category)
        .toList();
    final index = siblings.indexOf(item);
    final next = item.category.isSequence && index >= 0 && index + 1 < siblings.length
        ? siblings[index + 1]
        : null;

    return Scaffold(
      appBar: SakinahAppBar(title: item.category.label(l10n), showBackButton: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            SakinahCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                children: [
                  CardEyebrow(item.category.label(l10n), icon: item.category.icon),
                  const SizedBox(height: AppSpacing.md),
                  _DhikrText(item: item),
                  const SizedBox(height: AppSpacing.xl),
                  _CounterRing(dhikrKey: dhikrKey),
                  const SizedBox(height: AppSpacing.md),
                  _CompletionMessage(dhikrKey: dhikrKey),
                  const SizedBox(height: AppSpacing.md),
                  _Controls(dhikrKey: dhikrKey),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (next != null)
              _NextCard(next: next)
            else if (item.category.isSequence)
              SakinahOutlinedButton(
                label: l10n.dhikrBackToList,
                icon: Icons.format_list_bulleted,
                onPressed: () => context.canPop() ? context.pop() : context.go(DhikrPaths.root),
              ),
          ],
        ),
      ),
    );
  }
}

class _DhikrText extends StatelessWidget {
  const _DhikrText({required this.item});

  final DhikrItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final typography = context.sakinahTypography;
    final arabicStyle = item.arabic.length > 60 ? typography.quranTextMedium : typography.quranText;
    return Column(
      children: [
        Text(
          item.arabic,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: arabicStyle.copyWith(color: context.colors.primary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            color: context.colors.tertiaryFixedDim.withValues(alpha: 0.6),
            borderRadius: AppRadius.pillAll,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          item.transliteration,
          textAlign: TextAlign.center,
          style: context.textStyles.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '“${item.translation}”',
          textAlign: TextAlign.center,
          style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_outlined, size: 14, color: context.palette.gold),
            const SizedBox(width: AppSpacing.xxs),
            Flexible(
              child: Text(
                l10n.dhikrSource(item.sourceReference),
                textAlign: TextAlign.center,
                style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Only this subtree rebuilds per tap.
class _CounterRing extends ConsumerWidget {
  const _CounterRing({required this.dhikrKey});

  final String dhikrKey;

  void _onTap(WidgetRef ref) {
    final target = ref.read(dhikrTargetProvider(dhikrKey));
    final reached = ref.read(dhikrCounterControllerProvider(dhikrKey).notifier).increment(target);
    if (ref.read(dhikrHapticsProvider)) {
      if (reached) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.lightImpact();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(dhikrCounterControllerProvider(dhikrKey).select((s) => s.count));
    final target = ref.watch(dhikrTargetProvider(dhikrKey));
    final width = MediaQuery.sizeOf(context).width;
    final size = (width - 2 * (AppSpacing.lg + AppSpacing.xl)).clamp(180.0, 260.0);
    return TasbeehRing(count: count, target: target, size: size, onTap: () => _onTap(ref));
  }
}

class _CompletionMessage extends ConsumerWidget {
  const _CompletionMessage({required this.dhikrKey});

  final String dhikrKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(dhikrTargetProvider(dhikrKey));
    final reached = ref.watch(
      dhikrCounterControllerProvider(dhikrKey).select((s) => s.count >= target),
    );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      child: reached
          ? Container(
              key: const ValueKey('reached'),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: context.colors.tertiaryFixedDim.withValues(alpha: 0.18),
                borderRadius: AppRadius.pillAll,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome_outlined, size: 16, color: context.palette.gold),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      context.l10n.dhikrTargetReached,
                      textAlign: TextAlign.center,
                      style: context.textStyles.labelMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(key: ValueKey('pending'), height: 0),
    );
  }
}

class _Controls extends ConsumerWidget {
  const _Controls({required this.dhikrKey});

  final String dhikrKey;

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.dhikrResetConfirmTitle),
        content: Text(l10n.dhikrResetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.dhikrCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.dhikrReset),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(dhikrCounterControllerProvider(dhikrKey).notifier).reset();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canUndo = ref.watch(dhikrCounterControllerProvider(dhikrKey).select((s) => s.canUndo));
    final hasCount = ref.watch(dhikrCounterControllerProvider(dhikrKey).select((s) => s.count > 0));
    final haptics = ref.watch(dhikrHapticsProvider);
    final target = ref.watch(dhikrTargetProvider(dhikrKey));

    return Row(
      children: [
        Expanded(
          child: _ControlButton(
            key: const ValueKey('dhikr-reset'),
            icon: Icons.restart_alt,
            label: l10n.dhikrReset,
            onTap: hasCount ? () => _confirmReset(context, ref) : null,
          ),
        ),
        Expanded(
          child: _ControlButton(
            key: const ValueKey('dhikr-undo'),
            icon: Icons.undo,
            label: l10n.dhikrUndo,
            onTap: canUndo
                ? ref.read(dhikrCounterControllerProvider(dhikrKey).notifier).undo
                : null,
          ),
        ),
        Expanded(
          child: _ControlButton(
            key: const ValueKey('dhikr-haptics'),
            icon: haptics ? Icons.vibration : Icons.volume_off_outlined,
            label: haptics ? l10n.dhikrHapticsOn : l10n.dhikrHapticsOff,
            tooltip: l10n.dhikrHapticsTooltip,
            selected: haptics,
            onTap: ref.read(dhikrHapticsProvider.notifier).toggle,
          ),
        ),
        Expanded(
          child: _ControlButton(
            key: const ValueKey('dhikr-target'),
            icon: Icons.tune,
            label: '$target',
            tooltip: l10n.dhikrTargetTooltip,
            onTap: ref.read(dhikrTargetProvider(dhikrKey).notifier).cycle,
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
    this.tooltip,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? tooltip;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = !enabled
        ? context.colors.onSurfaceVariant.withValues(alpha: 0.4)
        : selected
        ? context.palette.gold
        : context.colors.secondary;
    final button = InkWell(
      onTap: onTap,
      borderRadius: AppRadius.largeAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs, horizontal: AppSpacing.xxs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.labelSmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
    return Semantics(
      button: true,
      enabled: enabled,
      label: tooltip,
      child: tooltip == null ? button : Tooltip(message: tooltip, child: button),
    );
  }
}

class _NextCard extends ConsumerWidget {
  const _NextCard({required this.next});

  final DhikrItem next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    return SakinahCard(
      key: const ValueKey('dhikr-next'),
      onTap: () => context.pushReplacement(DhikrPaths.counter(next.key)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${next.targetCount}',
              style: context.textStyles.titleMedium?.copyWith(color: palette.gold),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dhikrNext(next.transliteration),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.titleMedium?.copyWith(color: context.colors.primary),
                ),
                const SizedBox(height: 2),
                Text(
                  '${l10n.dhikrTimes(next.targetCount)} • ${next.translation}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: context.colors.secondary),
        ],
      ),
    );
  }
}
