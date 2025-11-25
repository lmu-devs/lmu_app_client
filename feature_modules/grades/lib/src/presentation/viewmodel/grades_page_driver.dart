import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../domain/extensions/grades_extension.dart';
import '../../domain/model/grade.dart';

part 'grades_page_driver.g.dart';

@GenerateTestDriver()
class GradesPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetGradesUsecase>();
  final _totalECTS = 180; // TODO: Get the actual value somehow

  List<Grade> _grades = [];

  bool get isLoading => _usecase.loadState != GradesLoadState.success;

  String get largeTitle => "Deine Noten";

  String get averageGrade => _grades.weightedAverageString;

  String get ects => _grades.totalEcts.toString();

  String get ectsProgress => "$ects / $_totalECTS ECTS";

  List<Grade> get grades => _grades;

  double get progressValue => _grades.totalEcts / _totalECTS;

  Map<GradeSemester, List<Grade>> get groupedGrades => Map.fromEntries(
      groupBy(_grades, (g) => g.semester).entries.toList()..sort((a, b) => b.key.index.compareTo(a.key.index)));

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
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
