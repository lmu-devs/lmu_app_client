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
  late List<String> _seenEntries;
  late DeveloperdexLocalizations _developerdexLocalizations;

  String get appBarTitle => _developerdexLocalizations.developerdexTitle;
  String get infoDialogTitle => _developerdexLocalizations.developerdexInfoDialogTitle;
  String get infoDialogDescription => _developerdexLocalizations.developerdexInfoDialogDescription;
  String get availableSoonText => _developerdexLocalizations.availableSoon;
  String get joinText => _developerdexLocalizations.joinText;
  String get joinButton => _developerdexLocalizations.joinButton;

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
    _developerdexLocalizations = context.locals.developerdex;
  }
}
