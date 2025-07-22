import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_developerdex_usecase.dart';
import '../../domain/model/lmu_developer.dart';
import '../../domain/model/semester_course.dart';

part 'developerdex_page_driver.g.dart';

@GenerateTestDriver()
class DeveloperdexPageDriver extends WidgetDriver {
  late final GetDeveloperdexUsecase _getDeveloperdexUsecase;
  late final List<SemesterCourse> _semesterCourses;

  String get appBarTitle => "Developerdex";

  List<SemesterCourse> get semesterCourses => _semesterCourses;

  int get stampCount => SafariAnimal.values.length;

  bool wasDeveloperSeen(SafariAnimal animal) => true;

  void onDeveloperSeen(LmuDeveloper developer) {}

  @override
  void didInitDriver() {
    super.didInitDriver();
    _getDeveloperdexUsecase = GetIt.I.get<GetDeveloperdexUsecase>();
    _semesterCourses = _getDeveloperdexUsecase.semesterCourses;
  }
}
