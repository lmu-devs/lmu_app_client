import 'package:flutter/widgets.dart';

import '../models/router_sports_type.dart';

abstract class SportsRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RSportsType sport);

  Widget buildSearch(BuildContext context);
}
