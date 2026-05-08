import 'package:core_routes/calendar.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/calendar_create_entry_page.dart';
import '../../../presentation/view/calendar_page.dart';
import '../../../presentation/view/calendar_search_page.dart';
import '../../../presentation/view/calendar_test_page.dart';

class CalendarRouterImpl extends CalendarRouter {
  @override
  Widget buildMain(BuildContext context) => CalendarPage();
  @override
  Widget buildSearch(BuildContext context) => CalendarSearchPage();
  @override
  Widget buildCreate(BuildContext context) => CalendarCreateEntryPage();
  // TestPage for Testing-purposes
  @override
  Widget buildTestScreen(BuildContext context) => const CalendarTestPage();
}
