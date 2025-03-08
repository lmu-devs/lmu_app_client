// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_street.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderStreet _$RoomfinderStreetFromJson(Map<String, dynamic> json) => RoomfinderStreet(
      id: json['id'] as String,
      name: json['name'] as String,
      buildings: (json['buildings'] as List<dynamic>)
          .map((e) => RoomfinderBuilding.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomfinderStreetToJson(RoomfinderStreet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'buildings': instance.buildings.map((e) => e.toJson()).toList(),
    };
