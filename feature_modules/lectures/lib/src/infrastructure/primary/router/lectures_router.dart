import 'package:core_routes/lectures.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/faculties_page.dart';

class LecturesRouterImpl extends LecturesRouter {
  @override
  Widget buildMain(BuildContext context) => const FacultiesPage();
}
