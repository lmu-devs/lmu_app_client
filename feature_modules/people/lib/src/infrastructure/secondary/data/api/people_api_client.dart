import 'package:core/api.dart';

import '../dto/people_dto.dart';
import '../dto/people_list_wrapper_dto.dart';

class PeopleApiClient {
  const PeopleApiClient(this._baseApiClient);

  final BaseApiClient _baseApiClient;

  Future<PeopleListWrapperDto> getPeople() async {
    //final response = await _baseApiClient.get(PeopleApiEndpoints.people);
    //return PeopleListWrapperDto.fromJson(jsonDecode(response.body));

    final people = [
      const PeopleDto(
        id: 1,
        name: 'Max',
        surname: 'Alstermann',
        title: 'Wis. Mitarbeiter',
        academicDegree: null,
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Wissenschaftlicher Mitarbeiter',
        email: 'max.alstermann@lmu.de',
        phone: '+49 89 2180-4444',
        website: 'https://www.lmu.de/alstermann',
        room: 'Oettingenstraße 67, Raum 123',
        consultation: 'Dienstag 14:00-16:00',
      ),
      const PeopleDto(
        id: 2,
        name: 'Erika',
        surname: 'Alsterfrau',
        title: 'Lehrbeauftragte',
        academicDegree: 'Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Lehrbeauftragte',
        email: 'erika.alsterfrau@lmu.de',
        phone: '+49 89 2180-5555',
        website: 'https://www.lmu.de/alsterfrau',
        room: 'Oettingenstraße 67, Raum 124',
        consultation: 'Mittwoch 10:00-12:00',
      ),
      const PeopleDto(
        id: 3,
        name: 'Maxime',
        surname: 'Ralsterfrau',
        title: 'Professorin',
        academicDegree: 'Prof. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professorin für Informatik',
        email: 'maxime.ralsterfrau@lmu.de',
        phone: '+49 89 2180-6666',
        website: 'https://www.lmu.de/ralsterfrau',
        room: 'Oettingenstraße 67, Raum 201',
        consultation: 'Donnerstag 13:00-15:00',
      ),
      const PeopleDto(
        id: 4,
        name: 'Erika',
        surname: 'Alsterfrau',
        title: 'Professorin',
        academicDegree: 'Prof. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professorin für Statistik',
        email: 'erika.alsterfrau2@lmu.de',
        phone: '+49 89 2180-7777',
        website: 'https://www.lmu.de/alsterfrau2',
        room: 'Oettingenstraße 67, Raum 202',
        consultation: 'Freitag 09:00-11:00',
      ),
      const PeopleDto(
        id: 5,
        name: 'Frank',
        surname: 'Au',
        title: 'Professor',
        academicDegree: 'Prof. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professor für Mathematik',
        email: 'frank.au@lmu.de',
        phone: '+49 89 2180-8888',
        website: 'https://www.lmu.de/au',
        room: 'Oettingenstraße 67, Raum 301',
        consultation: 'Montag 15:00-17:00',
      ),
      const PeopleDto(
        id: 6,
        name: 'Max',
        surname: 'Alster',
        title: 'Professor',
        academicDegree: 'Prof. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professor für Informatik',
        email: 'max.alster@lmu.de',
        phone: '+49 89 2180-9999',
        website: 'https://www.lmu.de/alster',
        room: 'Oettingenstraße 67, Raum 302',
        consultation: 'Dienstag 10:00-12:00',
      ),
      const PeopleDto(
        id: 7,
        name: 'Marc',
        surname: 'Besterau',
        title: 'Professor',
        academicDegree: 'Prof. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professor für Statistik',
        email: 'marc.besterau@lmu.de',
        phone: '+49 89 2180-1111',
        website: 'https://www.lmu.de/besterau',
        room: 'Oettingenstraße 67, Raum 401',
        consultation: 'Mittwoch 14:00-16:00',
      ),
      const PeopleDto(
        id: 8,
        name: 'Lisa',
        surname: 'Best',
        title: 'Professorin',
        academicDegree: 'Prof. Med. Dr.',
        facultyId: 1,
        faculty: 'Fakultät für Mathematik, Informatik und Statistik',
        role: 'Professorin für Medizinische Informatik',
        email: 'lisa.best@lmu.de',
        phone: '+49 89 2180-2222',
        website: 'https://www.lmu.de/best',
        room: 'Oettingenstraße 67, Raum 402',
        consultation: 'Donnerstag 11:00-13:00',
      ),
    ];

    return PeopleListWrapperDto(
      people: people,
      totalCount: people.length,
      pageSize: people.length,
      currentPage: 1,
    );
  }
}
