import 'package:core/localizations.dart';
import 'package:core/pages.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'nav_bar_color_setter.dart';
import 'routing/shell_route_data.dart';

class LmuApp extends StatelessWidget {
  LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = GetIt.I.get<LanguageProvider>();
    final themeProvider = GetIt.I.get<ThemeProvider>();
    return ListenableBuilder(
      listenable: languageProvider,
      builder: (context, _) => ListenableBuilder(
        listenable: themeProvider,
        builder: (context, _) {
          AppUpdateNavigation.router = _router;
          return MaterialApp.router(
            localizationsDelegates: LmuLocalizations.localizationsDelegates,
            supportedLocales: LmuLocalizations.supportedLocales,
            locale: languageProvider.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            title: "LMU Students",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            builder: (context, child) {
              return FToastBuilder()(
                context,
                Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const NavigationBarColorSetter(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      $shellRouteData,
      GoRoute(
        path: '/app-update',
        builder: (context, state) => const AppUpdatePage(),
      ),
    ],
    initialLocation: '/home',
  );
}
