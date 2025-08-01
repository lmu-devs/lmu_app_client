import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_developerdex_usecase.dart';
import '../../domain/model/semester_course.dart';

part 'developerdex_page_driver.g.dart';

@GenerateTestDriver()
class DeveloperdexPageDriver extends WidgetDriver {
  late final GetDeveloperdexUsecase _getDeveloperdexUsecase;
  late final List<SemesterCourse> _semesterCourses;
  late final List<String> _seenEntries;
  late DeveloperdexLocatizations _developerdexLocatizations;

  String get appBarTitle => _developerdexLocatizations.developerdexTitle;

  List<SemesterCourse> get semesterCourses => _semesterCourses;

  bool wasDeveloperSeen(String id) => _seenEntries.contains(id);

  void _onDeveloperdexUpdated() {
    _seenEntries = _getDeveloperdexUsecase.seenEntries;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _getDeveloperdexUsecase = GetIt.I.get<GetDeveloperdexUsecase>();
    _semesterCourses = _getDeveloperdexUsecase.semesterCourses;
    _seenEntries = _getDeveloperdexUsecase.seenEntries;
    _getDeveloperdexUsecase.addListener(_onDeveloperdexUpdated);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _developerdexLocatizations = context.locals.developerdex;
  }
}
