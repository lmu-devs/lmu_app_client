// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineSemester _$TimelineSemesterFromJson(Map<String, dynamic> json) => TimelineSemester(
      timeframe: TimelineTimeframe.fromJson(json['timeframe'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$TimelineSemesterToJson(TimelineSemester instance) => <String, dynamic>{
      'timeframe': instance.timeframe,
      'type': instance.type,
    };
