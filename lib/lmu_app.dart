import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core_routes/config.dart';
import 'package:core_routes/home.dart';
import 'package:core_routes/launch_flow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/launch_flow.dart';

import 'nav_bar_color_setter.dart';

class LmuApp extends StatelessWidget {
  const LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = GetIt.I.get<LanguageProvider>();
    final themeProvider = GetIt.I.get<ThemeProvider>();
    final shouldShowWelcomePageNotifier = GetIt.I.get<LaunchFlowApi>().shouldShowWelcomePageNotifier;

    final routerConfig = GoRouter(
      routes: $appRoutes,
      initialLocation: const HomeMainRoute().location,
      refreshListenable: shouldShowWelcomePageNotifier,
      redirect: (context, state) async {
        if (shouldShowWelcomePageNotifier.value == true) {
          return const LaunchFlowWelcomeRoute().location;
        }
        return null;
      },
    );
    return ListenableBuilder(
      listenable: languageProvider,
      builder: (context, _) => ListenableBuilder(
        listenable: themeProvider,
        builder: (context, _) {
          return MaterialApp.router(
            localizationsDelegates: LmuLocalizations.localizationsDelegates,
            supportedLocales: LmuLocalizations.supportedLocales,
            locale: languageProvider.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfig,
            title: "LMU Students",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            builder: (context, child) {
              AppUpdateNavigator.router = routerConfig;

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
}
