import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/explore_router.dart';

ExploreRouter get _router => GetIt.I.get<ExploreRouter>();

class ExploreData extends StatefulShellBranchData {
  const ExploreData();
}

class ExploreMainRoute extends GoRouteData {
  const ExploreMainRoute();

  static const String path = '/explore';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class ExploreSearchRoute extends GoRouteData {
  const ExploreSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildSearch(context);
}
