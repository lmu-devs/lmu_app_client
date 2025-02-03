import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/sports.dart';

import '../../sports.dart';
import '../pages/sports_page.dart';
import '../widgets/entry_point/sports_entry_point_card.dart';

class DefaultSportsService extends SportsService {
  @override
  Widget showEntryPoint({required VoidCallback onTap}) => SportsEntryPointCard(onTap: onTap);

  @override
  RouteBase get sportsData => $sportsMainRoute;

  @override
  Widget get sportsPage => const SportsPage();
}
