import 'package:core_routes/lectures.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/faculties_page.dart';
import '../../../presentation/view/lecture_list_page.dart';

class LecturesRouterImpl extends LecturesRouter {
  @override
  Widget buildMain(BuildContext context) => FacultiesPage();

  @override
  Widget buildLectureList(BuildContext context, Map<String, dynamic> extra) {
    final facultyId = extra['facultyId'] as String;
    final facultyName = extra['facultyName'] as String;

    return LectureListPage(
      facultyId: facultyId,
      facultyName: facultyName,
    );
  }
}
