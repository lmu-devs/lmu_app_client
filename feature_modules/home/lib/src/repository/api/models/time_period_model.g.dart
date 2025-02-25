// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimePeriodModel _$TimePeriodModelFromJson(Map<String, dynamic> json) =>
    TimePeriodModel(
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$TimePeriodModelToJson(TimePeriodModel instance) =>
    <String, dynamic>{
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
    };
