// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterModel _$SemesterModelFromJson(Map<String, dynamic> json) =>
    SemesterModel(
      year: (json['year'] as num).toInt(),
      semesterType: json['semester_type'] as String,
    );

Map<String, dynamic> _$SemesterModelToJson(SemesterModel instance) =>
    <String, dynamic>{
      'year': instance.year,
      'semester_type': instance.semesterType,
    };
