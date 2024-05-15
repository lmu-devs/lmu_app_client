// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_opening_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaOpeningHours _$MensaOpeningHoursFromJson(Map<String, dynamic> json) =>
    MensaOpeningHours(
      mon: MensaDayHours.fromJson(json['mon'] as Map<String, dynamic>),
      tue: MensaDayHours.fromJson(json['tue'] as Map<String, dynamic>),
      wed: MensaDayHours.fromJson(json['wed'] as Map<String, dynamic>),
      thu: MensaDayHours.fromJson(json['thu'] as Map<String, dynamic>),
      fri: MensaDayHours.fromJson(json['fri'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MensaOpeningHoursToJson(MensaOpeningHours instance) =>
    <String, dynamic>{
      'mon': instance.mon,
      'tue': instance.tue,
      'wed': instance.wed,
      'thu': instance.thu,
      'fri': instance.fri,
    };
