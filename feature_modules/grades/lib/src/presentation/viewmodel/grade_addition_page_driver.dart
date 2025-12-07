import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';

part 'grade_addition_page_driver.g.dart';

@GenerateTestDriver()
class GradeAdditionPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetGradesUsecase>();

  double? _selectedGrade;

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

  bool get isAddButtonEnabled {
    final name = _nameController.text;
    final ects = int.tryParse(_ectsController.text);

    return name.isNotEmpty && ects != null;
  }

  void onAddGradePressed() {
    final name = _nameController.text;
    final ects = int.tryParse(_ectsController.text) ?? 0;

    final newGrade = Grade(
      id: UniqueKey().toString(),
      name: name,
      grade: _selectedGrade,
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

  void onGradeSelected(double? grade) {
    _selectedGrade = grade;
    notifyWidget();
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
