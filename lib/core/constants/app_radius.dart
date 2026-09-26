import 'package:flutter/widgets.dart';

/// Sakīnah's corner-radius scale. Never hardcode a `BorderRadius` value — pick from here.
abstract final class AppRadius {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;

  /// Primary content cards (`rounded-2xl` in the design → 20px).
  static const double card = 20;
  static const double xLarge = 24;

  /// Hero & daily surah containers (`rounded-3xl` → 28px).
  static const double hero = 28;
  static const double pill = 999;

  static const BorderRadius smallAll = BorderRadius.all(Radius.circular(small));
  static const BorderRadius mediumAll = BorderRadius.all(Radius.circular(medium));
  static const BorderRadius largeAll = BorderRadius.all(Radius.circular(large));
  static const BorderRadius cardAll = BorderRadius.all(Radius.circular(card));
  static const BorderRadius xLargeAll = BorderRadius.all(Radius.circular(xLarge));
  static const BorderRadius heroAll = BorderRadius.all(Radius.circular(hero));
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
}
