// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_range_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRangeModel _$TimeRangeModelFromJson(Map<String, dynamic> json) =>
    TimeRangeModel(
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$TimeRangeModelToJson(TimeRangeModel instance) =>
    <String, dynamic>{
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
