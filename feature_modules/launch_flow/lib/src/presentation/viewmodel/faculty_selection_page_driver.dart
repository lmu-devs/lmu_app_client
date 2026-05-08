import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/interface/launch_flow_repository_interface.dart';

part 'faculty_selection_page_driver.g.dart';

@GenerateTestDriver()
class FacultySelectionPageDriver extends WidgetDriver {
  late LaunchFlowLocatizations _flowLocalizations;
  late AppLocalizations _appLocalizations;
  late BuildContext _navigatorContext;
  late final FacultiesApi _facultiesApi;

  List<Faculty> _faculites = [];
  final List<Faculty> _selectedFaculites = [];

  String get selectionTitle => _flowLocalizations.facultySelectionTitle;

  String get selectionDescription => _flowLocalizations.facultySelectionDescription;

  String get doneButtonText => _appLocalizations.done;

  String get skipButtonText => _appLocalizations.setUpLater;

  List<Faculty> get faculties => _faculites;

  List<Faculty> get selectedFaculties => _selectedFaculites;

  bool get isDoneButtonEnabled => _selectedFaculites.isNotEmpty;

  void onFacultySelected(Faculty faculty, bool isSelected) {
    if (isSelected) {
      _selectedFaculites.add(faculty);
    } else {
      _selectedFaculites.removeWhere((f) => f.id == faculty.id);
    }
    notifyWidget();
  }

  void onDonePressed() {
    _facultiesApi.selectFaculties(_selectedFaculites);
    _navigateToNextPage();
  }

  void onSkipPressed() {
    _facultiesApi.selectFaculties([]);
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    GetIt.I.get<LaunchFlowRepositoryInterface>().showedFacultySelectionPage();
    final launchFlowApi = GetIt.I.get<LaunchFlowApi>();
    launchFlowApi.continueFlow(_navigatorContext);
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _faculites = _facultiesApi.allFaculties;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _flowLocalizations = context.locals.launchFlow;
    _appLocalizations = context.locals.app;
    _navigatorContext = context;
    _facultiesApi = GetIt.I.get<FacultiesApi>();
  }
}
