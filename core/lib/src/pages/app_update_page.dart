import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/src/core.dart';
import 'package:core/src/utils/lmu_url_launcher.dart';
import 'package:core/src/utils/themed_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppUpdatePage extends StatelessWidget {
  const AppUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      getPngAssetTheme('lib/assets/app_icon'),
                      package: 'core',
                      semanticLabel: 'App Icon',
                      height: LmuSizes.size_64,
                      width: LmuSizes.size_64,
                    ),
                    const SizedBox(height: LmuSizes.size_20),
                    LmuText.h1(context.locals.app.appUpdateTitle),
                    const SizedBox(height: LmuSizes.size_16),
                    LmuText.body(
                      context.locals.app.appUpdateIntro,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                    const SizedBox(height: LmuSizes.size_8),
                    LmuText.body(
                      context.locals.app.appUpdateDescription,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                    const SizedBox(height: LmuSizes.size_64),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LmuButton(
                  title: context.locals.app.appUpdateButton,
                  showFullWidth: true,
                  size: ButtonSize.large,
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    url: LmuDevStrings.shareAppUrl,
                    context: context,
                    mode: LmuUrlLauncherMode.externalApplication,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppUpdateNavigation {
  static late GoRouter router;

  static void popAllAndNavigate() {
    router.go('/app-update');
  }
}

