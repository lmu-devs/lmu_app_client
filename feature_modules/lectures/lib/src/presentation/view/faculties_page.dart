import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/faculties_page_driver.dart';

class FacultiesPage extends DrivableWidget<FacultiesPageDriver> {
  FacultiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studiesLocalizations = context.locals.studies;
    final appLocalizations = context.locals.app;

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
            // Action buttons row
            LmuButtonRow(
              hasHorizontalPadding: false,
              buttons: [
                LmuIconButton(
                  icon: LucideIcons.search,
                  onPressed: () {
                    // TODO: implement search
                  },
                ),
                LmuIconButton(
                  icon: LucideIcons.arrow_up_down,
                  onPressed: () {
                    // TODO: implement sort
                  },
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_32),

            // Header row: title
            LmuTileHeadline.base(title: '${appLocalizations.all} ${studiesLocalizations.facultiesTitle}'),
            const SizedBox(height: LmuSizes.size_2),

            // Faculty list
            LmuContentTile(
              contentList: driver.faculties.mapIndexed((index, faculty) {
                return LmuListItem.action(
                  key: Key("faculty_${faculty.id}"),
                  title: faculty.name,
                  leadingArea: LmuInListBlurEmoji(emoji: faculty.id.toString()),
                  trailingTitle: driver.courseCount,
                  actionType: LmuListItemAction.chevron,
                  hasDivider: false,
                  onTap: () {
                    driver.onFacultyPressed(context, faculty);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<FacultiesPageDriver> get driverProvider => _FacultiesPageDriverProvider();
}

class _FacultiesPageDriverProvider extends WidgetDriverProvider<FacultiesPageDriver> {
  @override
  FacultiesPageDriver buildDriver() {
    return FacultiesPageDriver();
  }

  @override
  FacultiesPageDriver buildTestDriver() {
    return FacultiesPageDriver();
  }
}
