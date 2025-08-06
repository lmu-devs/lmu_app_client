import 'package:flutter/widgets.dart';

abstract class PeopleRouter {
  Widget buildOverview(BuildContext context, {required int facultyId});
  Widget buildFacultyOverview(BuildContext context);
  Widget buildDetails(BuildContext context, {required int facultyId, required int personId});
  Widget buildSearch(BuildContext context, {required int facultyId});
}
