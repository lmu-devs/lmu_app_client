// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsDto _$CourseDetailsDtoFromJson(Map<String, dynamic> json) =>
    CourseDetailsDto(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      persons: (json['persons'] as List<dynamic>)
          .map((e) => PersonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalInformation: json['additional_information'] as String,
      lastUpdated: json['last_updated'] as String,
    );

Map<String, dynamic> _$CourseDetailsDtoToJson(CourseDetailsDto instance) =>
    <String, dynamic>{
      'sessions': instance.sessions,
      'persons': instance.persons,
      'additional_information': instance.additionalInformation,
      'last_updated': instance.lastUpdated,
    };
