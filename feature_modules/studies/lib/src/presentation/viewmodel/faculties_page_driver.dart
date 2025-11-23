import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_faculties_usecase.dart';

part 'faculties_page_driver.g.dart';

@GenerateTestDriver()
class FacultiesPageDriver extends WidgetDriver {
  late StudiesLocatizations _localizations;
  final _getFacultiesUseCase = GetIt.I.get<GetFacultiesUsecase>();

  List<Faculty> _allFaculties = [];
  List<Faculty> _selectedFaculties = [];

  String get pageTitle => _localizations.facultiesTitle;

  List<Faculty> get allFaculties => _allFaculties;
  List<Faculty> get selectedFaculties => _selectedFaculties;

  void onFacultySelected(Faculty faculty, bool isSelected) {
    if (isSelected) {
      _selectedFaculties.add(faculty);
    } else {
      _selectedFaculties.removeWhere((f) => f.id == faculty.id);
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _allFaculties = _getFacultiesUseCase.allFaculties;
    _selectedFaculties = _getFacultiesUseCase.selectedFaculties;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals.studies;
  }

  @override
  void dispose() {
    _getFacultiesUseCase.selectFaculties(_selectedFaculties);
    super.dispose();
  }
}
