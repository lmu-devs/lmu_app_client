import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmu_app/shell_route_data.dart';
import 'package:provider/provider.dart';

import 'global_providers.dart';

class LmuApp extends StatelessWidget {
  LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: _router,
            title: 'Lmu App',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
          );
        },
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: [$shellRouteData],
    initialLocation: '/mensa',
  );
}
