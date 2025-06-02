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

class PeopleDetailsRoute extends GoRouteData {
  const PeopleDetailsRoute({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  static const String path = 'people/details';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      _router.buildDetails(context, id: id, title: title, description: description);
}
