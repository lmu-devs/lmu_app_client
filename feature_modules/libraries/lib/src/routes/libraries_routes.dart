import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../repository/api/models/library_model.dart';
import '../pages/library_details_page.dart';
import '../pages/pages.dart';

part 'libraries_routes.g.dart';

@TypedGoRoute<LibrariesMainRoute>(
  path: '/libraries',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<LibraryDetailsRoute>(
      path: 'library_details',
    ),
  ],
)
class LibrariesMainRoute extends GoRouteData {
  const LibrariesMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LibrariesPage();
}

class LibraryDetailsRoute extends GoRouteData {
  const LibraryDetailsRoute(
    this.$extra,
  );

  final LibraryModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => LibraryDetailsPage(
        library: $extra,
      );
}
