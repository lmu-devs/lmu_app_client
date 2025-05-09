// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningDayModel _$OpeningDayModelFromJson(Map<String, dynamic> json) =>
    OpeningDayModel(
      day: json['day'] as String,
      timeframes: (json['timeframes'] as List<dynamic>)
          .map((e) => TimeframeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpeningDayModelToJson(OpeningDayModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'timeframes': instance.timeframes,
    };
