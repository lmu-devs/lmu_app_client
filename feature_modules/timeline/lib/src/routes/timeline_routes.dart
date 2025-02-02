import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'timeline_routes.g.dart';

@TypedGoRoute<TimelineMainRoute>(
  path: '/timeline',
  routes: <TypedGoRoute<GoRouteData>>[],
)
class TimelineMainRoute extends GoRouteData {
  const TimelineMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TimelinePage();
}
