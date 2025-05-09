import 'package:core_routes/explore.dart';
import 'package:flutter/widgets.dart';

import '../pages/explore_page.dart';
import '../pages/explore_search_page.dart';

class ExploreRouterImpl extends ExploreRouter {
  @override
  Widget buildMain(BuildContext context) => const ExploreMapAnimationWrapper();

  @override
  Widget buildSearch(BuildContext context) => const ExploreSearchPage();
}
