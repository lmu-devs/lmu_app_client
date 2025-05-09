import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../repository/api/api.dart';
import '../pages/pages.dart';

part 'libraries_routes.g.dart';

@TypedGoRoute<LibrariesMainRoute>(
  path: '/libraries',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<LibraryDetailsRoute>(
      path: 'library_details',
      routes: [
        TypedGoRoute<LibraryAreasRoute>(
          path: 'areas',
        ),
      ],
    ),
    TypedGoRoute<LibrariesSearchRoute>(
      path: 'search',
      routes: [
        TypedGoRoute<LibrarySearchDetailsRoute>(
          path: 'search_details',
          routes: [
            TypedGoRoute<LibrarySearchAreasRoute>(
              path: 'search_areas',
            ),
          ],
        ),
      ],
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

class LibraryAreasRoute extends GoRouteData {
  const LibraryAreasRoute(
      this.$extra,
      );

  final LibraryModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => LibraryAreasPage(
    library: $extra,
  );
}

class LibrariesSearchRoute extends GoRouteData {
  const LibrariesSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LibrariesSearchPage();
}

class LibrarySearchDetailsRoute extends GoRouteData {
  const LibrarySearchDetailsRoute(this.$extra);

  final LibraryModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => LibraryDetailsPage(library: $extra);
}

class LibrarySearchAreasRoute extends GoRouteData {
  const LibrarySearchAreasRoute(this.$extra);

  final LibraryModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => LibraryAreasPage(library: $extra);
}
