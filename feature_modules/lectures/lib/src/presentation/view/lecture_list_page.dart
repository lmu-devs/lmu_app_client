import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/lecture_list_page_driver.dart';

class LectureListPage extends DrivableWidget<LectureListPageDriver> {
  LectureListPage({
    super.key,
    required this.facultyId,
  });

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.facultyName,
        leadingAction: LeadingAction.back,
      ),
      body: _buildBody(context),
    );
  }

  @override
  WidgetDriverProvider<LectureListPageDriver> get driverProvider => _LectureListPageDriverProvider(facultyId);

  Widget _buildBody(BuildContext context) {
    if (driver.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (driver.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading lectures'),
            const SizedBox(height: LmuSizes.size_16),
            ElevatedButton(
              onPressed: driver.retry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          LmuText.h2('Lectures for ${driver.facultyName}'),
          const SizedBox(height: LmuSizes.size_16),
          LmuText.body('Lecture ID: ${driver.lecturesId}'),
          LmuText.body('Title: ${driver.title}'),
          const SizedBox(height: LmuSizes.size_32),
          LmuButton(
            title: 'Test Lecture Card',
            onTap: driver.onLectureCardPressed,
          ),
        ],
      ),
    );
  }
}

class _LectureListPageDriverProvider extends WidgetDriverProvider<LectureListPageDriver> {
  _LectureListPageDriverProvider(this.facultyId);

  final int facultyId;

  @override
  LectureListPageDriver buildDriver() {
    return LectureListPageDriver(
      facultyId: facultyId,
    );
  }

  @override
  LectureListPageDriver buildTestDriver() {
    return LectureListPageDriver(
      facultyId: 1,
    );
  }
}
