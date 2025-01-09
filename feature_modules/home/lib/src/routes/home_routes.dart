import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

part 'home_routes.g.dart';

@TypedStatefulShellBranch<HomeData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeMainRoute>(
      path: '/home',
    ),
  ],
)
class HomeData extends StatefulShellBranchData {
  const HomeData();
}

class HomeMainRoute extends GoRouteData {
  const HomeMainRoute({this.hasDeletedUserApiKey = false});

  final bool? hasDeletedUserApiKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage(hasDeletedUserApiKey: hasDeletedUserApiKey ?? false);
  }
}
