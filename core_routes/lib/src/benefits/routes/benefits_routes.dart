import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/benefits_router.dart';

BenefitsRouter get _router => GetIt.I.get<BenefitsRouter>();

class BenefitsMainRoute extends GoRouteData {
  const BenefitsMainRoute();

  static const String path = 'benefits';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class BenefitsDetailsRoute extends GoRouteData {
  const BenefitsDetailsRoute();

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context);
}
