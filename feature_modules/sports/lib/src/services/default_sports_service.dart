import 'package:core_routes/sports.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/sports.dart';

import '../pages/sports_page.dart';

class DefaultSportsService extends SportsService {
  @override
  Widget get sportsPage => const SportsPage();

  @override
  void navigateToSportsPage(BuildContext context) {
    const SportsMainRoute().go(context);
  }
}
