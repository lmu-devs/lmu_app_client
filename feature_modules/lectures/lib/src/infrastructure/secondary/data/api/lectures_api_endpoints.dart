class LecturesApiEndpoints {
  static const lectures = '/lectures';

  static String courseByFaculty(int facultyId) => '/course-by-faculty?faculty_id=$facultyId';
}
