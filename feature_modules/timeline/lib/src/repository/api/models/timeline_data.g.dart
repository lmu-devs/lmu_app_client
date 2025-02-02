// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineData _$TimelineDataFromJson(Map<String, dynamic> json) => TimelineData(
      semesters: (json['semesters'] as List<dynamic>)
          .map((e) => TimelineSemester.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>).map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TimelineDataToJson(TimelineData instance) => <String, dynamic>{
      'semesters': instance.semesters,
      'events': instance.events,
    };
