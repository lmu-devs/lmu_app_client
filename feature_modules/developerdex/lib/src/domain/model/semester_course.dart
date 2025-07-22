import 'lmu_developer.dart';
import 'semester.dart';

class SemesterCourse {
  const SemesterCourse({
    required this.semester,
    required this.developers,
  });

  final Semester semester;
  final List<LmuDeveloper> developers;
}
