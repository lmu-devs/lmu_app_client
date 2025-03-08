// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderCity _$RoomfinderCityFromJson(Map<String, dynamic> json) => RoomfinderCity(
      id: json['id'] as String,
      name: json['name'] as String,
      streets:
          (json['streets'] as List<dynamic>).map((e) => RoomfinderStreet.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$RoomfinderCityToJson(RoomfinderCity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'streets': instance.streets.map((e) => e.toJson()).toList(),
    };
