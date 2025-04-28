// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderBuilding _$RoomfinderBuildingFromJson(Map<String, dynamic> json) =>
    RoomfinderBuilding(
      id: json['building_id'] as String,
      title: json['title'] as String,
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      buildingPartId: json['building_part_id'] as String,
      aliases:
          (json['aliases'] as List<dynamic>).map((e) => e as String).toList(),
      floors: (json['floors'] as List<dynamic>)
          .map((e) => RoomfinderFloor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomfinderBuildingToJson(RoomfinderBuilding instance) =>
    <String, dynamic>{
      'building_id': instance.id,
      'building_part_id': instance.buildingPartId,
      'title': instance.title,
      'aliases': instance.aliases,
      'location': instance.location.toJson(),
      'floors': instance.floors.map((e) => e.toJson()).toList(),
    };
