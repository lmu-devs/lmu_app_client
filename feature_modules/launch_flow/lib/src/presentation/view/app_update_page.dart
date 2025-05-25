import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

class AppUpdatePage extends StatelessWidget {
  const AppUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      getPngAssetTheme('assets/app_icon'),
                      package: 'home',
                      semanticLabel: 'App Icon',
                      height: LmuSizes.size_64,
                      width: LmuSizes.size_64,
                    ),
                    const SizedBox(height: LmuSizes.size_20),
                    LmuText.h1(context.locals.app.appUpdateTitle, textAlign: TextAlign.center),
                    const SizedBox(height: LmuSizes.size_8),
                    LmuText.body(
                      context.locals.app.appUpdateIntro,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    LmuText.body(
                      context.locals.app.appUpdateDescription,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: LmuSizes.size_64),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuButton(
                title: context.locals.app.appUpdateButton,
                showFullWidth: true,
                size: ButtonSize.large,
                onTap: () => LmuUrlLauncher.launchWebsite(
                  url: LmuDevStrings.shareAppUrl,
                  context: context,
                  mode: LmuUrlLauncherMode.externalApplication,
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
            ],
          ),
        ),
      ),
    );
  }
}
