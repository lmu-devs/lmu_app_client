import 'package:core_routes/grades.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/grades_page.dart';
import '../../../presentation/view/grades_settings_page.dart';

class GradesRouterImpl extends GradesRouter {
  @override
  Widget buildMain(BuildContext context) => GradesPage();

  @override
  Widget buildSettings(BuildContext context) => GradesSettingsPage();
}
