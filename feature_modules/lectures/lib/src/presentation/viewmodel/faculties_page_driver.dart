import 'package:core/localizations.dart';
import 'package:core_routes/lectures.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

part 'faculties_page_driver.g.dart';

@GenerateTestDriver()
class FacultiesPageDriver extends WidgetDriver {
  late LmuLocalizations _localizations;

  List<Faculty> get faculties => GetIt.I.get<FacultiesApi>().allFaculties;

  void onFacultyPressed(BuildContext context, Faculty faculty) {
    LectureListRoute({
      'faculty': faculty,
    }).go(context);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }
}
