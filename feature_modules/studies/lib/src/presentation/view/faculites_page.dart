import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/faculites_page_driver.dart';

class FaculitesPage extends DrivableWidget<FaculitesPageDriver> {
  FaculitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        leadingAction: LeadingAction.back,
        largeTitle: driver.pageTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              contentList: driver.allFaculties
                  .map(
                    (faculty) => LmuListItem.action(
                      leadingArea: LmuText.h2(faculty.id.toString()),
                      actionType: LmuListItemAction.checkbox,
                      title: faculty.name,
                      onChange: (val) => driver.onFacultySelected(faculty, val),
                      initialValue: driver.selectedFaculties.contains(faculty),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<FaculitesPageDriver> get driverProvider => $FaculitesPageDriverProvider();
}
