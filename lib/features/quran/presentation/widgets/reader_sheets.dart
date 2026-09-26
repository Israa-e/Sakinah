import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/widgets/sakinah_bottom_sheet.dart';
import '../../../../core/widgets/sakinah_button.dart';
import '../../data/drift_quran_repository.dart';
import '../../data/quran_text.dart';
import '../../domain/quran_models.dart';
import '../providers/quran_providers.dart';

Future<void> showQuranTextSizeSheet(BuildContext context) {
  return showSakinahBottomSheet<void>(context: context, builder: (_) => const _TextSizeSheet());
}

class _TextSizeSheet extends ConsumerWidget {
  const _TextSizeSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scale = ref.watch(quranTextScaleProvider);
    final notifier = ref.read(quranTextScaleProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(l10n.quranTextSize, style: context.textStyles.titleLarge)),
            TextButton(
              onPressed: () => notifier.set(QuranTextScale.defaultScale),
              child: Text(l10n.quranTextSizeReset),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          QuranText.bismillah,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: context.sakinahTypography.quranText.copyWith(
            fontSize: 26 * scale,
            color: context.colors.primary,
          ),
        ),
        Row(
          children: [
            Icon(Icons.text_decrease, size: 18, color: context.colors.onSurfaceVariant),
            Expanded(
              child: Slider(
                value: scale,
                min: QuranTextScale.min,
                max: QuranTextScale.max,
                divisions: 8,
                label: '${(scale * 100).round()}%',
                onChanged: notifier.set,
              ),
            ),
            Icon(Icons.text_increase, size: 22, color: context.colors.onSurfaceVariant),
          ],
        ),
      ],
    );
  }
}

/// Opens the reflection composer for [ayah]; resolves `true` once saved.
Future<bool?> showReflectSheet(BuildContext context, {required Surah surah, required Ayah ayah}) {
  return showSakinahBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _ReflectSheet(surah: surah, ayah: ayah),
  );
}

class _ReflectSheet extends ConsumerStatefulWidget {
  const _ReflectSheet({required this.surah, required this.ayah});

  final Surah surah;
  final Ayah ayah;

  @override
  ConsumerState<_ReflectSheet> createState() => _ReflectSheetState();
}

class _ReflectSheetState extends ConsumerState<_ReflectSheet> {
  final _controller = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    setState(() => _saving = true);
    await ref
        .read(quranRepositoryProvider)
        .saveReflection(
          body: body,
          surahNumber: widget.ayah.surahNumber,
          ayahNumber: widget.ayah.numberInSurah,
        );
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.quranReflectTitle, style: context.textStyles.titleLarge),
          Text(
            l10n.quranSurahCitation(widget.surah.nameEn, widget.ayah.reference),
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.outline),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.ayah.textAr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: context.sakinahTypography.quranTextMedium.copyWith(
              fontSize: 19,
              color: context.colors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controller,
                  autofocus: true,
                  minLines: 4,
                  maxLines: 8,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: l10n.quranReflectHint),
                ),
                const SizedBox(height: AppSpacing.md),
                SakinahButton(
                  label: l10n.quranReflectSave,
                  icon: Icons.edit_note,
                  isLoading: _saving,
                  onPressed: value.text.trim().isEmpty || _saving ? null : _save,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
