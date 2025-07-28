import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_lectures_faculties_usecase.dart';

part 'faculties_page_driver.g.dart';

@GenerateTestDriver()
class FacultiesPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetLecturesFacultiesUsecase>();

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  List<Faculty> get faculties => _usecase.faculties;
  bool get isLoading => _usecase.isLoading;
  bool get hasError => _usecase.hasError;

  String getCourseCount(Faculty faculty) {
    return '0'; // TODO: Implement when backend provides course counts
  }

  void onFacultyPressed(BuildContext context, Faculty faculty) {
    LectureListRoute({
      'facultyId': faculty.id.toString(),
      'facultyName': faculty.name,
    }).go(context);
  }

  void retry() {
    _usecase.load();
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == LecturesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _localizations.app.somethingWentWrong,
      type: ToastType.error,
      actionText: _localizations.app.tryAgain,
      onActionPressed: () => _usecase.load(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _usecase.load();
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
