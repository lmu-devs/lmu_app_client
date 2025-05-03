import 'package:flutter/material.dart';

import '../../../explore.dart';

abstract class LibrariesService {
  Stream<List<ExploreLocation>> get librariesExploreLocationsStream;

  List<Widget> librariesMapContentBuilder(BuildContext context, String libraryId, ScrollController controller);
}
