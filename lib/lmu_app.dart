import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'registry/global_providers.dart';
import 'routing/shell_route_data.dart';

class LmuApp extends StatelessWidget {
  LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            title: 'Lmu App',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
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
