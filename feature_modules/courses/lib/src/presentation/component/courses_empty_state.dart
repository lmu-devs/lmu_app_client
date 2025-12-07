import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';

enum CoursesEmptyStateType {
  noCoursesFound,
}

extension CoursesEmptyStateTypeX on CoursesEmptyStateType {
  String assetName() {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => "lib/assets/no_courses.webp",
    };
  }

  String localizedTitle(BuildContext context) {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => context.locals.courses.noCoursesFoundTitle,
    };
  }

  String localizedDescription(BuildContext context) {
    return switch (this) {
      CoursesEmptyStateType.noCoursesFound => context.locals.courses.noCoursesFoundDescription,
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
