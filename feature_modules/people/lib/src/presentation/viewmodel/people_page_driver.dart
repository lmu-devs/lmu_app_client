import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

part 'people_page_driver.g.dart';

class PersonMock {
  final String id;
  final String name;
  final String surname;
  final String? academicDegree;
  final String role;

  PersonMock({
    required this.id,
    required this.name,
    required this.surname,
    this.academicDegree,
    required this.role,
  });
}

@GenerateTestDriver()
class PeoplePageDriver extends WidgetDriver {
  // Dummy/Fake Data
  final List<PersonMock> _people = [
    PersonMock(
      id: '1',
      name: 'Max',
      surname: 'Alstermann',
      academicDegree: '',
      role: 'Wis. Mitarbeiter',
    ),
    PersonMock(
      id: '2',
      name: 'Erika',
      surname: 'Alsterfrau',
      academicDegree: '',
      role: 'Lehrbeauftragte',
    ),
    PersonMock(
      id: '3',
      name: 'Max',
      surname: 'Alster',
      academicDegree: 'Prof. Dr.',
      role: 'Professor',
    ),
    PersonMock(
      id: '4',
      name: 'Frank',
      surname: 'Au',
      academicDegree: 'Prof. Dr.',
      role: 'Professor',
    ),
    PersonMock(
      id: '5',
      name: 'Marc',
      surname: 'Besterau',
      academicDegree: 'Prof. Dr.',
      role: 'Professor',
    ),
    PersonMock(
      id: '6',
      name: 'Lisa',
      surname: 'Best',
      academicDegree: 'Prof. Med. Dr.',
      role: 'Professorin',
    ),
  ];

  String get facultyTitle => 'Fakultät für Mathematik, Informatik und Statistik';

  // Gruppierung nach Anfangsbuchstabe des Nachnamens
  Map<String, List<PersonMock>> get groupedPeople {
    final map = <String, List<PersonMock>>{};
    for (final person in _people) {
      final letter = person.surname.substring(0, 1).toUpperCase();
      map.putIfAbsent(letter, () => []).add(person);
    }
    return map;
  }

  void onPeopleCardPressed(BuildContext context, PersonMock person) {
    // Navigation oder Detailanzeige
    context.go('/studies/people/details', extra: person);
    print('Person tapped: ${person.name} ${person.surname}');
  }
}
