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
    state: SemesterState.finished,
    semester: Semester.summer25,
    developers: [
      LmuDeveloper(
        id: '4',
        name: 'Ralf',
        animal: Animal.hedgehog,
        rarity: Rarity.epic,
        tags: [
          'Calendar',
          'Backend Development',
        ],
      ),
      LmuDeveloper(
        id: '5',
        name: 'Philipp',
        animal: Animal.spaceCat,
        rarity: Rarity.epic,
        tags: [
          'Calendar',
          'Frontend Development',
        ],
      ),
      LmuDeveloper(
        id: '6',
        name: 'Leonie',
        animal: Animal.otter,
        rarity: Rarity.epic,
        tags: [
          'Courses',
          'UI/UX Design',
        ],
      ),
      LmuDeveloper(
        id: '7',
        name: 'Ruben',
        animal: Animal.duck,
        rarity: Rarity.epic,
        tags: [
          'Courses',
          'Backend Development',
        ],
      ),
      LmuDeveloper(
        id: '8',
        name: 'Mehyar',
        animal: Animal.fireHorse,
        rarity: Rarity.epic,
        tags: [
          'Courses',
          'Frontend Development',
        ],
      ),
      LmuDeveloper(
        id: '9',
        name: 'Anton',
        animal: Animal.platypus,
        rarity: Rarity.epic,
        tags: [
          'People',
          'Backend Development',
        ],
      ),
      LmuDeveloper(
        id: '10',
        name: 'Leonie',
        animal: Animal.leopard,
        rarity: Rarity.epic,
        tags: [
          'People',
          'Frontend Development',
        ],
      ),
    ],
  ),
  SemesterCourse(
    state: SemesterState.inProgress,
    semester: Semester.winter25_26,
    developers: [],
  ),
  SemesterCourse(
    state: SemesterState.upcoming,
    semester: Semester.summer26,
    developers: [],
  ),
];
