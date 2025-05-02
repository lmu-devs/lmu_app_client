import 'package:core_routes/timeline.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/timeline.dart';

import '../pages/timeline_page.dart';

class DefaultTimelineService extends TimelineService {
  @override
  Widget get timelinePage => const TimelinePage();

  @override
  void navigateToTimelinePage(BuildContext context) {
    const TimelineMainRoute().go(context);
  }
}
