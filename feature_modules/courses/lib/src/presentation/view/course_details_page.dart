import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/course_details_page_driver.dart';

class CourseDetailsPage extends DrivableWidget<CourseDetailsPageDriver> {
  CourseDetailsPage({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  final int courseId;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    final courseDetails = driver.courseDetails;

    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: courseName,
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
          largeTitle: courseName,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: LmuText.body("TBD"),
        ),
      );
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: courseName,
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
          padding: const EdgeInsets.fromLTRB(
            LmuSizes.size_16,
            LmuSizes.size_2,
            LmuSizes.size_16,
            LmuSizes.size_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (driver.courseDetails!.additionalInformation.isNotEmpty)
              LmuText.body(driver.courseDetails!.additionalInformation),
            ],
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<CourseDetailsPageDriver> get driverProvider =>
      $CourseDetailsPageDriverProvider(
          courseId: courseId, courseName: courseName);
}
