import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global_providers.dart';
import 'router_config.dart';

class LmuApp extends StatelessWidget {
  const LmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: routeConfig,
            title: 'LMU App',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
          );
        },
      ),
    );
  }
}
