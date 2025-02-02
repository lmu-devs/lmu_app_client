// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_timeframe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineTimeframe _$TimelineTimeframeFromJson(Map<String, dynamic> json) => TimelineTimeframe(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$TimelineTimeframeToJson(TimelineTimeframe instance) => <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
