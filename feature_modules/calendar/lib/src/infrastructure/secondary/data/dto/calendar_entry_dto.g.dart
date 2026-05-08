// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEntryDto _$CalendarEntryDtoFromJson(Map<String, dynamic> json) =>
    CalendarEntryDto(
      id: json['id'] as String,
      title: json['title'] as String,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      color: _$JsonConverterFromJson<int, Color>(
          json['color'], const ColorConverter().fromJson),
      allDay: json['all_day'] as bool,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      onlineLink: json['online_link'] as String?,
      accessScope: (json['access_scope'] as num?)?.toInt(),
      description: json['description'] as String?,
      rule: json['rule'] == null
          ? null
          : CalendarRuleDto.fromJson(json['rule'] as Map<String, dynamic>),
      recurrenceId: (json['recurrence_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CalendarEntryDtoToJson(CalendarEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'all_day': instance.allDay,
      'color': _$JsonConverterToJson<int, Color>(
          instance.color, const ColorConverter().toJson),
      'location': instance.location,
      'online_link': instance.onlineLink,
      'access_scope': instance.accessScope,
      'description': instance.description,
      'rule': instance.rule,
      'recurrence_id': instance.recurrenceId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.movie: 'MOVIE',
  EventType.sport: 'SPORT',
  EventType.lecture: 'LECTURE',
  EventType.exam: 'EXAM',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
