import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/animated_light_rays.dart';
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: LmuSizes.size_48),
                          LmuText.h1(driver.welcomeTitle, textAlign: TextAlign.center),
                          const SizedBox(height: LmuSizes.size_12),
                          LmuText.body(
                            driver.welcomeSubtitle,
                            textAlign: TextAlign.center,
                            color: colors.neutralColors.textColors.mediumColors.base,
                          ),
                          const SizedBox(height: LmuSizes.size_48),
                          LmuContentTile(
                            contentList: driver.entries
                                .map(
                                  (entry) => LmuListItem.base(
                                    title: entry.title,
                                    subtitle: entry.description,
                                    mainContentAlignment: MainContentAlignment.top,
                                    leadingArea: LmuInListBlurEmoji(emoji: entry.emoji),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: LmuSizes.size_48),
                          Text.rich(
                            TextSpan(
                              text: driver.dataPrivacyIntro,
                              style: LmuText.bodySmall('')
                                  .getTextStyle(context)
                                  .copyWith(
                                    color: context.colors.neutralColors
                                        .textColors.mediumColors.base,
                                  ),
                              children: [
                                TextSpan(
                                  text: driver.dataPrivacyLabel,
                                  style: LmuText.bodySmall('')
                                      .getTextStyle(context)
                                      .copyWith(
                                        color: context.colors.neutralColors
                                            .textColors.strongColors.base,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      LmuUrlLauncher.launchWebsite(
                                        url: LmuDevStrings.lmuDevDataPrivacy,
                                        context: context,
                                      );
                                    },
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuButton(
                    title: driver.buttonText,
                    showFullWidth: true,
                    size: ButtonSize.large,
                    onTap: driver.onButtonPressed,
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<WelcomePageDriver> get driverProvider => $WelcomePageDriverProvider();
}
