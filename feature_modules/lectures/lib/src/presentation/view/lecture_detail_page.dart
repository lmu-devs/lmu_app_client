import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/lecture_detail_page_driver.dart';

class LectureDetailPage extends DrivableWidget<LectureDetailPageDriver> {
  LectureDetailPage({
    super.key,
    required this.lectureId,
    required this.lectureTitle,
  });

  final String lectureId;
  final String lectureTitle;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context, driver);
  }

  @override
  WidgetDriverProvider<LectureDetailPageDriver> get driverProvider =>
      _LectureDetailPageDriverProvider(lectureId, lectureTitle);

  Widget _buildContent(BuildContext context, LectureDetailPageDriver driver) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: lectureTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lectureTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: LmuSizes.size_16),
            Text(
              'Lecture ID: $lectureId',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _LectureDetailPageDriverProvider extends WidgetDriverProvider<LectureDetailPageDriver> {
  _LectureDetailPageDriverProvider(this.lectureId, this.lectureTitle);

  final String lectureId;
  final String lectureTitle;

  @override
  LectureDetailPageDriver buildDriver() {
    return LectureDetailPageDriver(
      lectureId: lectureId,
      lectureTitle: lectureTitle,
    );
  }

  @override
  LectureDetailPageDriver buildTestDriver() {
    return LectureDetailPageDriver(
      lectureId: 'test',
      lectureTitle: 'Test Lecture',
    );
  }
}
