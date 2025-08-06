import 'package:flutter/widgets.dart';

abstract class LecturesRouter {
  Widget buildMain(BuildContext context);
  Widget buildLectureList(BuildContext context, {required int facultyId});
  Widget buildLectureDetail(BuildContext context, {required String lectureId, required String lectureTitle});
}
