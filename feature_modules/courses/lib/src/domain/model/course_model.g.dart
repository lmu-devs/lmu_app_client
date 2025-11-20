// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      publishId: (json['publish_id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      language: json['language'] as String,
      degree: json['degree'] as String?,
      sws: (json['sws'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'publish_id': instance.publishId,
      'name': instance.name,
      'degree': instance.degree,
      'sws': instance.sws,
      'type': instance.type,
      'language': instance.language,
    };
