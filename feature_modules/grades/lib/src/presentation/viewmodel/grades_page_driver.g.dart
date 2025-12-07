// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grades_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestGradesPageDriver extends TestDriver implements GradesPageDriver {
  @override
  bool get isLoading => false;

  @override
  String get largeTitle => ' ';

  @override
  String get addGradeTitle => ' ';

  @override
  String get gradesCountTitle => ' ';

  @override
  List<Grade> get grades => [];

  @override
  bool get hasGrades => false;

  @override
  double get averageGrade => 0.0;

  @override
  Map<GradeSemester, List<Grade>> get groupedGrades => {};

  @override
  double get archievedEcts => 0.0;

  @override
  double get maxEcts => 0.0;

  @override
  List<Grade> getOrderedGrades(List<Grade> gradesToOrdder) {
    return [];
  }

  @override
  void toggleGradeActiveState(Grade grade, bool isActive) {}

  @override
  String calculateSemesterAverage(List<Grade> grades) {
    return ' ';
  }

  @override
  void didInitDriver() {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $GradesPageDriverProvider extends WidgetDriverProvider<GradesPageDriver> {
  @override
  GradesPageDriver buildDriver() {
    return GradesPageDriver();
  }

  @override
  GradesPageDriver buildTestDriver() {
    return _$TestGradesPageDriver();
  }
}
