import 'package:core/routes.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';
import 'package:provider/provider.dart';

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
              pageBuilder: (context, state) {
                final colorScheme = Theme.of(context).colorScheme;

                final colors = context.colors;

                return NoTransitionPage(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TestColors(
                            color1: colors.neutralColors.backgroundColors.base,
                            color2: colorScheme.onBackground,
                          ),
                          TestColors(
                            color1: colorScheme.primary,
                            color2: colorScheme.onPrimary,
                          ),
                          TestColors(
                            color1: colorScheme.secondary,
                            color2: colorScheme.onSecondary,
                          ),
                          TestColors(
                            color1: colorScheme.tertiary,
                            color2: colorScheme.onTertiary,
                          ),
                          TestColors(
                            color1: colorScheme.surface,
                            color2: colorScheme.onSurface,
                          ),
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .setThemeMode(ThemeMode.light) // For dark theme
                            },
                            child: const Text('Light'),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .setThemeMode(ThemeMode.dark) // For light theme
                            },
                            child: const Text('Dark'),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .setThemeMode(ThemeMode.system) // For system theme
                            },
                            child: const Text('System'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
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

class TestColors extends StatelessWidget {
  const TestColors({
    required this.color1,
    required this.color2,
    super.key,
  });

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          color: color1,
        ),
        Container(
          width: 25,
          height: 25,
          color: color2,
        ),
      ],
    );
  }
}
