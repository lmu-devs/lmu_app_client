// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_list_wrapper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesListWrapperDto _$CoursesListWrapperDtoFromJson(
        Map<String, dynamic> json) =>
    CoursesListWrapperDto(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CoursesListWrapperDtoToJson(
        CoursesListWrapperDto instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'totalCount': instance.totalCount,
      'pageSize': instance.pageSize,
      'currentPage': instance.currentPage,
    };
