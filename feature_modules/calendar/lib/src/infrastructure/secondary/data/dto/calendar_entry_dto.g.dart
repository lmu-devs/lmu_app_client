// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEntryDto _$CalendarEntryDtoFromJson(Map<String, dynamic> json) => CalendarEntryDto(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      allDay: json['allDay'] as bool,
      description: json['description'] as String?,
      address: json['address'] as String?,
      rule: json['rule'] == null ? null : CalendarRuleDto.fromJson(json['rule'] as Map<String, dynamic>),
      recurrenceId: (json['recurrenceId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CalendarEntryDtoToJson(CalendarEntryDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$EventTypeEnumMap[instance.type]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'allDay': instance.allDay,
      'color': const ColorConverter().toJson(instance.color),
      'location': instance.location,
      'description': instance.description,
      'address': instance.address,
      'rule': instance.rule,
      'recurrenceId': instance.recurrenceId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.movie: 'MOVIE',
  EventType.sport: 'SPORT',
  EventType.lecture: 'LECTURE',
  EventType.exam: 'EXAM',
};
