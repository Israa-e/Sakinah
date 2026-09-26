import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/storage/app_database.dart';
import '../../../../core/widgets/sakinah_app_bar.dart';
import '../../../../core/widgets/sakinah_card.dart';
import '../../../../core/widgets/states.dart';
import '../../../quran/presentation/quran_routes.dart';
import '../../data/reflections_repository.dart';

/// "My reflections": every saved reflection, newest first. Tapping one that
/// is tied to an ayah opens the reader there.
class ReflectionsScreen extends ConsumerWidget {
  const ReflectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final reflections = ref.watch(reflectionsListProvider);

    return Scaffold(
      appBar: SakinahAppBar(title: l10n.profileReflections, showBackButton: true),
      body: reflections.when(
        loading: () => const LoadingState(),
        error: (_, _) => ErrorState(
          message: l10n.errorGeneric,
          retryLabel: l10n.retry,
          onRetry: () => ref.invalidate(reflectionsListProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.edit_note,
              title: l10n.profileReflectionsEmptyTitle,
              message: l10n.profileReflectionsEmptyBody,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) => _ReflectionCard(reflection: items[i]),
          );
        },
      ),
    );
  }
}

class _ReflectionCard extends ConsumerWidget {
  const _ReflectionCard({required this.reflection});

  final Reflection reflection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.colors;
    final surah = reflection.surahNumber;
    final ayah = reflection.ayahNumber;
    final reference = surah == null
        ? null
        : ayah == null
        ? l10n.profileReflectionSurahRef(surah)
        : l10n.profileReflectionAyahRef(surah, ayah);
    final date = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(reflection.createdAt.toLocal());

    return SakinahCard(
      key: ValueKey('reflection-${reflection.id}'),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.xxs,
        AppSpacing.md,
      ),
      onTap: surah == null ? null : () => context.go(QuranPaths.surah(surah, ayah: ayah)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (reference != null) CardEyebrow(reference, icon: Icons.menu_book),
                    Text(
                      date,
                      style: context.textStyles.labelSmall?.copyWith(color: colors.outline),
                    ),
                  ],
                ),
              ),
              IconButton(
                key: ValueKey('delete-reflection-${reflection.id}'),
                tooltip: l10n.profileDelete,
                icon: Icon(Icons.delete_outline, color: colors.onSurfaceVariant),
                onPressed: () => _confirmDelete(context, ref),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: Text(
              reflection.body,
              style: context.textStyles.bodyMedium?.copyWith(color: colors.onSurface),
            ),
          ),
          if (reflection.mood != null && reflection.mood!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              reflection.mood!,
              style: context.textStyles.labelSmall?.copyWith(color: context.palette.gold),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profileReflectionDeleteTitle),
        content: Text(l10n.profileReflectionDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.profileCancel),
          ),
          TextButton(
            key: const ValueKey('confirm-delete-reflection'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: context.colors.error),
            child: Text(l10n.profileDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(reflectionsRepositoryProvider).delete(reflection.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileReflectionDeleted)));
    }
  }
}
