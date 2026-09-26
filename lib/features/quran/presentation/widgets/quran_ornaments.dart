import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/sakinah_palette.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../data/quran_text.dart';
import '../../domain/quran_models.dart';

/// Gold octagram-style surah number badge for index rows.
class SurahNumberBadge extends StatelessWidget {
  const SurahNumberBadge({required this.number, super.key, this.size = 40});

  final int number;
  final double size;

  @override
  Widget build(BuildContext context) {
    final gold = context.palette.gold;
    final border = Border.all(color: gold.withValues(alpha: 0.45), width: 1.2);
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(6)),
          ),
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: size * 0.78,
              height: size * 0.78,
              decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(6)),
            ),
          ),
          Text(
            '$number',
            style: context.textStyles.labelMedium?.copyWith(
              color: gold,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// `﴿١٤٣﴾` ayah-end marker in gold.
class AyahGlyph extends StatelessWidget {
  const AyahGlyph({required this.number, super.key, this.fontSize = 16});

  final int number;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      QuranText.ayahGlyph(number),
      textDirection: TextDirection.rtl,
      style: context.sakinahTypography.quranTextMedium.copyWith(
        fontSize: fontSize,
        height: 1.2,
        color: context.palette.gold,
      ),
    );
  }
}

String revelationLabel(BuildContext context, RevelationType type) =>
    type == RevelationType.medinan ? context.l10n.quranMedinan : context.l10n.quranMeccan;
