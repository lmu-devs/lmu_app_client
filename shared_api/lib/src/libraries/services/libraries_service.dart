import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class LibrariesService {
  Widget get librariesPage;

  Stream<List<ExploreLocation>> get librariesExploreLocationsStream;

  void navigateToLibrariesPage(BuildContext context);

  List<Widget> librariesMapContentBuilder(BuildContext context, String libraryId, ScrollController controller);
}
