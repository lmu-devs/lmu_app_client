import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_people_usecase.dart';

part 'people_faculty_overview_driver.g.dart';

@GenerateTestDriver()
class PeopleFacultyOverviewDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetPeopleUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  bool get isLoading => _usecase.loadState != PeopleLoadState.success;

  String get largeTitle => "Kontakte";

  void onFacultyPressed(BuildContext context, Faculty faculty) {
    PeopleOverviewRoute(facultyId: faculty.id).go(context);
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == PeopleLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _usecase.load(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _usecase.load();
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
