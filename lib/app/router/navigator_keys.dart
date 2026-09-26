import 'package:flutter/widgets.dart';

/// The app's root navigator. Routes that set it as `parentNavigatorKey`
/// render above the tab shell (full screen, no bottom navigation bar).
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
