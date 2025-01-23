// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsModel _$SportsModelFromJson(Map<String, dynamic> json) => SportsModel(
      title: json['title'] as String,
      courses: (json['courses'] as List<dynamic>).map((e) => SportsCourse.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$SportsModelToJson(SportsModel instance) => <String, dynamic>{
      'title': instance.title,
      'courses': instance.courses,
    };
