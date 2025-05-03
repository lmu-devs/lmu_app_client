import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/router_mensa_model.dart';
import '../router/mensa_router.dart';

MensaRouter get _router => GetIt.I.get<MensaRouter>();

class MensaData extends StatefulShellBranchData {
  const MensaData();
}

class MensaMainRoute extends GoRouteData {
  const MensaMainRoute();

  static const String path = '/mensa';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class MensaDetailsRoute extends GoRouteData {
  const MensaDetailsRoute(this.$extra);
  final RMensaModel $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}

class MensaSearchRoute extends GoRouteData {
  const MensaSearchRoute();

  static const String path = 'search';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildSearch(context);
}
