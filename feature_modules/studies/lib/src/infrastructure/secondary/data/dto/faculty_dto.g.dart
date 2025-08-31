// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacultyDto _$FacultyDtoFromJson(Map<String, dynamic> json) => FacultyDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$FacultyDtoToJson(FacultyDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
