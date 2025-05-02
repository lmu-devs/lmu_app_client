import 'package:flutter/widgets.dart';

import '../models/router_library_model.dart';

abstract class SportsRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RSportsType sport);

  Widget buildSearch(BuildContext context);
}
