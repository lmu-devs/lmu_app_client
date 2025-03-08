// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderLocation _$RoomfinderLocationFromJson(Map<String, dynamic> json) => RoomfinderLocation(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$RoomfinderLocationToJson(RoomfinderLocation instance) => <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
