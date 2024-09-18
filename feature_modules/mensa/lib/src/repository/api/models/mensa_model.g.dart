// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaModel _$MensaModelFromJson(Map<String, dynamic> json) => MensaModel(
      canteenId: json['canteen_id'] as String,
      name: json['name'] as String,
      location:
          MensaLocation.fromJson(json['location'] as Map<String, dynamic>),
      openingHours: (json['opening_hours'] as List<dynamic>)
          .map((e) => MensaOpeningHours.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MensaModelToJson(MensaModel instance) =>
    <String, dynamic>{
      'canteen_id': instance.canteenId,
      'name': instance.name,
      'location': instance.location,
      'opening_hours': instance.openingHours,
    };
