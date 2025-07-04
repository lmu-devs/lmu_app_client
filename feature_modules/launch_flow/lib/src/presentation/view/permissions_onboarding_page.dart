import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/launch_flow_page_header.dart';
import '../viewmodel/permissions_onboarding_page_driver.dart';

class PermissionsOnboardingPage
    extends DrivableWidget<PermissionsOnboardingPageDriver> {
  PermissionsOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LmuButton(
                title: driver.doneButtonText,
                showFullWidth: true,
                size: ButtonSize.large,
                onTap: driver.onDonePressed,
              ),
              const SizedBox(height: LmuSizes.size_12),
              LmuButton(
                emphasis: ButtonEmphasis.tertiary,
                title: driver.skipButtonText,
                showFullWidth: true,
                size: ButtonSize.large,
                onTap: driver.onSkipPressed,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LaunchFlowPageHeader(
                    title: driver.permissionsTitle,
                    description: driver.permissionsDescription,
                  ),
                  Image.asset(
                    "assets/notification.png",
                    package: "launch_flow",
                    height: 250,
                  ),
                  const SizedBox(height: LmuSizes.size_96)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PermissionsOnboardingPageDriver> get driverProvider =>
      $PermissionsOnboardingPageDriverProvider();
}
