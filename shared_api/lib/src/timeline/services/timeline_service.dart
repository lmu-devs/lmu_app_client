import 'package:flutter/widgets.dart';

abstract class TimelineService {
  Widget get timelinePage;

  void navigateToTimelinePage(BuildContext context);
}
