import 'package:core_routes/people.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/people_faculty_overview.dart';
import '../../../presentation/view/people_overview.dart';

class PeopleRouterImpl extends PeopleRouter {
  @override
  Widget buildOverview(BuildContext context, {required int facultyId}) => PeopleOverview(
        facultyId: facultyId,
      );
  @override
  Widget buildFacultyOverview(BuildContext context) => PeopleFacultyOverview(); // Replace with actual faculty overview
}
