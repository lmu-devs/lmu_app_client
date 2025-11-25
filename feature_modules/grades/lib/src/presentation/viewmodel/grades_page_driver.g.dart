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
  String get averageGrade => ' ';

  @override
  String get ects => ' ';

  @override
  String get ectsProgress => ' ';

  @override
  List<Grade> get grades => [];

  @override
  double get progressValue => 0.0;

  @override
  Map<GradeSemester, List<Grade>> get groupedGrades => {};

  @override
  void didInitDriver() {}

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
