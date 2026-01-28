import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';

enum CoursesEmptyStateType {
  noCoursesFound, noCourseData
}

extension CoursesEmptyStateTypeX on CoursesEmptyStateType {
  String assetName() {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => "lib/assets/no_courses.webp",
      CoursesEmptyStateType.noCourseData => "lib/assets/no_course_data.webp",
    };
  }

  String localizedTitle(BuildContext context) {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => context.locals.courses.noCoursesFoundTitle,
      CoursesEmptyStateType.noCourseData => context.locals.courses.noCourseDataTitle,
    };
  }

  String localizedDescription(BuildContext context) {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => context.locals.courses.noCoursesFoundDescription,
      CoursesEmptyStateType.noCourseData => context.locals.courses.noCourseDataDescription,
    };
  }
}

class CoursesEmptyState extends StatelessWidget {
  const CoursesEmptyState({super.key, required this.emptyStateType});

  final CoursesEmptyStateType emptyStateType;

  @override
  Widget build(BuildContext context) {
    return LmuEmptyState(
      type: EmptyStateType.custom,
      hasVerticalPadding: true,
      assetName: emptyStateType.assetName(),
      title: emptyStateType.localizedTitle(context),
      description: emptyStateType.localizedDescription(context),
    );
  }
}
