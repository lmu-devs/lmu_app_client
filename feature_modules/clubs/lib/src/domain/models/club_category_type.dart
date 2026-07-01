import 'package:core/localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum ClubCategoryType {
  @JsonValue('ACADEMIC')
  academic,
  @JsonValue('ART_CULTURE')
  artCulture,
  @JsonValue('LEISURE')
  leisure,
  @JsonValue('SPORT')
  sport,
  @JsonValue('CAREER')
  careerNetworking,
  @JsonValue('INTERNATIONAL')
  international,
}

extension ClubCategoryTypeExtension on ClubCategoryType {
  String localizedName(ClubsLocalizations localizations) {
    return switch (this) {
      ClubCategoryType.academic => localizations.categoryAcademic,
      ClubCategoryType.artCulture => localizations.categoryArtCulture,
      ClubCategoryType.leisure => localizations.categoryLeisure,
      ClubCategoryType.sport => localizations.categorySport,
      ClubCategoryType.careerNetworking => localizations.categoryCareerNetworking,
      ClubCategoryType.international => localizations.categoryInternational,
    };
  }
}
