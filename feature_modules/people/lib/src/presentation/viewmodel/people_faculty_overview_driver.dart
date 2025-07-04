import 'package:core/components.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

part 'people_faculty_overview_driver.g.dart';

@GenerateTestDriver()
class PeopleFacultyOverviewDriver extends WidgetDriver {
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;

  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  String get largeTitle => "Kontakte";

  void onFacultyPressed(BuildContext context, Faculty faculty) {
    PeopleOverviewRoute(facultyId: faculty.id).go(context);
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());
  }
}
