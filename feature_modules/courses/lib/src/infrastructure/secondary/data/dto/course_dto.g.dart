// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDto _$CourseDtoFromJson(Map<String, dynamic> json) => CourseDto(
      publishId: (json['publish_id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      language: json['language'] as String,
      sws: (json['sws'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseDtoToJson(CourseDto instance) => <String, dynamic>{
      'publish_id': instance.publishId,
      'name': instance.name,
      'sws': instance.sws,
      'type': instance.type,
      'language': instance.language,
    };
