// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleTypeDto _$PeopleTypeDtoFromJson(Map<String, dynamic> json) =>
    PeopleTypeDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String,
      peopleIds: (json['people_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PeopleTypeDtoToJson(PeopleTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'emoji': instance.emoji,
      'people_ids': instance.peopleIds,
    };
