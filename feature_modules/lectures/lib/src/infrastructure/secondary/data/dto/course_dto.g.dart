// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDto _$CourseDtoFromJson(Map<String, dynamic> json) => CourseDto(
      id: json['id'] as String,
      name: json['name'] as String,
      facultyId: (json['facultyId'] as num).toInt(),
      description: json['description'] as String?,
      credits: (json['credits'] as num?)?.toInt(),
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$CourseDtoToJson(CourseDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'facultyId': instance.facultyId,
      'description': instance.description,
      'credits': instance.credits,
      'semester': instance.semester,
    };
