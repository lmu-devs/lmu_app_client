// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleDto _$PeopleDtoFromJson(Map<String, dynamic> json) => PeopleDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      email: json['email'] as String,
      office: json['office'] as String,
      phone: json['phone'] as String,
      faviconUrl: json['favicon_url'] as String,
    );

Map<String, dynamic> _$PeopleDtoToJson(PeopleDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'email': instance.email,
      'phone': instance.phone,
      'office': instance.office,
      'favicon_url': instance.faviconUrl,
    };
