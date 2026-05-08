import 'package:core_routes/studies.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/faculites_page.dart';
import '../../../presentation/view/studies_page.dart';

class StudiesRouterImpl extends StudiesRouter {
  @override
  Widget buildMain(BuildContext context) => StudiesPage();

  @override
  Widget buildFaculties(BuildContext context) => FacultiesPage();
}
