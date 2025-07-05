import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/launch_flow_page_header.dart';
import '../viewmodel/faculty_selection_page_driver.dart';

class FacultySelectionPage extends DrivableWidget<FacultySelectionPageDriver> {
  FacultySelectionPage({super.key});

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
                state: driver.isDoneButtonEnabled
                    ? ButtonState.enabled
                    : ButtonState.disabled,
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
            child: ListFadingShader(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LaunchFlowPageHeader(
                      title: driver.selectionTitle,
                      description: driver.selectionDescription,
                    ),
                    LmuContentTile(
                      contentList: driver.faculties
                          .map(
                            (faculty) => LmuListItem.action(
                              leadingArea: LmuInListBlurEmoji(
                                  emoji: faculty.id.toString()),
                              actionType: LmuListItemAction.checkbox,
                              title: faculty.name,
                              onChange: (val) =>
                                  driver.onFacultySelected(faculty, val),
                              initialValue:
                                  driver.selectedFaculties.contains(faculty),
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
    );
  }

  @override
  WidgetDriverProvider<FacultySelectionPageDriver> get driverProvider =>
      $FacultySelectionPageDriverProvider();
}
