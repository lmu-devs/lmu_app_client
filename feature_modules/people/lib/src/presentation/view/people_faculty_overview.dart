import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/faculty_number_widget.dart';
import '../viewmodel/people_faculty_overview_driver.dart';

class PeopleFacultyOverview extends DrivableWidget<PeopleFacultyOverviewDriver> {
  PeopleFacultyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuPageAnimationWrapper(
          child: Align(
            alignment: Alignment.topCenter,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        if (driver.selectedFaculties.isNotEmpty) ...[
          LmuTileHeadline.base(title: driver.myFacultiesText),
          const SizedBox(height: LmuSizes.size_2),
          LmuContentTile(
            contentList: driver.selectedFaculties
                .map(
                  (faculty) => LmuListItem.action(
                    leadingArea: FacultyNumberWidget(facultyId: faculty.id),
                    actionType: LmuListItemAction.chevron,
                    title: faculty.name,
                    onTap: () => driver.onFacultyPressed(context, faculty),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: LmuSizes.size_24),
        ],
        LmuTileHeadline.base(title: driver.allFacultiesText),
        const SizedBox(height: LmuSizes.size_2),
        LmuContentTile(
          contentList: driver.allFaculties
              .map(
                (faculty) => LmuListItem.action(
                  leadingArea: FacultyNumberWidget(facultyId: faculty.id),
                  actionType: LmuListItemAction.chevron,
                  title: faculty.name,
                  onTap: () => driver.onFacultyPressed(context, faculty),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeopleFacultyOverviewDriver> get driverProvider => $PeopleFacultyOverviewDriverProvider();
}
