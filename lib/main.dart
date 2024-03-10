import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mensa/mensa.dart';

void main() {
  runApp(const MyApp());
}

final routeConfig = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      routes: [
        GoRoute(
          path: RouteNames.homeRoute,
          builder: (context, state) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  context.go(
                    '/details',
                    extra: MensaRouteArguments(),
                  );
                },
                child: Container(
                  color: Colors.green,
                ),
              ),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.detailsRoute,
              builder: (context, state) {
                return MensaModule(
                  arguments: state.extra as MensaRouteArguments,
                );
              },
            ),
          ],
        ),
      ],
      builder: (context, state, child) => Container(
        child: child,
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routeConfig,
      title: 'LMU App',
    );
  }
}
