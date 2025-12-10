import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';

part 'grade_edit_page_driver.g.dart';

@GenerateTestDriver()
class GradeEditPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  GradeEditPageDriver({
    @driverProvidableProperty required Grade gradeToEdit,
  }) : _gradeToEdit = gradeToEdit;

  final _usecase = GetIt.I.get<GetGradesUsecase>();

  late final Grade _gradeToEdit;

  late double? _selectedGrade;

  late GradeSemester _selectedGradeSemester;

  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _ectsController = TextEditingController();

  String get largeTitle => "Note bearbeiten";

  GradeSemester get selectedGradeSemester => _selectedGradeSemester;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get nameController => _nameController;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get gradeController => _gradeController;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get ectsController => _ectsController;

  double? get selectedGrade => _selectedGrade;

  List<double> get availableGrades => [1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0];

  void onNameChanged(String value) {
    notifyWidget();
  }

  void onGradeChanged(String value) {
    notifyWidget();
  }

  void onEctsChanged(String value) {
    notifyWidget();
  }

  void onDeleteGradePressed() {
    _usecase.removeGrade(_gradeToEdit.id);
  }

  void onGradeSemesterSelected(GradeSemester semester) {
    _selectedGradeSemester = semester;
    notifyWidget();
  }

  bool get isSaveButtonEnabled {
    final name = _nameController.text;
    final ects = int.tryParse(_ectsController.text);

    final valuesChanged = name != _gradeToEdit.name ||
        (_selectedGrade != null ? _selectedGrade != _gradeToEdit.grade : _gradeToEdit.grade != null) ||
        ects != _gradeToEdit.ects ||
        _selectedGradeSemester != _gradeToEdit.semester;

    return name.isNotEmpty && ects != null && valuesChanged;
  }

  void onSaveGradePressed() {
    final updatedGrade = _gradeToEdit.copyWith(
      name: _nameController.text,
      grade: _selectedGrade,
      ects: int.tryParse(_ectsController.text) ?? _gradeToEdit.ects,
      semester: _selectedGradeSemester,
      isActive: _gradeToEdit.isActive,
    );
    _usecase.updateGrade(updatedGrade);
  }

  void onGradeSelected(double? grade) {
    _selectedGrade = grade;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _nameController.text = _gradeToEdit.name;
    _gradeController.text = _gradeToEdit.grade.toString();
    _ectsController.text = _gradeToEdit.ects.toString();
    _selectedGradeSemester = _gradeToEdit.semester;
    _selectedGrade = _gradeToEdit.grade;
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
