import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/dua.dart';
import '../providers/duas_providers.dart';

/// Copies the du'a (Arabic, translation and citation) and confirms calmly.
Future<void> copyDua(BuildContext context, Dua dua) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final message = context.l10n.duasCopied;
  await Clipboard.setData(ClipboardData(text: dua.toShareText()));
  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Round bookmark toggle bound to the saved state of [dua].
class DuaSaveButton extends ConsumerWidget {
  const DuaSaveButton({required this.dua, super.key, this.size = 36});

  final Dua dua;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(isDuaSavedProvider(dua.key));
    return DuaRoundIconButton(
      icon: saved ? Icons.bookmark : Icons.bookmark_border,
      tooltip: saved ? context.l10n.duasUnsaveTooltip : context.l10n.duasSaveTooltip,
      color: saved ? context.palette.gold : null,
      size: size,
      onPressed: () => ref.read(savedDuaKeysProvider.notifier).toggle(dua.key),
    );
  }
}

class DuaCopyButton extends StatelessWidget {
  const DuaCopyButton({required this.dua, super.key, this.size = 36});

  final Dua dua;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DuaRoundIconButton(
      icon: Icons.content_copy_outlined,
      tooltip: context.l10n.duasCopy,
      size: size,
      onPressed: () => copyDua(context, dua),
    );
  }
}

/// Small circular tonal icon button used in du'a action trays.
class DuaRoundIconButton extends StatelessWidget {
  const DuaRoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
    this.color,
    this.background,
    this.size = 36,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: background ?? context.colors.surfaceContainerLow,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, size: size * 0.5, color: color ?? context.colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

/// Thin line – gold diamond – thin line, as in the mockup's du'a cards.
class DuaDiamondDivider extends StatelessWidget {
  const DuaDiamondDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Container(height: 1, color: context.colors.outlineVariant.withValues(alpha: 0.4)),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Transform.rotate(
            angle: 0.785398,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: context.palette.gold.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
        line,
      ],
    );
  }
}

/// Small rounded tag (category pill / source badge).
class DuaTag extends StatelessWidget {
  const DuaTag({required this.label, super.key, this.icon, this.iconColor});

  final String label;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.secondaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: iconColor ?? context.colors.primary),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSecondaryContainer),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
