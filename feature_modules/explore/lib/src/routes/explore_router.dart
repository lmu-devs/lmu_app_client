import 'package:core_routes/explore.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../pages/explore_page.dart';
import '../pages/explore_search_page.dart';
import '../services/explore_location_service.dart';

class ExploreRouterImpl extends ExploreRouter {
  @override
  Widget buildMain(BuildContext context, {String? filter}) {
    if (filter != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          final locationService = GetIt.I<ExploreLocationService>();
          final filterType = ExploreFilterType.values.byName(filter);
          locationService.applyInitialFilter(filterType);
        } catch (e) {
          throw Exception("Filter [$filter] could not be applied: $e");
        }
      });
    }

    return const ExploreMapAnimationWrapper();
  }

  @override
  Widget buildSearch(BuildContext context) => const ExploreSearchPage();
}
