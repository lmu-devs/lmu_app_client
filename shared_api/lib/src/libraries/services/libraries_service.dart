import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../explore.dart';

abstract class LibrariesService {
  Widget get librariesPage;
  RouteBase get librariesData;

  Stream<List<ExploreLocation>> get librariesExploreLocationsStream;

  void navigateToLibrariesPage(BuildContext context);

  List<Widget> librariesMapContentBuilder(BuildContext context, String libraryId, ScrollController controller);
}
