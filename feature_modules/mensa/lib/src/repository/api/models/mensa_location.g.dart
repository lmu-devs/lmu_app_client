// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaLocation _$MensaLocationFromJson(Map<String, dynamic> json) =>
    MensaLocation(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$MensaLocationToJson(MensaLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
