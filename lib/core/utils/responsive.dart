import 'package:flutter/widgets.dart';

/// Breakpoints for Sakīnah's responsive layouts. Use [ScreenSizeX.breakpoint]
/// instead of ad-hoc `MediaQuery` math scattered through the widget tree.
enum Breakpoint { small, normal, large, tablet }

abstract final class AppBreakpoints {
  static const double small = 360;
  static const double normal = 400;
  static const double large = 600;
  static const double tablet = 900;
}

extension ScreenSizeX on BuildContext {
  Breakpoint get breakpoint {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= AppBreakpoints.tablet) return Breakpoint.tablet;
    if (width >= AppBreakpoints.large) return Breakpoint.large;
    if (width >= AppBreakpoints.normal) return Breakpoint.normal;
    return Breakpoint.small;
  }

  bool get isTablet => breakpoint == Breakpoint.tablet;

  /// Picks a value by current breakpoint, falling back to the next-smaller
  /// value when one isn't provided for the current size.
  T responsive<T>({
    required T small,
    T? normal,
    T? large,
    T? tablet,
  }) {
    return switch (breakpoint) {
      Breakpoint.tablet => tablet ?? large ?? normal ?? small,
      Breakpoint.large => large ?? normal ?? small,
      Breakpoint.normal => normal ?? small,
      Breakpoint.small => small,
    };
  }
}
