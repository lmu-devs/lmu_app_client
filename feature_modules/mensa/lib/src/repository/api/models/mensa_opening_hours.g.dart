// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_opening_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaOpeningHours _$MensaOpeningHoursFromJson(Map<String, dynamic> json) =>
    MensaOpeningHours(
      day: json['day'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$MensaOpeningHoursToJson(MensaOpeningHours instance) =>
    <String, dynamic>{
      'day': instance.day,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
