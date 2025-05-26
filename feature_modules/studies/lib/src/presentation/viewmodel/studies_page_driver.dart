import 'package:core/localizations.dart';
import 'package:widget_driver/widget_driver.dart';

part 'studies_page_driver.g.dart';

@GenerateTestDriver()
class StudiesPageDriver extends WidgetDriver {
  late StudiesLocatizations _locatizations;
  String get pageTitle => _locatizations.studiesTitle;

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _locatizations = context.locals.studies;
  }
}
