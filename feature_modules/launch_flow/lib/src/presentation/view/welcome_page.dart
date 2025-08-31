import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/animated_light_rays.dart';
import '../component/data_privacy_disclaimer.dart';
import '../component/launch_flow_page_header.dart';
import '../viewmodel/welcome_page_driver.dart';

class WelcomePage extends DrivableWidget<WelcomePageDriver> {
  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      children: [
        Scaffold(backgroundColor: colors.neutralColors.backgroundColors.base),
        const Positioned.fill(
          child: IgnorePointer(
            child: AnimatedLightRays(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DataPrivacyDisclaimer(),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuButton(
                    title: driver.buttonText,
                    showFullWidth: true,
                    size: ButtonSize.large,
                    onTap: driver.onButtonPressed,
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
                        title: driver.welcomeTitle,
                        description: driver.welcomeSubtitle,
                      ),
                      LmuContentTile(
                        contentList: driver.entries
                            .map(
                              (entry) => LmuListItem.base(
                                title: entry.title,
                                subtitle: entry.description,
                                mainContentAlignment: MainContentAlignment.top,
                                leadingArea:
                                    LmuInListBlurEmoji(emoji: entry.emoji),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: LmuSizes.size_96)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<WelcomePageDriver> get driverProvider =>
      $WelcomePageDriverProvider();
}
