import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

part 'faculties_page_driver.g.dart';

@GenerateTestDriver()
class FacultiesPageDriver extends WidgetDriver {
  FacultiesPageDriver();

  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  // Data
  List<Faculty> get faculties => _facultiesApi.allFaculties;

  // Actions
  void onFacultyPressed(BuildContext context, Faculty faculty) {
    LectureListRoute({
      'facultyId': faculty.id,
    }).go(context);
  }

  // Placeholder for backend data
  String get courseCount => '';
}
