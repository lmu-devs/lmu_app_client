// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_day_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaDayHours _$MensaDayHoursFromJson(Map<String, dynamic> json) =>
    MensaDayHours(
      start: json['start_time'] as String,
      end: json['end_time'] as String,
    );

Map<String, dynamic> _$MensaDayHoursToJson(MensaDayHours instance) =>
    <String, dynamic>{
      'start_time': instance.start,
      'end_time': instance.end,
    };
