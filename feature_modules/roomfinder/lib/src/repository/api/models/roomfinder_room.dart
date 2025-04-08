import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roomfinder_room.g.dart';

@JsonSerializable()
class RoomfinderRoom extends Equatable {
  const RoomfinderRoom({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  factory RoomfinderRoom.fromJson(Map<String, dynamic> json) => _$RoomfinderRoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderRoomToJson(this);
}
