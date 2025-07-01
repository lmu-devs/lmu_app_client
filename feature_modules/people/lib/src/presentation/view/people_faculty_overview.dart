import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/faculty_card.dart';
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
    if (driver.isLoading) {
      return Column(
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_8),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),

        /// Meine Fakultäten
        if (driver.selectedFaculties.isNotEmpty) ...[
          LmuTileHeadline.base(title: "Meine Fakultäten"),
          const SizedBox(height: LmuSizes.size_2),
          ...driver.selectedFaculties.map((faculty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_4),
              child: FacultyCard(
                title: faculty.name,
                onTap: () => driver.onFacultyPressed(context, faculty),
              ),
            );
          }),
          const SizedBox(height: LmuSizes.size_24),
        ],

        /// Alle Fakultäten
        LmuTileHeadline.base(title: "Alle Fakultäten"),
        const SizedBox(height: LmuSizes.size_2),
        ...driver.allFaculties.map((faculty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_4),
            child: FacultyCard(
              title: faculty.name,
              onTap: () => driver.onFacultyPressed(context, faculty),
            ),
          );
        }).toList(),

        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeopleFacultyOverviewDriver> get driverProvider => $PeopleFacultyOverviewDriverProvider();
}
