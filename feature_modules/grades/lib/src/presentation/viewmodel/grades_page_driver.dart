import 'package:collection/collection.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/ects_config_usecase.dart';
import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/model/grade.dart';
import '../../domain/model/grade_semester.dart';
import '../helpers/grades_filter_extension.dart';
import '../helpers/grades_formatting_extension.dart';

part 'grades_page_driver.g.dart';

@GenerateTestDriver()
class GradesPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetGradesUsecase>();
  final _ectsConfigUsecase = GetIt.I.get<EctsConfigUsecase>();

  late GradesLocalizations _gradesLocalizations;

  List<Grade> _grades = [];

  bool get isLoading => _usecase.loadState != GradesLoadState.success;

  // Titles
  String get largeTitle => _gradesLocalizations.gradesTitle;
  String get addGradeTitle => _gradesLocalizations.addGrade;
  String get gradesCountTitle {
    final count = _grades.length;
    final label = count == 1 ? _gradesLocalizations.gradeSingular : _gradesLocalizations.gradesTitle;
    return "$count $label";
  }

  // Grades
  List<Grade> get grades => _grades;
  bool get hasGrades => _grades.isNotEmpty;
  double get averageGrade => _grades.activeGrades.weightedAverage;
  Map<GradeSemester, List<Grade>> get groupedGrades => Map.fromEntries(
      groupBy(_grades, (g) => g.semester).entries.toList()..sort((a, b) => b.key.index.compareTo(a.key.index)));

  // ECTS
  double get achievedEcts => _grades.activeGrades.totalEcts;
  double get maxEcts => _ectsConfigUsecase.totalEcts ?? 0;
  bool get isEctsConfigured => _ectsConfigUsecase.isConfigured;

  // Helpers
  List<Grade> getOrderedGrades(List<Grade> grades) {
    return [...grades]..sort((a, b) {
        if (a.grade == null && b.grade == null) return 0;
        if (a.grade == null) return 1;
        if (b.grade == null) return -1;
        return a.grade!.compareTo(b.grade!);
      });
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

  void _onEctsConfigChanged() {
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _grades = _usecase.data;
    _usecase.addListener(_onStateChanged);
    _usecase.load();
    _ectsConfigUsecase.addListener(_onEctsConfigChanged);
    _ectsConfigUsecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocalizations = context.locals.grades;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    _ectsConfigUsecase.removeListener(_onEctsConfigChanged);
    super.dispose();
  }
}
