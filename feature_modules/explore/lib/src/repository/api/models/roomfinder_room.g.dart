// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomfinder_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomfinderRoom _$RoomfinderRoomFromJson(Map<String, dynamic> json) => RoomfinderRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      posX: (json['pos_x'] as num).toInt(),
      posY: (json['pos_y'] as num).toInt(),
    );

Map<String, dynamic> _$RoomfinderRoomToJson(RoomfinderRoom instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pos_x': instance.posX,
      'pos_y': instance.posY,
    };
