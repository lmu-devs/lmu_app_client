import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/home_router.dart';

HomeRouter get _router => GetIt.I.get<HomeRouter>();

class HomeRouteData extends StatefulShellBranchData {
  const HomeRouteData();
}

class HomeMainRoute extends GoRouteData {
  const HomeMainRoute();

  static const String path = '/home';

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      name: state.name,
      transitionDuration: const Duration(milliseconds: 600),
      child: _router.buildMain(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class LinksRoute extends GoRouteData {
  const LinksRoute();

  static const String path = 'links';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLinks(context);
}

class LinksSearchRoute extends GoRouteData {
  const LinksSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildLinksSearch(context);
}
