import 'package:flutter/widgets.dart';
import 'package:shared_api/explore.dart';

import '../routes/explore_routes.dart';

class DefaultExploreService implements ExploreService {
  @override
  void navigateToExplore(BuildContext context) {
    const ExploreMainRoute().go(context);
  }
}
