import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class TimelineService {
  Widget get timelinePage;

  RouteBase get timelineData;

  void navigateToTimelinePage(BuildContext context);
}
