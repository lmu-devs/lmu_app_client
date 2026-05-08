// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsTimeSlot _$SportsTimeSlotFromJson(Map<String, dynamic> json) =>
    SportsTimeSlot(
      day: $enumDecode(_$WeekdayEnumMap, json['day']),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$SportsTimeSlotToJson(SportsTimeSlot instance) =>
    <String, dynamic>{
      'day': _$WeekdayEnumMap[instance.day]!,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'MONDAY',
  Weekday.tuesday: 'TUESDAY',
  Weekday.wednesday: 'WEDNESDAY',
  Weekday.thursday: 'THURSDAY',
  Weekday.friday: 'FRIDAY',
  Weekday.saturday: 'SATURDAY',
  Weekday.sunday: 'SUNDAY',
};
