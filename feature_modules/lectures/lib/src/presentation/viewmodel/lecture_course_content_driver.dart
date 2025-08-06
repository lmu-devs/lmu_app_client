import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

class LectureCourseContentDriver extends WidgetDriver {
  LectureCourseContentDriver({
    required this.lectureTitle,
  });

  final String lectureTitle;
  LmuLocalizations? _localizations;

  String get appBarTitle => _localizations?.lectures.courseContentTitle ?? 'Course Content';
  String get contentTitle => _localizations?.lectures.contentTitle ?? 'Content';
  String get learningObjectivesTitle => _localizations?.lectures.courseContentObjectives ?? 'Learning Objectives';
  String get prerequisitesTitle => _localizations?.lectures.courseContentPrerequisites ?? 'Prerequisites';

  bool get isLoading => false; // No loading state needed for hardcoded data
  bool get hasError => false;

  // Hardcoded content like other pages
  String get courseContent =>
      _localizations?.lectures.courseContentDescription ?? 'Course content description not available.';

  List<String> get learningObjectives => [
        _localizations?.lectures.courseContentObjectives1 ?? 'Understanding of basic data structures',
        _localizations?.lectures.courseContentObjectives2 ?? 'Implementation of sorting and searching algorithms',
        _localizations?.lectures.courseContentObjectives3 ?? 'Analysis of algorithm complexity and efficiency',
        _localizations?.lectures.courseContentObjectives4 ?? 'Application of data structures to real-world problems',
      ];

  String get prerequisites =>
      _localizations?.lectures.courseContentPrerequisitesText ??
      'Basic programming knowledge and fundamental mathematics.';

  @override
  void didInitDriver() {
    super.didInitDriver();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: appBarTitle,
          leadingAction: LeadingAction.back,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: appBarTitle,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: LmuSizes.size_16),
              Text(_localizations?.app.somethingWentWrong ?? 'Something went wrong'),
            ],
          ),
        ),
      );
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: appBarTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: lectureTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.h3(contentTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(courseContent),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(learningObjectivesTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(
              learningObjectives.map((objective) => '• $objective').join('\n'),
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h3(prerequisitesTitle),
            const SizedBox(height: LmuSizes.size_16),
            LmuText.body(prerequisites),
          ],
        ),
      ),
    );
  }
}
