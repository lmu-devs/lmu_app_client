import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/sports.dart';

import '../../sports.dart';
import '../widgets/entry_point/sports_entry_point_card.dart';

class DefaultSportsService extends SportsService {
  @override
  Widget get entryPoint => const SportsEntryPointCard();

  @override
  RouteBase get sportsData => $sportsMainRoute;
}
