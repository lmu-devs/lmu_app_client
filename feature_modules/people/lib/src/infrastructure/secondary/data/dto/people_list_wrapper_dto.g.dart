// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_list_wrapper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleListWrapperDto _$PeopleListWrapperDtoFromJson(Map<String, dynamic> json) => PeopleListWrapperDto(
      people: (json['people'] as List<dynamic>).map((e) => PeopleDto.fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PeopleListWrapperDtoToJson(PeopleListWrapperDto instance) => <String, dynamic>{
      'people': instance.people,
      'totalCount': instance.totalCount,
      'pageSize': instance.pageSize,
      'currentPage': instance.currentPage,
    };
