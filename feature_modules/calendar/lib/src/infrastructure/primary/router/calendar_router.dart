import 'package:core_routes/calendar.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/calendar_page.dart';
import '../../../presentation/view/calendar_test_page.dart';

class CalendarRouterImpl extends CalendarRouter {
  @override
  Widget buildMain(BuildContext context) => CalendarPage();
  @override
  // TestPage for Testing-purposes
  Widget buildTestScreen(BuildContext context) => const CalendarTestPage();
}
