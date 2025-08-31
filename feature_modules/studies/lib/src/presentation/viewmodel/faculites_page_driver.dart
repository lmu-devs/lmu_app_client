import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_faculties_usecase.dart';

part 'faculites_page_driver.g.dart';

@GenerateTestDriver()
class FaculitesPageDriver extends WidgetDriver {
  late StudiesLocatizations _locatizations;
  final _getFacultiesUseCase = GetIt.I.get<GetFacultiesUsecase>();

  List<Faculty> _allFaculites = [];
  List<Faculty> _selectedFaculites = [];

  String get pageTitle => _locatizations.facultiesTitle;

  List<Faculty> get allFaculties => _allFaculites;
  List<Faculty> get selectedFaculties => _selectedFaculites;

  void onFacultySelected(Faculty faculty, bool isSelected) {
    if (isSelected) {
      _selectedFaculites.add(faculty);
    } else {
      _selectedFaculites.removeWhere((f) => f.id == faculty.id);
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _allFaculites = _getFacultiesUseCase.allFaculites;
    _selectedFaculites = _getFacultiesUseCase.selectedFaculties;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _locatizations = context.locals.studies;
  }

  @override
  void dispose() {
    _getFacultiesUseCase.selectFaculties(_selectedFaculites);
    super.dispose();
  }
}
