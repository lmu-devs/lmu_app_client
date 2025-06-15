// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) => CalendarEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: (json['type']),
      color: Color(json['color'] as int),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
    };
