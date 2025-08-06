import 'package:shared_api/lectures.dart';

import '../../../domain/model/lecture.dart';

class LecturesApiImpl extends LecturesApi {
  Future<List<Lecture>> getLectures() async {
    // This would typically call the repository
    // For now, return empty list as this is handled internally
    return [];
  }

  Future<List<Lecture>> getLecturesByFaculty(int facultyId) async {
    // This would typically call the repository
    // For now, return empty list as this is handled internally
    return [];
  }
}
