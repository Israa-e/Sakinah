import 'package:go_router/go_router.dart';

import 'screens/dhikr_counter_screen.dart';
import 'screens/dhikr_screen.dart';

/// Dhikr tab: adhkar sanctuary + tasbeeh counter.
abstract final class DhikrPaths {
  static const root = '/dhikr';

  /// Tasbeeh counter for one bundled dhikr item (by its stable key).
  static String counter(String dhikrKey) => '/dhikr/counter/$dhikrKey';
}

/// Routes for this feature's shell branch. The first route is the tab root.
final List<RouteBase> dhikrRoutes = [
  GoRoute(
    path: DhikrPaths.root,
    builder: (context, state) => const DhikrScreen(),
    routes: [
      GoRoute(
        path: 'counter/:key',
        builder: (context, state) =>
            DhikrCounterScreen(dhikrKey: state.pathParameters['key'] ?? ''),
      ),
    ],
  ),
];
