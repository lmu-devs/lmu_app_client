// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderFloor _$RoomfinderFloorFromJson(Map<String, dynamic> json) => RoomfinderFloor(
      id: json['id'] as String,
      name: json['name'] as String,
      mapUri: json['map_uri'] as String,
      rooms: (json['rooms'] as List<dynamic>).map((e) => RoomfinderRoom.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$RoomfinderFloorToJson(RoomfinderFloor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'map_uri': instance.mapUri,
      'rooms': instance.rooms.map((e) => e.toJson()).toList(),
    };
