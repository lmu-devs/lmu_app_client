import 'package:core_routes/timeline.dart';
import 'package:flutter/widgets.dart';

import '../pages/timeline_page.dart';

class TimelineRouterImpl extends TimelineRouter {
  @override
  Widget buildMain(BuildContext context) => const TimelinePage();
}
