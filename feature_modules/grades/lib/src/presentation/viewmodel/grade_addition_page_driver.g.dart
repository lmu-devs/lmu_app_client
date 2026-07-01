// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_addition_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.6"

class _$TestGradeAdditionPageDriver extends TestDriver
    implements GradeAdditionPageDriver {
  @override
  String get largeTitle => ' ';

  @override
  String get addButtonTitle => ' ';

  @override
  GradeSemester get selectedGradeSemester => GradeSemester.values[0];

  @override
  List<GradeSemester> get availableSemesters => <GradeSemester>[];

  @override
  TextEditingController get nameController => _TestTextEditingController();

  @override
  TextEditingController get ectsController => _TestTextEditingController();

  @override
  double? get selectedGrade => 0.0;

  @override
  double get sliderGradeValue => 0.0;

  @override
  int get sliderIndex => 0;

  @override
  bool get noGradeReceived => false;

  @override
  List<double> get grades => [];

  @override
  bool get isAddButtonEnabled => false;

  @override
  void onNameChanged(String value) {}

  @override
  void onEctsChanged(String value) {}

  @override
  void onAddGradePressed() {}

  @override
  void onGradeSemesterSelected(GradeSemester semester) {}

  @override
  void onSliderIndexChanged(int index) {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void onNoGradeReceivedChanged(bool value) {}
}

class $GradeAdditionPageDriverProvider
    extends WidgetDriverProvider<GradeAdditionPageDriver> {
  @override
  GradeAdditionPageDriver buildDriver() {
    return GradeAdditionPageDriver();
  }

  @override
  GradeAdditionPageDriver buildTestDriver() {
    return _$TestGradeAdditionPageDriver();
  }
}
