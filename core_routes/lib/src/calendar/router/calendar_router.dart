import 'package:flutter/widgets.dart';

abstract class CalendarRouter {
  Widget buildMain(BuildContext context);
  Widget buildTestScreen(BuildContext context);
  Widget buildSearch(BuildContext context);
  Widget buildCreate(BuildContext context);
}
