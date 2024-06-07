import 'package:core/routes.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routeConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => Container(),
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <GoRoute>[
            GoRoute(
              path: RouteNames.home,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Container(
                    color: context.colors.neutralColors.backgroundColors.base,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setThemeMode(
                                        ThemeMode.light) // For dark theme
                              },
                              child: const Text('Light'),
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setThemeMode(
                                        ThemeMode.dark) // For light theme
                              },
                              child: const Text('Dark'),
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setThemeMode(
                                        ThemeMode.system) // For system theme
                              },
                              child: const Text('System'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        //CSS: inset 0px 4px 6px rgba(8, 56, 73, 0.5)
                        Container(
                          child: const Center(
                              child: const Text('Geeks for Geeks')),
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
                              stops: [0.0, .1],
                              colors: [
                                context.colors.neutralColors.backgroundColors.strongColors.base,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
        selectedItemColor:
            context.colors.neutralColors.textColors.strongColors.base,
        unselectedItemColor:
            context.colors.neutralColors.textColors.strongColors.disabled,
        backgroundColor: context.colors.neutralColors.backgroundColors.base,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Mensa',
          ),
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
