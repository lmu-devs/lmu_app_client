import '../../../../domain/models/club.dart';
import '../../../../domain/models/club_category.dart';
import '../../../../domain/models/club_category_type.dart';
import 'club_dto.dart';

class ClubsMapper {
  static const _featuredClubId = '4';

  static List<ClubCategory> mapToDomain(List<ClubDto> dtos) {
    final clubsByCategory = <ClubCategoryType, List<Club>>{};

    for (final dto in dtos) {
      final club = Club(
        id: dto.id,
        universityId: dto.universityId,
        type: dto.type,
        title: dto.title,
        description: dto.description,
        category: dto.category,
        isFeatured: dto.id == _featuredClubId,
        image: dto.image,
        content: dto.content,
        url: dto.url,
        email: dto.email,
        instagramUrl: dto.instagramUrl,
        linkedinUrl: dto.linkedinUrl,
      );

      clubsByCategory.putIfAbsent(dto.category, () => []).add(club);
    }

    return clubsByCategory.entries
        .map((entry) => ClubCategory(
              type: entry.key,
              clubs: entry.value,
            ))
        .toList();
  }
}
