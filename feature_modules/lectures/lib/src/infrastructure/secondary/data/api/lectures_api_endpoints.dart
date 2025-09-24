class LecturesApiEndpoints {
  static String lecturesByFaculty(int facultyId, {int termId = 1, int year = 2025}) =>
      '/course-by-faculty?faculty_id=$facultyId&term_id=$termId&year=$year';
}
