import 'package:widget_driver/widget_driver.dart';

part 'people_details_page_driver.g.dart';

class PersonMock {
  final String id;
  final String name;
  final String surname;
  final String? academicDegree;
  final String role;

  const PersonMock({
    required this.id,
    required this.name,
    required this.surname,
    this.academicDegree,
    required this.role,
  });
}

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver {
  @TestDriverDefaultValue(
    const PersonMock(
      id: '0',
      name: 'Max',
      surname: 'Alster',
      academicDegree: 'Prof. Dr.',
      role: 'Professor',
    ),
  )
  final PersonMock person;

  PeopleDetailsPageDriver(
      {this.person = const PersonMock(
        id: '0',
        name: 'Max',
        surname: 'Alster',
        academicDegree: 'Prof. Dr.',
        role: 'Professor',
      )});

  // Dummy-Daten für Kontaktinfos
  String get faculty => "Fakultät für Betriebswirtschaft";
  String get role => "Professor Intern";
  String get email => "alster@ifi.lmu.de";
  String get phone => "089 / 12345";
  String get website => "alster.ifi.lmu.de";
  String get room => "A 320";
  String get consultation => "Dienstag, 14–16 Uhr";
}
