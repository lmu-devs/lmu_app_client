import 'package:flutter/widgets.dart';

abstract class LecturesRouter {
  Widget buildMain(BuildContext context);
  Widget buildLectureList(BuildContext context, Map<String, dynamic> extra);
}
