// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
      firstName: json['first_name'] as String,
      lastName: json['surname'] as String,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PersonDtoToJson(PersonDto instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'surname': instance.lastName,
      'title': instance.title,
    };
