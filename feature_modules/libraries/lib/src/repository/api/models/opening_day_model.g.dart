// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningDayModel _$OpeningDayModelFromJson(Map<String, dynamic> json) =>
    OpeningDayModel(
      day: $enumDecode(_$WeekdayEnumMap, json['day']),
      timeframes: (json['timeframes'] as List<dynamic>)
          .map((e) => TimeframeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpeningDayModelToJson(OpeningDayModel instance) =>
    <String, dynamic>{
      'day': _$WeekdayEnumMap[instance.day]!,
      'timeframes': instance.timeframes,
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
