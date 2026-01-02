// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_semesters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSemestersModel _$AvailableSemestersModelFromJson(
        Map<String, dynamic> json) =>
    AvailableSemestersModel(
      semesters: (json['semesters'] as List<dynamic>)
          .map((e) => SemesterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentSemester: SemesterModel.fromJson(
          json['current_semester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableSemestersModelToJson(
        AvailableSemestersModel instance) =>
    <String, dynamic>{
      'semesters': instance.semesters,
      'current_semester': instance.currentSemester,
    };
