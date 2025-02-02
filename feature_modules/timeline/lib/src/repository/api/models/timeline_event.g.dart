// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) => TimelineEvent(
      title: json['title'] as String,
      type: json['type'] as String,
      timeframe: TimelineTimeframe.fromJson(json['timeframe'] as Map<String, dynamic>),
      description: json['description'] as String?,
      location: json['location'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$TimelineEventToJson(TimelineEvent instance) => <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'timeframe': instance.timeframe,
      'description': instance.description,
      'location': instance.location,
      'url': instance.url,
    };
