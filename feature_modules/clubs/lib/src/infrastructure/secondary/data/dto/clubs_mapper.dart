import '../../../../domain/models/club.dart';
import '../../../../domain/models/club_category.dart';
import '../../../../domain/models/club_type.dart';
import 'clubs_dto.dart';

class ClubsMapper {
  static const _featuredClubId = '4';

  static List<ClubCategory> mapToDomain(ClubsDto dto) {
    final clubMap = {
      for (final club in dto.clubs) club.id: club,
    };

    return dto.clubCategories.map((categoryDto) {
      final clubs = categoryDto.clubIds
          .map((id) => clubMap[id])
          .where((club) => club != null)
          .map((club) => Club(
                id: club!.id,
                universityId: club.universityId,
                type: _mapType(club.type),
                title: club.title,
                description: club.description,
                isFeatured: club.id == _featuredClubId,
                image: club.image,
                content: club.content,
                url: club.url,
                email: club.email,
                instagramUrl: club.instagramUrl,
                linkedinUrl: club.linkedinUrl,
                foundingYear: club.foundingYear,
                location: club.location,
              ))
          .toList();

      return ClubCategory(
        id: categoryDto.id,
        title: categoryDto.title,
        description: categoryDto.description,
        emoji: categoryDto.emoji,
        clubs: clubs,
      );
    }).toList();
  }

  static ClubType _mapType(String? type) {
    return switch (type) {
      'FS' => ClubType.fachschaft,
      'HG' => ClubType.hochschulgruppe,
      'RT' => ClubType.referat,
      'VN' => ClubType.verein,
      'IN' => ClubType.institution,
      _ => throw ArgumentError('Unknown club type: $type'),
    };
  }
}
