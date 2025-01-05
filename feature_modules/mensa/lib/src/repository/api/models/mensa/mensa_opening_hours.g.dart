// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_opening_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaOpeningHours _$MensaOpeningHoursFromJson(Map<String, dynamic> json) => MensaOpeningHours(
      openingHours: (json['opening_hours'] as List<dynamic>)
          .map((e) => MensaOpeningDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      servingHours: (json['serving_hours'] as List<dynamic>?)
          ?.map((e) => MensaOpeningDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MensaOpeningHoursToJson(MensaOpeningHours instance) => <String, dynamic>{
      'opening_hours': instance.openingHours,
      'serving_hours': instance.servingHours,
    };
