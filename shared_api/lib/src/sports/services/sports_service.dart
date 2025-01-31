import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class SportsService {
  Widget get entryPoint;

  Widget get sportsPage;

  RouteBase get sportsData;
}
