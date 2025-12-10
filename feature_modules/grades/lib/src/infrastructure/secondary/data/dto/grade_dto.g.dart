// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeDto _$GradeDtoFromJson(Map<String, dynamic> json) => GradeDto(
      id: json['id'] as String,
      name: json['name'] as String,
      ects: (json['ects'] as num).toInt(),
      grade: (json['grade'] as num?)?.toDouble(),
      semester: json['semester'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$GradeDtoToJson(GradeDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ects': instance.ects,
      'grade': instance.grade,
      'semester': instance.semester,
      'isActive': instance.isActive,
    };
