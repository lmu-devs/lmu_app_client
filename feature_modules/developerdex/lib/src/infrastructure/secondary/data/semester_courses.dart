import 'package:core/constants.dart';

import '../../../domain/model/lmu_developer.dart';
import '../../../domain/model/semester.dart';
import '../../../domain/model/semester_course.dart';

const List<SemesterCourse> semesterCourses = [
  SemesterCourse(
    semester: Semester.winter24_25,
    developers: [
      LmuDeveloper(
        id: '1',
        name: 'Alice',
        asset: LmuAnimalAssets.lion,
      ),
      LmuDeveloper(
        id: '2',
        name: 'Bob',
        asset: LmuAnimalAssets.lion,
      ),
      LmuDeveloper(
        id: '3',
        name: 'Charlie',
        asset: LmuAnimalAssets.lion,
      ),
    ],
  ),
  SemesterCourse(
    semester: Semester.summer25,
    developers: [],
  ),
];
