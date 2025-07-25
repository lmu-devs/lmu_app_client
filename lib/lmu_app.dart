import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'nav_bar_color_setter.dart';
import 'notification_handler.dart';
import 'router_config.dart';

class LmuApp extends StatelessWidget {
  const LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = GetIt.I.get<LanguageProvider>();
    final themeProvider = GetIt.I.get<ThemeProvider>();

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
            routerConfig: LmuRouterConfig.router,
            title: "LMU Students",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            builder: (context, child) => NotificationsHandler(
              child: FToastBuilder()(
                context,
                Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const NavigationBarColorSetter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
