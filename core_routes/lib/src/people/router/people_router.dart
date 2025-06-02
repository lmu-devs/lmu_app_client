import 'package:flutter/widgets.dart';

abstract class PeopleRouter {
  Widget buildMain(BuildContext context);
  Widget buildDetails(BuildContext context, {required String id, required String title, required String description});
}
