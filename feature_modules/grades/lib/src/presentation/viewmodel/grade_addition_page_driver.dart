import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../application/usecase/grades_toast_service.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';
import '../helpers/grade_form_constants.dart';

part 'grade_addition_page_driver.g.dart';

@GenerateTestDriver()
class GradeAdditionPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  GradeAdditionPageDriver({
    @driverProvidableProperty this.initialName,
    @driverProvidableProperty this.courseId,
  });

  final String? initialName;
  final int? courseId;

  final _usecase = GetIt.I.get<GetGradesUsecase>();
  final _toastService = GetIt.I.get<GradesToastService>();

  late GradesLocatizations _gradesLocalizations;

  double _sliderGradeValue = 1.0;
  int _sliderIndex = 0;
  bool _noGradeReceived = false;

  GradeSemester _selectedGradeSemester = GradeSemester.values.last;

  final _nameController = TextEditingController();
  final _ectsController = TextEditingController();

  String get largeTitle => _gradesLocalizations.addGrade;

  String get addButtonTitle => _gradesLocalizations.addButton;

  GradeSemester get selectedGradeSemester => _selectedGradeSemester;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get nameController => _nameController;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get ectsController => _ectsController;

  double? get selectedGrade => _noGradeReceived ? null : _sliderGradeValue;

  double get sliderGradeValue => _sliderGradeValue;

  int get sliderIndex => _sliderIndex;

  bool get noGradeReceived => _noGradeReceived;

  List<double> get grades => availableGrades;

  void onNameChanged(String value) {
    notifyWidget();
  }

  void onEctsChanged(String value) {
    notifyWidget();
  }

  bool get isAddButtonEnabled {
    final name = _nameController.text;
    final ects = parseEcts(_ectsController.text);

    return name.isNotEmpty && ects != null;
  }

  void onAddGradePressed() {
    final name = _nameController.text;
    final ects = parseEcts(_ectsController.text) ?? 0;

    final newGrade = Grade(
      id: UniqueKey().toString(),
      name: name,
      grade: selectedGrade,
      ects: ects,
      semester: _selectedGradeSemester,
      courseId: courseId,
    );

    _usecase.addGrade(newGrade);
    _toastService.add(const GradeAddedEvent());
    notifyWidget();
  }

  void onGradeSemesterSelected(GradeSemester semester) {
    _selectedGradeSemester = semester;
    notifyWidget();
  }

  void onSliderIndexChanged(int index) {
    _sliderIndex = index;
    _sliderGradeValue = grades[index];
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    if (initialName != null) {
      _nameController.text = initialName!;
    }
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocalizations = context.locals.grades;
  }

  @override
  void didUpdateProvidedProperties({
    String? newInitialName,
    int? newCourseId,
  }) {}

  void onNoGradeReceivedChanged(bool value) {
    _noGradeReceived = value;
    notifyWidget();
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
