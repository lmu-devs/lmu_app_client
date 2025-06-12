import 'package:core_routes/calendar.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/calendar_page.dart';

class CalendarRouterImpl extends CalendarRouter {
  @override
  Widget buildMain(BuildContext context) => CalendarPage();
}
