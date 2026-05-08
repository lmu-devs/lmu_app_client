import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_courses_usecase.dart';

part 'courses_faculty_overview_driver.g.dart';

@GenerateTestDriver()
class CoursesFacultyOverviewDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetCoursesUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  String get myFacultiesText => _localizations.studies.myFaculties;
  String get allFacultiesText => _localizations.studies.allFaculties;

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  bool get isLoading => _usecase.loadState != CoursesLoadState.success;

  String get largeTitle => _localizations.courses.coursesTitle;

  void onFacultyPressed(BuildContext context, Faculty faculty) {
    CoursesOverviewRoute(facultyId: faculty.id).push(context);
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == CoursesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _localizations.app.somethingWentWrong,
      type: ToastType.error,
      actionText: _localizations.app.tryAgain,
      onActionPressed: () => {},
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
