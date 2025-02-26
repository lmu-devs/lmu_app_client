// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      semesterFee: SemesterFeeModel.fromJson(
          json['semester_fee'] as Map<String, dynamic>),
      lectureFreeTime: TimePeriodModel.fromJson(
          json['lecture_free_time'] as Map<String, dynamic>),
      lectureTime: TimePeriodModel.fromJson(
          json['lecture_time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'semester_fee': instance.semesterFee,
      'lecture_free_time': instance.lectureFreeTime,
      'lecture_time': instance.lectureTime,
    };
