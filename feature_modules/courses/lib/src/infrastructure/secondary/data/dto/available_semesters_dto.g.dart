// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_semesters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSemestersDto _$AvailableSemestersDtoFromJson(
        Map<String, dynamic> json) =>
    AvailableSemestersDto(
      semesters: (json['semesters'] as List<dynamic>)
          .map((e) => SemesterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentSemester: SemesterDto.fromJson(
          json['current_semester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableSemestersDtoToJson(
        AvailableSemestersDto instance) =>
    <String, dynamic>{
      'semesters': instance.semesters,
      'current_semester': instance.currentSemester,
    };
