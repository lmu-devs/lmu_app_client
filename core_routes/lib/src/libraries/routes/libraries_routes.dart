import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/router_library_model.dart';
import '../router/libraries_router.dart';

LibrariesRouter get _router => GetIt.I.get<LibrariesRouter>();

@TypedGoRoute<LibrariesMainRoute>(
  path: LibrariesMainRoute.path,
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<LibraryDetailsRoute>(
      path: LibraryDetailsRoute.path,
    ),
  ],
)
class LibrariesMainRoute extends GoRouteData {
  const LibrariesMainRoute();

  static const String path = 'libraries';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildMain(context);
}

class LibraryDetailsRoute extends GoRouteData {
  const LibraryDetailsRoute(this.$extra);

  final RLibraryModel $extra;

  static const String path = 'details';

  @override
  Widget build(BuildContext context, GoRouterState state) => _router.buildDetails(context, $extra);
}
