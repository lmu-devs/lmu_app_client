// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHoursModel _$OpeningHoursModelFromJson(Map<String, dynamic> json) =>
    OpeningHoursModel(
      days: (json['days'] as List<dynamic>)
          .map((e) => OpeningDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpeningHoursModelToJson(OpeningHoursModel instance) =>
    <String, dynamic>{
      'days': instance.days,
    };
