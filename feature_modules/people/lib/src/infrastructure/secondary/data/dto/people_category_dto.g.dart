// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleCategoryDto _$PeopleCategoryDtoFromJson(Map<String, dynamic> json) =>
    PeopleCategoryDto(
      name: json['name'] as String,
      people: (json['people'] as List<dynamic>)
          .map((e) => PeopleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeopleCategoryDtoToJson(PeopleCategoryDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'people': instance.people,
    };
