import 'package:core_routes/sports.dart';
import 'package:flutter/widgets.dart';

import '../pages/pages.dart';
import '../repository/api/models/sports_type.dart';

class SportsRouterImpl extends SportsRouter {
  @override
  Widget buildMain(BuildContext context) => const SportsPage();

  @override
  Widget buildDetails(BuildContext context, RSportsType sport) => SportsDetailsPage(sport: sport as SportsType);

  @override
  Widget buildSearch(BuildContext context) => const SportsSearchPage();
}
