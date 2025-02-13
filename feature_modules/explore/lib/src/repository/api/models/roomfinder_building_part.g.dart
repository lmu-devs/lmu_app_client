// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_building_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderBuildingPart _$RoomfinderBuildingPartFromJson(Map<String, dynamic> json) => RoomfinderBuildingPart(
      id: json['id'] as String,
      address: json['address'] as String,
      floors:
          (json['floors'] as List<dynamic>).map((e) => RoomfinderFloor.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$RoomfinderBuildingPartToJson(RoomfinderBuildingPart instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'floors': instance.floors.map((e) => e.toJson()).toList(),
    };
