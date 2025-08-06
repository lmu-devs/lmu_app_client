import 'package:core/api.dart';

import '../../../../domain/exception/lectures_generic_exception.dart';
import '../dto/course_dto.dart';
import '../dto/lectures_dto.dart';

class LecturesApiClient {
  const LecturesApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<LecturesDto> getLectures() async {
    // TODO: Remove mock data when server is working
    // Mock data for testing
    return const LecturesDto(
      id: 'natural_computing_general',
      name: 'Natural Computing',
    );

    // Original API call (commented out until server is fixed)
    // final response = await _baseApiClient.get(LecturesApiEndpoints.lectures);
    // return LecturesDto.fromJson(jsonDecode(response.body));
  }

  Future<List<CourseDto>> getCoursesByFaculty(int facultyId) async {
    if (facultyId <= 0) {
      throw const LecturesGenericException();
    }

    // TODO: Remove mock data when server is working
    // Mock data for testing - Multiple courses for each faculty
    return [
      CourseDto(
        id: 'natural_computing_$facultyId',
        name: 'Natural Computing',
        facultyId: facultyId,
        description:
            'This course explores computational methods inspired by natural systems, including neural networks, genetic algorithms, and evolutionary computation.',
        credits: 6,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'machine_learning_$facultyId',
        name: 'Machine Learning',
        facultyId: facultyId,
        description: 'Introduction to machine learning algorithms and their applications in data science.',
        credits: 8,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'data_structures_$facultyId',
        name: 'Data Structures & Algorithms',
        facultyId: facultyId,
        description: 'Fundamental data structures and algorithms for efficient problem solving.',
        credits: 6,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'software_engineering_$facultyId',
        name: 'Software Engineering',
        facultyId: facultyId,
        description:
            'Principles and practices of software development, including design patterns, testing, and project management.',
        credits: 7,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'database_systems_$facultyId',
        name: 'Database Systems',
        facultyId: facultyId,
        description: 'Design and implementation of database systems, SQL, and data modeling techniques.',
        credits: 5,
        semester: 'Winter 25/26',
      ),
      CourseDto(
        id: 'computer_networks_$facultyId',
        name: 'Computer Networks',
        facultyId: facultyId,
        description: 'Network protocols, architecture, and communication systems in distributed computing.',
        credits: 6,
        semester: 'Winter 25/26',
      ),
    ];

    // Original API call (commented out until server is fixed)
    // final response = await _baseApiClient.get(LecturesApiEndpoints.courseByFaculty(facultyId));
    //
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => CourseDto.fromJson(json)).toList();
    // } else {
    //   throw const LecturesGenericException();
    // }
  }

  Future<Map<String, dynamic>> getCourseDetails(String courseId) async {
    // TODO: Remove mock data when server is working
    // Mock API call for course details
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    if (courseId.contains('data_structures')) {
      return {
        'id': courseId,
        'name': 'Data Structures & Algorithms',
        'description':
            'This course covers fundamental data structures and algorithms essential for efficient problem solving in computer science.',
        'credits': 6,
        'semester': 'Winter 25/26',
        'language': 'German',
        'maxParticipants': 120,
        'registrationDeadline': '15.10.2024',
        'examRegistrationDeadline': '30.11.2024',
        'examDate': '15.02.2025',
        'schedule': {
          'time': 'wöchtl., Mo, 14:15-15:45',
          'duration': '12.05.2025 - 23.07.2025',
          'address': 'Luisenstr. 37 (C)',
          'room': 'C 006',
        },
        'content': {
          'courseContent':
              'This course covers fundamental data structures and algorithms essential for efficient problem solving in computer science.',
          'learningObjectives': [
            'Understanding of basic data structures (arrays, linked lists, stacks, queues)',
            'Implementation of sorting and searching algorithms',
            'Analysis of algorithm complexity and efficiency',
            'Application of data structures to real-world problems',
          ],
          'prerequisites': 'Basic programming knowledge in Java or C++, fundamental mathematics.',
        },
        'lecturers': [
          'Prof. Dr. Sarah Müller',
          'Dr. Hans Weber',
          'M.Sc. Lisa Schmidt',
        ],
        'studyPrograms': [
          {
            'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
            'programs': [
              {'name': 'Informatik', 'degree': 'Bachelor'},
              {'name': 'Mediinfo', 'degree': 'Bachelor'},
            ],
          },
          {
            'faculty': 'Fakultät für Physik',
            'programs': [
              {'name': 'Physik', 'degree': 'Bachelor'},
            ],
          },
        ],
        'literature': [
          '"Data Structures and Algorithms in Java" by Robert Lafore',
          '"Introduction to Algorithms" by Thomas H. Cormen',
          'Additional materials provided in the course',
        ],
        'notes':
            'The course includes practical programming assignments and a final project. Regular attendance is required for exam eligibility.',
        'links': [
          {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/data-structures'},
          {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/67890'},
          {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/data-structures'},
          {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/data-structures'},
          {'type': 'Forum', 'url': 'forum.lmu.de/data-structures'},
        ],
        'usefulResources': [
          'GitHub Repository with code examples',
          'YouTube playlist with lecture recordings',
          'Data Structures research group',
          'Algorithm visualization tools',
        ],
        'ratings': {
          'overall': 4.2,
          'totalRatings': 45,
          'categories': {
            'explanation': 4.1,
            'materials': 4.3,
            'effort': 3.8,
            'teacher': 4.5,
            'exam': 4.0,
          },
        },
      };
    } else if (courseId.contains('software_engineering')) {
      return {
        'id': courseId,
        'name': 'Software Engineering',
        'description':
            'Principles and practices of software development, including design patterns, testing, and project management.',
        'credits': 7,
        'semester': 'Winter 25/26',
        'language': 'English',
        'maxParticipants': 90,
        'registrationDeadline': '15.10.2024',
        'examRegistrationDeadline': '30.11.2024',
        'examDate': '15.02.2025',
        'schedule': {
          'time': 'wöchtl., Di, 10:15-11:45',
          'duration': '12.05.2025 - 23.07.2025',
          'address': 'Luisenstr. 37 (C)',
          'room': 'C 008',
        },
        'content': {
          'courseContent':
              'This course covers software engineering principles, methodologies, and best practices for developing high-quality software systems.',
          'learningObjectives': [
            'Understanding of software development lifecycle',
            'Implementation of design patterns and architectural principles',
            'Testing strategies and quality assurance',
            'Project management and team collaboration',
          ],
          'prerequisites': 'Basic programming experience, understanding of object-oriented concepts.',
        },
        'lecturers': [
          'Prof. Dr. Michael Johnson',
          'Dr. Emma Davis',
          'M.Sc. Alex Chen',
        ],
        'studyPrograms': [
          {
            'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
            'programs': [
              {'name': 'Informatik', 'degree': 'Master'},
              {'name': 'Mediinfo', 'degree': 'Master'},
            ],
          },
        ],
        'literature': [
          '"Clean Code" by Robert C. Martin',
          '"Design Patterns" by Gang of Four',
          'Additional materials provided in the course',
        ],
        'notes':
            'The course includes group projects and practical software development experience. Regular attendance is required.',
        'links': [
          {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/software-engineering'},
          {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/67891'},
          {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/software-engineering'},
          {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/software-engineering'},
          {'type': 'Forum', 'url': 'forum.lmu.de/software-engineering'},
        ],
        'usefulResources': [
          'GitHub Repository with project templates',
          'YouTube playlist with development tutorials',
          'Software Engineering research group',
          'Industry case studies',
        ],
        'ratings': {
          'overall': 4.0,
          'totalRatings': 38,
          'categories': {
            'explanation': 4.2,
            'materials': 3.9,
            'effort': 3.5,
            'teacher': 4.3,
            'exam': 3.8,
          },
        },
      };
    } else if (courseId.contains('database_systems')) {
      return {
        'id': courseId,
        'name': 'Database Systems',
        'description': 'Design and implementation of database systems, SQL, and data modeling techniques.',
        'credits': 5,
        'semester': 'Winter 25/26',
        'language': 'German',
        'maxParticipants': 75,
        'registrationDeadline': '15.10.2024',
        'examRegistrationDeadline': '30.11.2024',
        'examDate': '15.02.2025',
        'schedule': {
          'time': 'wöchtl., Mi, 16:15-17:45',
          'duration': '12.05.2025 - 23.07.2025',
          'address': 'Luisenstr. 37 (C)',
          'room': 'C 010',
        },
        'content': {
          'courseContent': 'This course covers database design, SQL programming, and data management systems.',
          'learningObjectives': [
            'Understanding of relational database concepts',
            'SQL programming and query optimization',
            'Database design and normalization',
            'Data modeling and ER diagrams',
          ],
          'prerequisites': 'Basic programming knowledge, understanding of data structures.',
        },
        'lecturers': [
          'Prof. Dr. Anna Schmidt',
          'Dr. Thomas Müller',
          'M.Sc. Julia Weber',
        ],
        'studyPrograms': [
          {
            'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
            'programs': [
              {'name': 'Informatik', 'degree': 'Bachelor'},
              {'name': 'Mediinfo', 'degree': 'Bachelor'},
            ],
          },
        ],
        'literature': [
          '"Database System Concepts" by Silberschatz',
          '"SQL for Mere Mortals" by Michael J. Hernandez',
          'Additional materials provided in the course',
        ],
        'notes': 'The course includes hands-on database projects and SQL exercises. Regular attendance is required.',
        'links': [
          {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/database-systems'},
          {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/67892'},
          {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/database-systems'},
          {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/database-systems'},
          {'type': 'Forum', 'url': 'forum.lmu.de/database-systems'},
        ],
        'usefulResources': [
          'GitHub Repository with database examples',
          'YouTube playlist with SQL tutorials',
          'Database research group',
          'Online SQL practice platform',
        ],
        'ratings': {
          'overall': 3.9,
          'totalRatings': 42,
          'categories': {
            'explanation': 4.0,
            'materials': 3.8,
            'effort': 3.2,
            'teacher': 4.1,
            'exam': 3.7,
          },
        },
      };
    } else if (courseId.contains('computer_networks')) {
      return {
        'id': courseId,
        'name': 'Computer Networks',
        'description': 'Network protocols, architecture, and communication systems in distributed computing.',
        'credits': 6,
        'semester': 'Winter 25/26',
        'language': 'English',
        'maxParticipants': 85,
        'registrationDeadline': '15.10.2024',
        'examRegistrationDeadline': '30.11.2024',
        'examDate': '15.02.2025',
        'schedule': {
          'time': 'wöchtl., Do, 14:15-15:45',
          'duration': '12.05.2025 - 23.07.2025',
          'address': 'Luisenstr. 37 (C)',
          'room': 'C 012',
        },
        'content': {
          'courseContent':
              'This course covers network protocols, architecture, and communication systems in distributed computing environments.',
          'learningObjectives': [
            'Understanding of network protocols and architecture',
            'Implementation of network applications',
            'Network security and performance analysis',
            'Distributed systems and communication',
          ],
          'prerequisites': 'Basic programming knowledge, understanding of computer architecture.',
        },
        'lecturers': [
          'Prof. Dr. David Wilson',
          'Dr. Maria Garcia',
          'M.Sc. Peter Brown',
        ],
        'studyPrograms': [
          {
            'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
            'programs': [
              {'name': 'Informatik', 'degree': 'Master'},
              {'name': 'Mediinfo', 'degree': 'Master'},
            ],
          },
        ],
        'literature': [
          '"Computer Networks" by Andrew Tanenbaum',
          '"TCP/IP Illustrated" by W. Richard Stevens',
          'Additional materials provided in the course',
        ],
        'notes':
            'The course includes network simulation projects and practical exercises. Regular attendance is required.',
        'links': [
          {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/computer-networks'},
          {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/67893'},
          {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/computer-networks'},
          {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/computer-networks'},
          {'type': 'Forum', 'url': 'forum.lmu.de/computer-networks'},
        ],
        'usefulResources': [
          'GitHub Repository with network examples',
          'YouTube playlist with network tutorials',
          'Networks research group',
          'Network simulation tools',
        ],
        'ratings': {
          'overall': 4.1,
          'totalRatings': 35,
          'categories': {
            'explanation': 4.3,
            'materials': 4.0,
            'effort': 3.6,
            'teacher': 4.2,
            'exam': 3.9,
          },
        },
      };
    } else {
      // Default response for other courses
      return {
        'id': courseId,
        'name': 'Natural Computing',
        'description': 'This course explores computational methods inspired by natural systems.',
        'credits': 6,
        'semester': 'Winter 25/26',
        'language': 'English',
        'maxParticipants': 80,
        'registrationDeadline': '15.10.2024',
        'examRegistrationDeadline': '30.11.2024',
        'examDate': '15.02.2025',
        'schedule': {
          'time': 'wöchtl., Mo, 16:15-17:45',
          'duration': '12.05.2025 - 23.07.2025',
          'address': 'Luisenstr. 37 (C)',
          'room': 'C 006',
        },
        'content': {
          'courseContent':
              'This course explores computational methods inspired by natural systems, including neural networks, genetic algorithms, and evolutionary computation.',
          'learningObjectives': [
            'Understanding of biological principles behind Natural Computing',
            'Implementation of bio-inspired algorithms',
            'Application to practical problems',
            'Critical evaluation of methods',
          ],
          'prerequisites':
              'Basic knowledge in algorithms and data structures, programming experience in Python or Java.',
        },
        'lecturers': [
          'Prof. Dr. Max Mustermann',
          'Dr. Anna Schmidt',
          'M.Sc. Tom Weber',
        ],
        'studyPrograms': [
          {
            'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
            'programs': [
              {'name': 'Informatik', 'degree': 'Master'},
              {'name': 'Mediinfo', 'degree': 'Master'},
            ],
          },
          {
            'faculty': 'Fakultät für Physik',
            'programs': [
              {'name': 'Physik', 'degree': 'Master'},
            ],
          },
        ],
        'literature': [
          '"Natural Computing: An Introduction" von Wolfgang Banzhaf',
          '"Bio-inspired Algorithms for Optimization" von Xin-She Yang',
          'Aktuelle Forschungsartikel werden im Kurs bereitgestellt',
        ],
        'notes':
            'Die Vorlesung wird durch praktische Übungen und ein Projekt ergänzt. Teilnahme an den Übungen ist für die Prüfungszulassung erforderlich.',
        'links': [
          {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/natural-computing'},
          {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/12345'},
          {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/natural-computing'},
          {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/natural-computing'},
          {'type': 'Forum', 'url': 'forum.lmu.de/natural-computing'},
        ],
        'usefulResources': [
          'GitHub Repository mit Code-Beispielen',
          'YouTube-Playlist mit Vorlesungsaufzeichnungen',
          'Forschungsgruppe Natural Computing',
          'Konferenz-Website ICARIS',
        ],
        'ratings': {
          'overall': 3.8,
          'totalRatings': 39,
          'categories': {
            'explanation': 3.2,
            'materials': 3.8,
            'effort': 2.2,
            'teacher': 4.1,
            'exam': 1.2,
          },
        },
      };
    }

    // Original API call (commented out until server is fixed)
    // final response = await _baseApiClient.get(LecturesApiEndpoints.courseDetails(courseId));
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   throw const LecturesGenericException();
    // }

    return {
      'id': courseId,
      'name': 'Natural Computing',
      'description': 'This course explores computational methods inspired by natural systems.',
      'credits': 6,
      'semester': 'Winter 25/26',
      'language': 'English',
      'maxParticipants': 80,
      'registrationDeadline': '15.10.2024',
      'examRegistrationDeadline': '30.11.2024',
      'examDate': '15.02.2025',
      'schedule': {
        'time': 'wöchtl., Mo, 16:15-17:45',
        'duration': '12.05.2025 - 23.07.2025',
        'address': 'Luisenstr. 37 (C)',
        'room': 'C 006',
      },
      'content': {
        'courseContent':
            'This course explores computational methods inspired by natural systems, including neural networks, genetic algorithms, and evolutionary computation.',
        'learningObjectives': [
          'Understanding of biological principles behind Natural Computing',
          'Implementation of bio-inspired algorithms',
          'Application to practical problems',
          'Critical evaluation of methods',
        ],
        'prerequisites': 'Basic knowledge in algorithms and data structures, programming experience in Python or Java.',
      },
      'lecturers': [
        'Prof. Dr. Max Mustermann',
        'Dr. Anna Schmidt',
        'M.Sc. Tom Weber',
      ],
      'studyPrograms': [
        {
          'faculty': 'Fakultät für Mathematik, Informatik und Statistik',
          'programs': [
            {'name': 'Informatik', 'degree': 'Master'},
            {'name': 'Mediinfo', 'degree': 'Master'},
          ],
        },
        {
          'faculty': 'Fakultät für Physik',
          'programs': [
            {'name': 'Physik', 'degree': 'Master'},
          ],
        },
      ],
      'literature': [
        '"Natural Computing: An Introduction" von Wolfgang Banzhaf',
        '"Bio-inspired Algorithms for Optimization" von Xin-She Yang',
        'Aktuelle Forschungsartikel werden im Kurs bereitgestellt',
      ],
      'notes':
          'Die Vorlesung wird durch praktische Übungen und ein Projekt ergänzt. Teilnahme an den Übungen ist für die Prüfungszulassung erforderlich.',
      'links': [
        {'type': 'Moodle-Kurs', 'url': 'moodle.lmu.de/natural-computing'},
        {'type': 'LSF-Veranstaltung', 'url': 'lsf.lmu.de/event/12345'},
        {'type': 'Vorlesungsfolien', 'url': 'slides.lmu.de/natural-computing'},
        {'type': 'Übungsblätter', 'url': 'exercises.lmu.de/natural-computing'},
        {'type': 'Forum', 'url': 'forum.lmu.de/natural-computing'},
      ],
      'usefulResources': [
        'GitHub Repository mit Code-Beispielen',
        'YouTube-Playlist mit Vorlesungsaufzeichnungen',
        'Forschungsgruppe Natural Computing',
        'Konferenz-Website ICARIS',
      ],
      'ratings': {
        'overall': 3.8,
        'totalRatings': 39,
        'categories': {
          'explanation': 3.2,
          'materials': 3.8,
          'effort': 2.2,
          'teacher': 4.1,
          'exam': 1.2,
        },
      },
    };
  }
}
