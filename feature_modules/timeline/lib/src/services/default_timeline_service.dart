import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/timeline.dart';

import '../pages/timeline_page.dart';
import '../routes/timeline_routes.dart';

class DefaultTimelineService extends TimelineService {
  @override
  RouteBase get timelineData => $timelineMainRoute;

  @override
  Widget get timelinePage => const TimelinePage();

  @override
  void navigateToTimelinePage(BuildContext context) {
    const TimelineMainRoute().go(context);
  }
}
