import 'package:flutter/widgets.dart';

import '../models/router_library_model.dart';

abstract class LibrariesRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RLibraryModel library);

  Widget buildAreas(BuildContext context, RLibraryModel library);

  Widget buildSearch(BuildContext context);
}
