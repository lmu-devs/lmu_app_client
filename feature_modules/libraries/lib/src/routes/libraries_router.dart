import 'package:core_routes/libraries.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';
import '../repository/api/models/library_model.dart';

class LibrariesRouterImpl extends LibrariesRouter {
  @override
  Widget buildMain(BuildContext context) => const LibrariesPage();

  @override
  Widget buildDetails(BuildContext context, RLibraryModel libraryModel) =>
      LibraryDetailsPage(library: libraryModel as LibraryModel);
}
