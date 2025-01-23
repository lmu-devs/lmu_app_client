// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaLocationModel _$CinemaLocationModelFromJson(Map<String, dynamic> json) =>
    CinemaLocationModel(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CinemaLocationModelToJson(
        CinemaLocationModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
