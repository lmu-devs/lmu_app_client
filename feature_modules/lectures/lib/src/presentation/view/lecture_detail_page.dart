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
    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: driver.loadingText,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.loadingText),
            ],
          ),
        ),
      );
    }

    if (driver.hasError) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Error',
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.errorText),
              const SizedBox(height: LmuSizes.size_16),
              ElevatedButton(
                onPressed: driver.onRetry,
                child: Text(driver.retryText),
              ),
            ],
          ),
        ),
      );
    }

    if (driver.isNotFound) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Not Found',
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.lectureNotFoundText),
            ],
          ),
        ),
      );
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.displayLectureTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Container(), // Empty body as requested
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
