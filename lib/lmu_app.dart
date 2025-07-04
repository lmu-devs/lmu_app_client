import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/launch_flow.dart';

class LmuApp extends StatelessWidget {
  const LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = GetIt.I.get<LanguageProvider>();
    final themeProvider = GetIt.I.get<ThemeProvider>();
    final launchFlowApi = GetIt.I.get<LaunchFlowApi>();

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
            routerConfig: GoRouter(
              routes: $appRoutes,
              initialLocation: launchFlowApi.initialLocation,
            ),
            title: "LMU Students",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            builder: (context, child) => FToastBuilder()(context, child),
          );
        },
      ),
    );
  }
}
