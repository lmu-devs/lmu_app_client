import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../application/usecase/grades_toast_service.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';
import '../helpers/grade_form_constants.dart';
import '../helpers/grades_formatting_extension.dart';

part 'grade_edit_page_driver.g.dart';

@GenerateTestDriver()
class GradeEditPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  GradeEditPageDriver({
    @driverProvidableProperty required Grade gradeToEdit,
  }) : _gradeToEdit = gradeToEdit;

  final _usecase = GetIt.I.get<GetGradesUsecase>();
  final _toastService = GetIt.I.get<GradesToastService>();

  late final Grade _gradeToEdit;
  late GradesLocatizations _gradesLocalizations;

  double _sliderGradeValue = 2.0;
  int _sliderIndex = 3;
  bool _noGradeReceived = true;

  late GradeSemester _selectedGradeSemester;

  final _nameController = TextEditingController();
  final _ectsController = TextEditingController();

  String get largeTitle => _gradesLocalizations.editGrade;

  String get saveButtonTitle => _gradesLocalizations.saveButton;

  String get deleteButtonTitle => _gradesLocalizations.deleteButton;

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

  void onDeleteGradePressed() {
    final grade = _gradeToEdit;
    _usecase.removeGrade(_gradeToEdit.id);
    _toastService.add(GradeDeletedEvent(grade));
  }

  void onGradeSemesterSelected(GradeSemester semester) {
    _selectedGradeSemester = semester;
    notifyWidget();
  }

  bool get isSaveButtonEnabled {
    final name = _nameController.text;
    final ects = parseEcts(_ectsController.text);

    final valuesChanged = name != _gradeToEdit.name ||
        (selectedGrade != _gradeToEdit.grade) ||
        ects != _gradeToEdit.ects ||
        _selectedGradeSemester != _gradeToEdit.semester;

    return name.isNotEmpty && ects != null && valuesChanged;
  }

  void onSaveGradePressed() {
    final updatedGrade = _gradeToEdit.copyWith(
      name: _nameController.text,
      grade: selectedGrade,
      ects: parseEcts(_ectsController.text) ?? _gradeToEdit.ects,
      semester: _selectedGradeSemester,
      isActive: _gradeToEdit.isActive,
    );
    _usecase.updateGrade(updatedGrade);
    _toastService.add(const GradeSavedEvent());
  }

  void onSliderIndexChanged(int index) {
    _sliderIndex = index;
    _sliderGradeValue = grades[index];
    notifyWidget();
  }

  void onNoGradeReceivedChanged(bool value) {
    _noGradeReceived = value;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _nameController.text = _gradeToEdit.name;
    _ectsController.text = _gradeToEdit.ects.asEctsString;
    _selectedGradeSemester = _gradeToEdit.semester;
    _noGradeReceived = _gradeToEdit.grade == null;
    _sliderGradeValue = _gradeToEdit.grade ?? 2.0;
    _sliderIndex = grades.indexOf(_sliderGradeValue).clamp(0, grades.length - 1);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocalizations = context.locals.grades;
  }

  @override
  void didUpdateProvidedProperties({
    required Grade newGradeToEdit,
  }) {
    _gradeToEdit = newGradeToEdit;
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
