// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningDayModel _$OpeningDayModelFromJson(Map<String, dynamic> json) =>
    OpeningDayModel(
      day: json['day'] as String,
      timeRanges: (json['time_ranges'] as List<dynamic>)
          .map((e) => TimeRangeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpeningDayModelToJson(OpeningDayModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time_ranges': instance.timeRanges,
    };
