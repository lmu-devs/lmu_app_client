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
    required this.rooms,
  });

  factory RoomfinderFloor.fromJson(Map<String, dynamic> json) => _$RoomfinderFloorFromJson(json);

  final String id;
  final String name;
  @JsonKey(name: 'map_uri')
  final String mapUri;
  final List<RoomfinderRoom> rooms;

  @override
  List<Object?> get props => [id, name, mapUri, rooms];

  Map<String, dynamic> toJson() => _$RoomfinderFloorToJson(this);
}
