import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/explore_page.dart';
import '../pages/explore_search_page.dart';

part 'explore_routes.g.dart';

@TypedStatefulShellBranch<ExploreData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ExploreMainRoute>(
      path: '/explore',
      routes: [
        TypedGoRoute<ExploreSearchRoute>(
          path: 'search',
        ),
      ],
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

class ExploreSearchRoute extends GoRouteData {
  const ExploreSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ExploreSearchPage();
}
