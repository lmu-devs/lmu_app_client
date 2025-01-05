// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_opening_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaOpeningDetails _$MensaOpeningDetailsFromJson(Map<String, dynamic> json) => MensaOpeningDetails(
      day: $enumDecode(_$WeekdayEnumMap, json['day']),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$MensaOpeningDetailsToJson(MensaOpeningDetails instance) => <String, dynamic>{
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
