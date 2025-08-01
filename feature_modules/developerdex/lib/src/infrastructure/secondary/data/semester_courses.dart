import '../../../domain/model/animal.dart';
import '../../../domain/model/lmu_developer.dart';
import '../../../domain/model/rarity.dart';
import '../../../domain/model/semester.dart';
import '../../../domain/model/semester_course.dart';

const List<SemesterCourse> semesterCourses = [
  SemesterCourse(
    state: SemesterState.finished,
    semester: Semester.winter24_25,
    developers: [
      LmuDeveloper(
        id: '1',
        name: 'Raffi',
        animal: Animal.smokingApe,
        rarity: Rarity.legendary,
        tags: [
          'Co-Founder',
          'Backend Development',
          'UI/UX Design',
        ],
      ),
      LmuDeveloper(
        id: '2',
        name: 'Lukas',
        animal: Animal.aperolCat,
        rarity: Rarity.legendary,
        tags: [
          'Co-Founder',
          'Frontend Development',
          'Release Management',
          'App Marketing',
        ],
      ),
      LmuDeveloper(
        id: '3',
        name: 'Paul',
        animal: Animal.spaceCapybara,
        rarity: Rarity.legendary,
        tags: [
          'Co-Founder',
          'Frontend Development',
          'App Architecture',
        ],
      ),
    ],
  ),
  SemesterCourse(
    state: SemesterState.inProgress,
    semester: Semester.summer25,
    developers: [],
  ),
  SemesterCourse(
    state: SemesterState.upcoming,
    semester: Semester.winter25_26,
    developers: [],
  ),
];
