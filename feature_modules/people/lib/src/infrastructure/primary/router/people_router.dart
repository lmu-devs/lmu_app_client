import 'package:core_routes/people.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/people_page.dart';

class PeopleRouterImpl extends PeopleRouter {
  @override
  Widget buildMain(BuildContext context) => PeoplePage();
}
