import 'package:core_routes/people.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/studies.dart';

import '../../../presentation/view/people_faculty_overview.dart';
import '../../../presentation/view/people_overview.dart';

class PeopleRouterImpl extends PeopleRouter {
  @override
  Widget buildOverview(BuildContext context, {required Faculty? faculty}) => PeopleOverview(
        faculty: faculty,
      );
  @override
  Widget buildFacultyOverview(BuildContext context) => PeopleFacultyOverview(); // Replace with actual faculty overview
}
