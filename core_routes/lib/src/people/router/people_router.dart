import 'package:flutter/widgets.dart';

abstract class PeopleRouter {
  Widget buildOverview(BuildContext context, {required int? facultyId});
  Widget buildFacultyOverview(BuildContext context);
}
