// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_addition_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestGradeAdditionPageDriver extends TestDriver implements GradeAdditionPageDriver {
  @override
  String get largeTitle => ' ';

  @override
  GradeSemester get selectedGradeSemester => GradeSemester.values[0];

  @override
  TextEditingController get nameController => _TestTextEditingController();

  @override
  TextEditingController get gradeController => _TestTextEditingController();

  @override
  TextEditingController get ectsController => _TestTextEditingController();

  @override
  bool get isAddButtonEnabled => false;

  @override
  void onNameChanged(String value) {}

  @override
  void onGradeChanged(String value) {}

  @override
  void onEctsChanged(String value) {}

  @override
  void onAddGradePressed() {}

  @override
  void onGradeSemesterSelected(GradeSemester semester) {}
}

class $GradeAdditionPageDriverProvider extends WidgetDriverProvider<GradeAdditionPageDriver> {
  @override
  GradeAdditionPageDriver buildDriver() {
    return GradeAdditionPageDriver();
  }

  @override
  GradeAdditionPageDriver buildTestDriver() {
    return _$TestGradeAdditionPageDriver();
  }
}
