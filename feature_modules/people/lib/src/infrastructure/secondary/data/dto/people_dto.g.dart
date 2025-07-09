// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleDto _$PeopleDtoFromJson(Map<String, dynamic> json) => PeopleDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      surname: json['surname'] as String,
      title: json['title'] as String,
      academicDegree: json['academicDegree'] as String?,
      faculty: json['faculty'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      room: json['room'] as String,
      consultation: json['consultation'] as String,
    );

Map<String, dynamic> _$PeopleDtoToJson(PeopleDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'title': instance.title,
      'academicDegree': instance.academicDegree,
      'faculty': instance.faculty,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'room': instance.room,
      'consultation': instance.consultation,
    };
