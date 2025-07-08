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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: LmuText.body(
              "Collect all the animals in the LMU Safari! Tap on an animal to mark it as seen.",
              textAlign: TextAlign.left,
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final safariAnimal = SafariAnimal.values[index];
                final isSeen = driver.isAnimalSeen(safariAnimal);
                return Stack(
                  children: [
                    isSeen
                        ? Padding(
                            padding: const EdgeInsets.all(LmuSizes.size_8),
                            child: Image.asset(
                              safariAnimal.toAsset(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              package: "core",
                            ),
                          )
                        : Center(child: LmuText.h1("?")),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: LmuSizes.size_4,
                          color: context.colors.neutralColors.borderColors.cutout,
                        ),
                      ),
                    )
                  ],
                );
              },
              childCount: driver.stampCount,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: LmuSizes.size_32,
              crossAxisSpacing: LmuSizes.size_32,
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
