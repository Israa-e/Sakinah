import 'package:go_router/go_router.dart';

import 'screens/journey_screen.dart';

/// Journey tab: streaks, goals and the spiritual garden.
abstract final class JourneyPaths {
  static const root = '/journey';
}

/// Routes for this feature's shell branch. The first route is the tab root.
final List<RouteBase> journeyRoutes = [
  GoRoute(
    path: JourneyPaths.root,
    builder: (context, state) => const JourneyScreen(),
  ),
];
