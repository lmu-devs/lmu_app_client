import 'package:collection/collection.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';
import '../helpers/grades_filter_extension.dart';
import '../helpers/grades_formatting_extension.dart';

part 'grades_page_driver.g.dart';

@GenerateTestDriver()
class GradesPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetGradesUsecase>();
  final _totalECTS = 180.0;

  late GradesLocatizations _gradesLocatizations;

  List<Grade> _grades = [];

  bool get isLoading => _usecase.loadState != GradesLoadState.success;

  // Titles
  String get largeTitle => _gradesLocatizations.gradesTitle;
  String get addGradeTitle => _gradesLocatizations.addGrade;
  String get gradesCountTitle {
    final count = _grades.length;
    final label = count == 1 ? _gradesLocatizations.gradeSingular : _gradesLocatizations.gradesTitle;
    return "$count $label";
  }

  // Grades
  List<Grade> get grades => _grades;
  bool get hasGrades => _grades.isNotEmpty;
  double get averageGrade => _grades.activeGrades.weightedAverage;
  Map<GradeSemester, List<Grade>> get groupedGrades => Map.fromEntries(
      groupBy(_grades, (g) => g.semester).entries.toList()..sort((a, b) => b.key.index.compareTo(a.key.index)));

  // ECTS
  double get archievedEcts => _grades.activeGrades.totalEcts;
  double get maxEcts => _totalECTS;

  // Helpers
  List<Grade> getOrderedGrades(List<Grade> gradesToOrdder) {
    gradesToOrdder.sort((a, b) {
      if (a.grade == null && b.grade == null) return 0;
      if (a.grade == null) return 1;
      if (b.grade == null) return -1;
      return a.grade!.compareTo(b.grade!);
    });
    return gradesToOrdder;
  }

  void toggleGradeActiveState(Grade grade, bool isActive) {
    final updatedGrade = grade.copyWith(isActive: isActive);
    _usecase.updateGrade(updatedGrade);
  }

  String calculateSemesterAverage(List<Grade> grades) {
    return "Ø ${grades.weightedAverage.asStringWithTwoDecimals}";
  }

  void _onStateChanged() {
    _grades = _usecase.data;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _grades = _usecase.data;
    _usecase.addListener(_onStateChanged);
    _usecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocatizations = context.locals.grades;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
