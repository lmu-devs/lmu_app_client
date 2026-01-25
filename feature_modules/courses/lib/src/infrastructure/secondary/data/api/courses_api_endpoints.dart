class CoursesApiEndpoints {
  static const String _base = 'course';

  static const String _facultyIdQuery = 'faculty_id';
  static const String _semesterTypeQuery = 'term_id';
  static const String _yearQuery = 'year';

  static const String _publishIdQuery = 'publish_id';

  static String availableSemesters() {
    return '/$_base/available-semesters';
  }

  static String coursesByFaculty(int facultyId) {
    return '/$_base/by-faculty?$_facultyIdQuery=$facultyId&semester_type=WINTER&year=2025';
  }

  static String courseDetails(int publishId) {
    return '/$_base/details?$_publishIdQuery=$publishId';
  }
}
