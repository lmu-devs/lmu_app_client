// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lectures_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LecturesDto _$LecturesDtoFromJson(Map<String, dynamic> json) => LecturesDto(
      id: json['id'] as String,
      title: json['title'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      facultyId: (json['facultyId'] as num).toInt(),
      description: json['description'] as String?,
      credits: (json['credits'] as num?)?.toInt(),
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$LecturesDtoToJson(LecturesDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tags': instance.tags,
      'facultyId': instance.facultyId,
      'description': instance.description,
      'credits': instance.credits,
      'semester': instance.semester,
    };
