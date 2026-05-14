import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';
import '../view/grade_addition_page.dart';
import '../view/grade_edit_page.dart';

part 'course_grade_button_driver.g.dart';

@GenerateTestDriver()
class CourseGradeButtonDriver extends WidgetDriver implements _$DriverProvidedProperties {
  CourseGradeButtonDriver({
    @driverProvidableProperty required int courseId,
    @driverProvidableProperty required String courseName,
  })  : _courseId = courseId,
        _courseName = courseName;

  late int _courseId;
  late String _courseName;

  final _usecase = GetIt.I.get<GetGradesUsecase>();

  late GradesLocatizations _gradesLocalizations;

  Grade? get _gradeForCourse {
    try {
      return _usecase.data.firstWhere((g) => g.courseId == _courseId);
    } catch (_) {
      return null;
    }
  }

  bool get hasGrade => _gradeForCourse != null;

  String get buttonTitle => hasGrade ? _gradesLocalizations.editGrade : _gradesLocalizations.addGrade;

  IconData get buttonIcon => hasGrade ? LucideIcons.pencil : LucideIcons.plus;

  void onTap(BuildContext context) {
    final existingGrade = _gradeForCourse;
    if (existingGrade != null) {
      GradeEditPage.show(context, grade: existingGrade);
    } else {
      GradeAdditionPage.show(
        context,
        initialName: _courseName,
        courseId: _courseId,
      );
    }
  }

  void _onStateChanged() {
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocalizations = context.locals.grades;
  }

  @override
  void didUpdateProvidedProperties({
    required int newCourseId,
    required String newCourseName,
  }) {
    _courseId = newCourseId;
    _courseName = newCourseName;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
