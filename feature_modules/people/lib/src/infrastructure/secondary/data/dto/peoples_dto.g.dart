// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peoples_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeoplesDto _$PeoplesDtoFromJson(Map<String, dynamic> json) => PeoplesDto(
      peopleTypes: (json['people_types'] as List<dynamic>)
          .map((e) => PeopleTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      peoples: (json['peoples'] as List<dynamic>)
          .map((e) => PeopleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PeoplesDtoToJson(PeoplesDto instance) =>
    <String, dynamic>{
      'people_types': instance.peopleTypes.map((e) => e.toJson()).toList(),
      'peoples': instance.peoples.map((e) => e.toJson()).toList(),
    };
