import 'dart:ui';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:shared_api/settings.dart';
import 'package:widget_driver/widget_driver.dart';

import 'settings_safari_page_driver.dart';

class SettingsSafariPage extends DrivableWidget<SettingsSafariPageDriver> {
  SettingsSafariPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.safariTitle,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          GestureDetector(
            onTap: () => driver.restartSafari(),
            child: LmuIcon(
              icon: LucideIcons.circle_x,
              size: LmuIconSizes.medium,
              color: context.colors.dangerColors.textColors.strongColors.active,
            ),
          ),
        ],
      ),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            top: LmuSizes.size_16,
            bottom: LmuSizes.size_96,
          ),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final safariAnimal = SafariAnimal.values[index];
                final isSeen = driver.isAnimalSeen(safariAnimal);
                return Stack(
                  children: [
                    if (!isSeen)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(LmuSizes.size_12),
                          color: context.colors.neutralColors.backgroundColors.tile,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              color: context.colors.neutralColors.textColors.weakColors.disabled!.withAlpha(30),
                              safariAnimal.toAsset(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              package: "core",
                            ),
                          ),
                        ),
                      ),
                    if (isSeen)
                      Stack(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: LmuSizes.size_32,
                                  sigmaY: LmuSizes.size_32,
                                ),
                                child: Image.asset(
                                  safariAnimal.toAsset(),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  package: "core",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(LmuSizes.size_12),
                            child: Image.asset(
                              safariAnimal.toAsset(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              package: "core",
                            ),
                          ),
                        ],
                      )
                  ],
                );
              },
              childCount: driver.stampCount,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: LmuSizes.size_12,
              crossAxisSpacing: LmuSizes.size_12,
              childAspectRatio: 1,
            ),
          ),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<SettingsSafariPageDriver> get driverProvider => $SettingsSafariPageDriverProvider();
}
