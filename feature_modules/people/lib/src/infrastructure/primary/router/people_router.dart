import 'package:core_routes/people.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/all_people_page.dart';
import '../../../presentation/view/people_details_page.dart';
import '../../../presentation/view/people_page.dart';

// Primary: Alles was nach "außen" exportiert wird (Router) - was gebe ich nach außen
// Secondary: Was nehme ich von außen?
class PeopleRouterImpl extends PeopleRouter {
  @override
  Widget buildMain(BuildContext context) => PeoplePage();

  @override
  Widget buildAll(BuildContext context) => AllPeoplePage();

  @override
  Widget buildDetails(BuildContext context, String id) => PeopleDetailsPage();
}
