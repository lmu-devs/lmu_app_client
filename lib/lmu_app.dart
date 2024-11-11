import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            localizationsDelegates: LmuLocalizations.localizationsDelegates,
            supportedLocales: LmuLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            title: "Muc Students",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            builder: FToastBuilder(),
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
