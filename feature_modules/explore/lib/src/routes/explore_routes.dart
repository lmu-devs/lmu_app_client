import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'explore_routes.g.dart';

@TypedStatefulShellBranch<ExploreData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ExploreMainRoute>(
      path: '/explore',
    ),
  ],
)
class ExploreData extends StatefulShellBranchData {
  const ExploreData();
}

class ExploreMainRoute extends GoRouteData {
  const ExploreMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ExplorePage();
}
