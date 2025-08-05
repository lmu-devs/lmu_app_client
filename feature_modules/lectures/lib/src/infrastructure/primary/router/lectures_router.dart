import 'package:core_routes/lectures.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/faculties_page.dart';
import '../../../presentation/view/lecture_list_page.dart';

class LecturesRouterImpl extends LecturesRouter {
  @override
  Widget buildMain(BuildContext context) => const FacultiesPage();

  @override
  Widget buildLectureList(BuildContext context, {required int facultyId}) {
    return LectureListPage(
      facultyId: facultyId,
    );
  }
}
