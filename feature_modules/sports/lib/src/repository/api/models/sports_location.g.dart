// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsLocation _$SportsLocationFromJson(Map<String, dynamic> json) => SportsLocation(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$SportsLocationToJson(SportsLocation instance) => <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
