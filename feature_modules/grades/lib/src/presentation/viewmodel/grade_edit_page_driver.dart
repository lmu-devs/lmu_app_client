import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';

part 'grade_edit_page_driver.g.dart';

@GenerateTestDriver()
class GradeEditPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  GradeEditPageDriver({
    @driverProvidableProperty required Grade gradeToEdit,
  }) : _gradeToEdit = gradeToEdit;

  final _usecase = GetIt.I.get<GetGradesUsecase>();

  late final Grade _gradeToEdit;

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
    final grade = double.tryParse(_gradeController.text);
    final ects = int.tryParse(_ectsController.text);

    final valuesChanged = name != _gradeToEdit.name ||
        grade != _gradeToEdit.grade ||
        ects != _gradeToEdit.ects ||
        _selectedGradeSemester != _gradeToEdit.semester;

    return name.isNotEmpty && grade != null && ects != null && valuesChanged;
  }

  void onSaveGradePressed() {
    final updatedGrade = _gradeToEdit.copyWith(
      name: _nameController.text,
      grade: double.tryParse(_gradeController.text) ?? _gradeToEdit.grade,
      ects: int.tryParse(_ectsController.text) ?? _gradeToEdit.ects,
      semester: _selectedGradeSemester,
    );
    _usecase.updateGrade(updatedGrade);
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _nameController.text = _gradeToEdit.name;
    _gradeController.text = _gradeToEdit.grade.toString();
    _ectsController.text = _gradeToEdit.ects.toString();
    _selectedGradeSemester = _gradeToEdit.semester;
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
