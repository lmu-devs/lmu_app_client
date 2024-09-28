import 'package:core/routes.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';
import 'package:settings/settings.dart';
import 'package:wunschkonzert/wunschkonzert.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routeConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.mensa,
  errorBuilder: (context, state) => Container(),
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
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
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.wunschkonzert,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: WunschkonzertMainRoute(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.settings,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsMainRoute(),
              ),
              routes: [
                GoRoute(
                  path: RouteNames.settingsApperance.asSubroute,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SettingsApperanceRoute(),
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

class _WeirdAssButton extends StatelessWidget {
  const _WeirdAssButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
          ),
          BoxShadow(
            offset: const Offset(0, -4),
            color: context.colors.neutralColors.backgroundColors.base,
            // spreadRadius: -5.0,
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, .1],
          colors: [
            context.colors.neutralColors.backgroundColors.strongColors.base,
            Colors.transparent,
          ],
        ),
      ),
      child: const Center(
        child: Text('Grandmas with Drip'),
      ),
    );
  }
}

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colors.neutralColors.borderColors.seperatorLight,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          height: 64,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (int index) => _onTap(index),
          backgroundColor: context.colors.neutralColors.backgroundColors.base,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(LucideIcons.utensils),
              label: 'Mensa',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.party_popper),
              label: 'Wunschkonzert',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.circle_ellipsis),
              label: 'Settings',
            ),
          ],
        ),
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
