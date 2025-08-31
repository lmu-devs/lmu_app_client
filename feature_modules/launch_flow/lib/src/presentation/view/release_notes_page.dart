import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/data_privacy_disclaimer.dart';
import '../component/launch_flow_page_header.dart';
import '../viewmodel/release_notes_page_driver.dart';

class ReleaseNotesPage extends DrivableWidget<ReleaseNotesPageDriver> {
  ReleaseNotesPage({super.key});

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
              if (driver.showPrivacyPolicy) const DataPrivacyDisclaimer(),
              if (driver.showPrivacyPolicy) const SizedBox(height: LmuSizes.size_16),
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
                    title: driver.releaseTitle,
                    description: driver.releaseDescription,
                  ),
                  LmuContentTile(
                    contentList: driver.releaseNotes
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
  WidgetDriverProvider<ReleaseNotesPageDriver> get driverProvider => $ReleaseNotesPageDriverProvider();
}
