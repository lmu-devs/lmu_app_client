import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_room.dart';

part 'roomfinder_floor.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderFloor extends Equatable {
  const RoomfinderFloor({
    required this.id,
    required this.name,
    required this.mapUri,
    required this.mapSizeX,
    required this.mapSizeY,
    required this.rooms,
  });

  final String id;
  final String name;
  @JsonKey(name: 'map_uri')
  final String mapUri;
  @JsonKey(name: 'map_size_x')
  final int mapSizeX;
  @JsonKey(name: 'map_size_y')
  final int mapSizeY;
  final List<RoomfinderRoom> rooms;

  @override
  List<Object?> get props => [id, name, mapUri, mapSizeX, mapSizeY, rooms];

  factory RoomfinderFloor.fromJson(Map<String, dynamic> json) => _$RoomfinderFloorFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderFloorToJson(this);
}
