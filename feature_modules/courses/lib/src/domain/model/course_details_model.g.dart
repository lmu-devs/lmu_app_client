// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsModelModel _$CourseDetailsModelModelFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsModelModel(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      persons: (json['persons'] as List<dynamic>)
          .map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalInformation: json['additional_information'] as String,
      lastUpdated: json['last_updated'] as String,
    );

Map<String, dynamic> _$CourseDetailsModelModelToJson(
        CourseDetailsModelModel instance) =>
    <String, dynamic>{
      'sessions': instance.sessions,
      'persons': instance.persons,
      'additional_information': instance.additionalInformation,
      'last_updated': instance.lastUpdated,
    };
