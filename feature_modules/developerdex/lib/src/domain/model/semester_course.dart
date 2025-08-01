import 'lmu_developer.dart';
import 'semester.dart';

class SemesterCourse {
  const SemesterCourse({
    required this.semester,
    required this.developers,
    required this.state,
  });

  final Semester semester;
  final List<LmuDeveloper> developers;
  final SemesterState state;
}
