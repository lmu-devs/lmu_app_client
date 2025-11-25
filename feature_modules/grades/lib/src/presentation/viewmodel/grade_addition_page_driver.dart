import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';

part 'grade_addition_page_driver.g.dart';

@GenerateTestDriver()
class GradeAdditionPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetGradesUsecase>();

  GradeSemester _selectedGradeSemester = GradeSemester.values.last;

  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _ectsController = TextEditingController();

  String get largeTitle => "Note hinzufügen";

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

  bool get isAddButtonEnabled {
    final name = _nameController.text;
    final grade = double.tryParse(_gradeController.text);
    final ects = int.tryParse(_ectsController.text);

    return name.isNotEmpty && grade != null && ects != null;
  }

  void onAddGradePressed() {
    final name = _nameController.text;
    final grade = double.tryParse(_gradeController.text) ?? 0.0;
    final ects = int.tryParse(_ectsController.text) ?? 0;

    final newGrade = Grade(
      id: UniqueKey().toString(),
      name: name,
      grade: grade,
      ects: ects,
      semester: _selectedGradeSemester,
    );

    _usecase.addGrade(newGrade);
    notifyWidget();
  }

  void onGradeSemesterSelected(GradeSemester semester) {
    _selectedGradeSemester = semester;
    notifyWidget();
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
