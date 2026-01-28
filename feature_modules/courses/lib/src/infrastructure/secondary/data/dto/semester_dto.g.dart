// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterDto _$SemesterDtoFromJson(Map<String, dynamic> json) => SemesterDto(
      year: (json['year'] as num).toInt(),
      semesterType: json['semester_type'] as String,
    );

Map<String, dynamic> _$SemesterDtoToJson(SemesterDto instance) =>
    <String, dynamic>{
      'year': instance.year,
      'semester_type': instance.semesterType,
    };
