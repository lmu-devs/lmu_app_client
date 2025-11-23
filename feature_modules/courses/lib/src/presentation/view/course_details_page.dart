import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core_routes/src/courses/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/person_model.dart';
import '../viewmodel/course_details_page_driver.dart';

class CourseDetailsPage extends DrivableWidget<CourseDetailsPageDriver> {
  CourseDetailsPage({
    super.key,
    required this.facultyId,
    required this.courseId,
    required this.name,
    required this.language,
    this.degree,
    this.sws,
  });

  final int facultyId;
  final int courseId;
  final String name;
  final String language;
  final String? degree;
  final int? sws;

  @override
  Widget build(BuildContext context) {
    final courseDetails = driver.courseDetails;

    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: driver.pageTitle,
          leadingAction: LeadingAction.back,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (courseDetails == null) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: driver.pageTitle,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: LmuText.body("TBD"),
        ),
      );
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          LmuFavoriteButton(
            isFavorite: driver.isFavorite,
            onTap: () => driver.toggleFavorite(courseId),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            bottom: LmuSizes.size_96,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText(driver.quickfactText,
                  color: context
                      .colors.neutralColors.textColors.mediumColors.base),
              ...driver.sessions.map(
                (session) => Padding(
                  padding: const EdgeInsets.only(top: LmuSizes.size_16),
                  child: LmuContentTile(
                    contentList: [
                      LmuListItem.base(
                        title: driver.courseTime,
                        trailingSubtitle: session.time,
                        maximizeTrailingTitleArea: true,
                      ),
                      LmuListItem.base(
                        title: driver.courseDuration,
                        trailingSubtitle: session.duration,
                        maximizeTrailingTitleArea: true,
                      ),
                      if (session.room != null && session.room!.isNotEmpty)
                        LmuListItem.base(
                          title: driver.courseRoom,
                          trailingSubtitle: session.room!,
                          maximizeTrailingTitleArea: true,
                        ),
                    ],
                  ),
                ),
              ),
              if (driver.courseDetails!.persons.isNotEmpty ||
                  driver.courseDetails!.additionalInformation.isNotEmpty) ...[
                const SizedBox(height: LmuSizes.size_16),
                LmuContentTile(
                  contentList: [
                    if (driver.courseDetails!.persons.isNotEmpty)
                      LmuListItem.action(
                        title: driver.persons,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => driver.onPersonsDetailsPressed(
                          context,
                          courseDetails.persons,
                        ),
                      ),
                    if (driver.courseDetails!.additionalInformation.isNotEmpty)
                      LmuListItem.action(
                        title: driver.content,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => driver.onContentDetailsPressed(
                            context, courseDetails.additionalInformation),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<CourseDetailsPageDriver> get driverProvider =>
      $CourseDetailsPageDriverProvider(
        facultyId: facultyId,
        courseId: courseId,
        name: name,
        language: language,
        degree: degree,
        sws: sws,
      );
}
