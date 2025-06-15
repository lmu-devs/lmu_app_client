import '../../../../domain/model/people.dart';
import '../../../../domain/model/people_category.dart';
import 'peoples_dto.dart';

class PeopleMapper {
  static List<PeopleCategory> mapToDomain(PeoplesDto dto) {
    final peopleMap = {
      for (final people in dto.peoples) people.id: people,
    };

    return dto.peopleTypes.map((typeDto) {
      final peoples = typeDto.peopleIds
          .map((id) => peopleMap[id])
          .where((b) => b != null)
          .map((people) => People(
                id: people!.id,
                name: people.name,
                description: people.description,
                email: people.email,
                phone: people.phone,
                office: people.office,
                url: people.url,
                faviconUrl: people.faviconUrl,
                aliases: const [],
              ))
          .toList();

      return PeopleCategory(
        name: typeDto.name,
        description: typeDto.description,
        emoji: typeDto.emoji,
        peoples: peoples,
      );
    }).toList();
  }
}
