// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsType _$SportsTypeFromJson(Map<String, dynamic> json) => SportsType(
      title: json['title'] as String,
      courses: (json['courses'] as List<dynamic>).map((e) => SportsCourse.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$SportsTypeToJson(SportsType instance) => <String, dynamic>{
      'title': instance.title,
      'courses': instance.courses,
    };
