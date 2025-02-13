// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderBuilding _$RoomfinderBuildingFromJson(Map<String, dynamic> json) => RoomfinderBuilding(
      id: json['id'] as String,
      title: json['title'] as String,
      location: RoomfinderLocation.fromJson(json['location'] as Map<String, dynamic>),
      buildingParts: (json['building_parts'] as List<dynamic>)
          .map((e) => RoomfinderBuildingPart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomfinderBuildingToJson(RoomfinderBuilding instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location.toJson(),
      'building_parts': instance.buildingParts.map((e) => e.toJson()).toList(),
    };
