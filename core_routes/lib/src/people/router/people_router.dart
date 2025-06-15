import 'package:flutter/widgets.dart';

abstract class PeopleRouter {
  Widget buildMain(BuildContext context);
  Widget buildAll(BuildContext context);
  Widget buildDetails(BuildContext context);
}
