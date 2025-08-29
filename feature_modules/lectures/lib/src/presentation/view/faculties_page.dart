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
    final lecturesLocalizations = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: lecturesLocalizations.facultiesTitle,
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
            LmuTileHeadline.base(title: lecturesLocalizations.allFacultiesTitle),
            const SizedBox(height: LmuSizes.size_2),

            // Faculty list
            if (driver.isLoading)
              // TODO: Replace with skeleton loading for better UX
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (driver.hasError || driver.faculties.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LmuText.body(
                        context.locals.app.somethingWentWrong,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: LmuSizes.size_16),
                      LmuButton(
                        title: context.locals.app.tryAgain,
                        emphasis: ButtonEmphasis.primary,
                        onTap: () => driver.retry(),
                      ),
                    ],
                  ),
                ),
              )
            else
              LmuContentTile(
                contentList: driver.faculties.mapIndexed((index, faculty) {
                  return LmuListItem.action(
                    key: Key("faculty_${faculty.id}"),
                    title: faculty.name,
                    leadingArea: LmuInListBlurEmoji(emoji: faculty.id.toString()),
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
