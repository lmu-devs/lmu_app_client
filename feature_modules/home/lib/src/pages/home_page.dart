import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';

import '../views/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.home.tabTitle,
      largeTitleTrailingWidget: GestureDetector(
        onTap: () {
          GetIt.I.get<SettingsService>().navigateToSettings(context);
        },
        child: const LmuIcon(icon: LucideIcons.microwave, size: 28),
      ),
      body: const HomeSuccessView(),
    );
  }
}
