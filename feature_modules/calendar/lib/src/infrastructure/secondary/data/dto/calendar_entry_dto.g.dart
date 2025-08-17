// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEntryDto _$CalendarEntryDtoFromJson(Map<String, dynamic> json) => CalendarEntryDto(
      id: json['id'] as String,
      title: json['title'] as String,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      startTime: DateTime.parse(json['start_date'] as String),
      endTime: DateTime.parse(json['end_date'] as String),
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      allDay: json['all_day'] as bool,
      description: json['description'] as String?,
      rule: json['rule'] == null ? null : CalendarRuleDto.fromJson(json['rule'] as Map<String, dynamic>),
      recurrenceId: (json['recurrence_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CalendarEntryDtoToJson(CalendarEntryDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'start_date': instance.startTime.toIso8601String(),
      'end_date': instance.endTime.toIso8601String(),
      'all_day': instance.allDay,
      'color': const ColorConverter().toJson(instance.color),
      'location': instance.location,
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
