import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/people_router.dart';

PeopleRouter get _router => GetIt.I.get<PeopleRouter>();

class PeopleMainRoute extends GoRouteData {
  const PeopleMainRoute();

  static const String path = 'people';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class AllPeopleRoute extends GoRouteData {
  const AllPeopleRoute();

  static const String path = 'all';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildAll(context);
}

class PeopleDetailsRoute extends GoRouteData {
  const PeopleDetailsRoute({required this.id});
  final String id;
  static const String path = 'details/:id';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, id: id);
}
