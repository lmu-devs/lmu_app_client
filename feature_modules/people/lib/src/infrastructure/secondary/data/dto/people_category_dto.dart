import 'package:json_annotation/json_annotation.dart';

import 'people_dto.dart';

part 'people_category_dto.g.dart';

@JsonSerializable()
class PeopleCategoryDto {
  final String name;
  final List<PeopleDto> people;

  PeopleCategoryDto({
    required this.name,
    required this.people,
  });

  factory PeopleCategoryDto.fromJsonEntry(MapEntry<String, dynamic> e) => PeopleCategoryDto(
        name: e.key,
        people: (e.value as List).map((p) => PeopleDto.fromJson(p as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => _$PeopleCategoryDtoToJson(this);

  // Hinzufügen der copyWith-Methode
  PeopleCategoryDto copyWith({
    String? name,
    List<PeopleDto>? people,
  }) {
    return PeopleCategoryDto(
      name: name ?? this.name,
      people: people ?? this.people,
    );
  }
}
