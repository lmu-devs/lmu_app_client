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
  @JsonValue('CAREER_NETWORKING')
  careerNetworking,
  @JsonValue('INTERNATIONAL')
  international,
}

extension ClubCategoryTypeExtension on ClubCategoryType {
  String get displayName {
    switch (this) {
      case ClubCategoryType.academic:
        return 'Academic';
      case ClubCategoryType.artCulture:
        return 'Art & Culture';
      case ClubCategoryType.leisure:
        return 'Leisure';
      case ClubCategoryType.sport:
        return 'Sport';
      case ClubCategoryType.careerNetworking:
        return 'Career & Networking';
      case ClubCategoryType.international:
        return 'International';
    }
  }
}
