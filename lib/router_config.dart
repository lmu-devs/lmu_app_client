import 'package:core/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routeConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => Container(),
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <GoRoute>[
            GoRoute(
              path: RouteNames.home,
              pageBuilder: (context, state) => NoTransitionPage(
                child: Container(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.mensa,
              pageBuilder: (context, state) => NoTransitionPage(
                child: MensaMainRoute(
                  arguments: state.extra,
                ),
              ),
              routes: <GoRoute>[
                GoRoute(
                  path: RouteNames.mensaDetails.asSubroute,
                  builder: (context, state) => MensaDetailsRoute(
                    arguments: state.extra,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Mensa'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(index),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
