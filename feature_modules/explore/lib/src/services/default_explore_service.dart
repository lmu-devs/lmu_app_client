import 'package:core_routes/explore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/explore.dart';

class DefaultExploreService implements ExploreService {
  @override
  void navigateToExplore(BuildContext context) {
    const ExploreMainRoute().go(context);
  }
}
