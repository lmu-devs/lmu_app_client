import '../../../../domain/models/benefit.dart';
import '../../../../domain/models/benefit_category.dart';
import 'benefits_dto.dart';

class BenefitsMapper {
  static List<BenefitCategory> mapToDomain(BenefitsDto dto) {
    final benefitMap = {
      for (final benefit in dto.benefits) benefit.id: benefit,
    };

    return dto.benefitTypes.map((typeDto) {
      final benefits = typeDto.benefitIds
          .map((id) => benefitMap[id])
          .where((b) => b != null)
          .map((benefit) => Benefit(
                id: benefit!.id,
                title: benefit.title,
                description: benefit.description,
                url: benefit.url,
                faviconUrl: benefit.faviconUrl,
                imageUrl: benefit.image?.url,
                aliases: const [],
              ))
          .toList();

      return BenefitCategory(
        title: typeDto.title,
        description: typeDto.description,
        emoji: typeDto.emoji,
        benefits: benefits,
      );
    }).toList();
  }
}
