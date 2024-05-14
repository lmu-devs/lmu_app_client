// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaModel _$MensaModelFromJson(Map<String, dynamic> json) => MensaModel(
      name: json['name'] as String,
      location:
          MensaLocation.fromJson(json['location'] as Map<String, dynamic>),
      canteenId: json['canteen_id'] as String,
      openingHours: MensaOpeningHours.fromJson(
          json['open_hours'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MensaModelToJson(MensaModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'canteen_id': instance.canteenId,
      'open_hours': instance.openingHours,
    };
