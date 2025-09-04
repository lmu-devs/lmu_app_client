import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_lectures_usecase.dart';

part 'lecture_list_page_driver.g.dart';

@GenerateTestDriver()
class LectureListPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  LectureListPageDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;
  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetLecturesUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());

    // Load data
    if (_usecase.data == null) {
      _usecase.load();
    }
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _toast = LmuToast.of(context);
  }

  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }

  // Faculty data from the pre-loaded FacultiesApi (matching People module pattern)
  List<Faculty> get allFaculties => _facultiesApi.allFaculties;
  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  // Faculty information
  String get facultyName {
    final faculty = _facultiesApi.allFaculties.firstWhere((f) => f.id == _facultyId);
    return faculty.name;
  }

  // State management
  bool get isLoading => _usecase.loadState != LecturesLoadState.success;
  bool get hasError => _usecase.loadState == LecturesLoadState.error;
  bool get hasData => _usecase.data != null;

  // Data
  String get lecturesId => _usecase.data?.id ?? '';
  String get title => _usecase.data?.name ?? '';

  // State change handling
  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == LecturesLoadState.error) {
      _showErrorToast();
    }
  }

  // Actions
  void onLectureCardPressed() {
    // TODO: implement lecture card press
  }

  void retry() {
    _usecase.load();
  }

  // Toast helpers
  void _showErrorToast() {
    _toast.showToast(
      message: _localizations.app.somethingWentWrong,
      type: ToastType.error,
      actionText: _localizations.app.tryAgain,
      onActionPressed: () => _usecase.load(),
    );
  }
}
