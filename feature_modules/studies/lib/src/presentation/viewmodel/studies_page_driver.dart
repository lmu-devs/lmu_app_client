import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:widget_driver/widget_driver.dart';

part 'studies_page_driver.g.dart';

@GenerateTestDriver()
class StudiesPageDriver extends WidgetDriver {
  late StudiesLocatizations _locatizations;
  late BuildContext _navigatorContext;
  String get pageTitle => _locatizations.studiesTitle;

  void onPeoplePressed() {
    const PeopleMainRoute().go(_navigatorContext);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _locatizations = context.locals.studies;
    _navigatorContext = context;
  }
}
