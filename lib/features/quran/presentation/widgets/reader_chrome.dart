import 'package:flutter/material.dart';

import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../providers/quran_audio_controller.dart';

/// Deep-green docked recitation player (Mishary Rashid Alafasy).
class QuranMiniPlayer extends StatelessWidget {
  const QuranMiniPlayer({
    required this.state,
    required this.onToggle,
    required this.onPrevious,
    required this.onNext,
    required this.onClose,
    super.key,
  });

  final QuranAudioState state;
  final VoidCallback onToggle;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onClose;

  static String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final ayah = state.current;
    final duration = state.duration;
    final meta = [
      if (ayah != null) l10n.ayahLabel(ayah.numberInSurah),
      if (duration != null) '${_fmt(state.position)} / ${_fmt(duration)}',
    ].join(' • ');
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 4, 10),
      decoration: BoxDecoration(
        color: palette.hero,
        borderRadius: AppRadius.cardAll,
        boxShadow: palette.heroShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.18),
                  border: Border.all(color: palette.onHeroMuted.withValues(alpha: 0.3)),
                ),
                child: Icon(Icons.record_voice_over, size: 18, color: palette.onHeroMuted),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.quranReciterName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.titleSmall?.copyWith(color: palette.onHero),
                    ),
                    Text(
                      meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.labelSmall?.copyWith(
                        color: palette.onHeroMuted,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              _PlayerIcon(
                icon: Icons.skip_previous,
                tooltip: l10n.quranPreviousAyah,
                onTap: state.hasPrevious ? onPrevious : null,
              ),
              Tooltip(
                message: state.playing ? l10n.quranPause : l10n.quranPlay,
                child: InkResponse(
                  onTap: onToggle,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: palette.heroAccent, shape: BoxShape.circle),
                    child: state.loading
                        ? Padding(
                            padding: const EdgeInsets.all(9),
                            child: CircularProgressIndicator(strokeWidth: 2, color: palette.hero),
                          )
                        : Icon(
                            state.playing ? Icons.pause : Icons.play_arrow,
                            size: 20,
                            color: palette.hero,
                          ),
                  ),
                ),
              ),
              _PlayerIcon(
                icon: Icons.skip_next,
                tooltip: l10n.quranNextAyah,
                onTap: state.hasNext ? onNext : null,
              ),
              _PlayerIcon(
                icon: Icons.close,
                tooltip: l10n.quranStopRecitation,
                onTap: onClose,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 6),
            child: ClipRRect(
              borderRadius: AppRadius.pillAll,
              child: LinearProgressIndicator(
                value: state.loading ? null : state.progress,
                minHeight: 4,
                color: palette.heroAccent,
                backgroundColor: Colors.black.withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerIcon extends StatelessWidget {
  const _PlayerIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.size = 20,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 32, height: 36),
      onPressed: onTap,
      icon: Icon(
        icon,
        size: size,
        color: onTap == null ? palette.onHeroMuted.withValues(alpha: 0.4) : palette.onHero,
      ),
    );
  }
}
