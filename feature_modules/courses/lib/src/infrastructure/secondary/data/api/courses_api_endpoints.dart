class CoursesApiEndpoints {
  static const String _facultyIdQuery = 'faculty_id';
  static const String _termIdQuery = 'term_id';
  static const String _yearQuery = 'year';

  static const String _publishIdQuery = 'publish_id';

  static String coursesByFaculty(int facultyId) {
    return '/course-by-faculty?$_facultyIdQuery=$facultyId&term_id=1&year=2025';
  }

  static String courseDetails(int publishId) {
    return '/course-details?$_publishIdQuery=$publishId';
  }
}
