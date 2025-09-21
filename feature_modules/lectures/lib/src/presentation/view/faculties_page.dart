import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/faculties_page_driver.dart';

// ToDo: Integrate logic for loading the page with 0, 1 or multiple selected faculties (see people module)
class FacultiesPage extends DrivableWidget<FacultiesPageDriver> {
  FacultiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studiesLocalizations = context.locals.studies;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: studiesLocalizations.facultiesTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          LmuSizes.size_16,
          LmuSizes.size_16,
          LmuSizes.size_16,
          LmuSizes.size_96,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: studiesLocalizations.facultiesTitle),
            const SizedBox(height: LmuSizes.size_2),
            LmuContentTile(
              contentList: driver.faculties.mapIndexed((index, faculty) {
                return LmuListItem.action(
                  key: Key("faculty_${faculty.id}"),
                  title: faculty.name,
                  leadingArea: FacultyNumberWidget(facultyId: faculty.id),
                  actionType: LmuListItemAction.chevron,
                  hasDivider: false,
                  onTap: () => driver.onFacultyPressed(context, faculty),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<FacultiesPageDriver> get driverProvider => $FacultiesPageDriverProvider();
}
