import 'package:core_routes/lectures.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/studies.dart';

import '../../../presentation/view/faculties_page.dart';
import '../../../presentation/view/lecture_list_page.dart';

class LecturesRouterImpl extends LecturesRouter {
  @override
  Widget buildMain(BuildContext context) => FacultiesPage();

  @override
  Widget buildLectureList(BuildContext context, Map<String, dynamic> extra) {
    final faculty = extra['faculty'] as Faculty;

    return LectureListPage(
      faculty: faculty,
    );
  }
}
