// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      submissionFee: json['submissionFee'] as String,
      lectureFreeTime: json['lectureFreeTime'] as String,
      lectureTime: json['lectureTime'] as String,
      links: (json['links'] as List<dynamic>)
          .map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'submissionFee': instance.submissionFee,
      'lectureFreeTime': instance.lectureFreeTime,
      'lectureTime': instance.lectureTime,
      'links': instance.links,
    };
