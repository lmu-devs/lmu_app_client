import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roomfinder_room.g.dart';

@JsonSerializable()
class RoomfinderRoom extends Equatable {
  const RoomfinderRoom({
    required this.id,
    required this.name,
    required this.posX,
    required this.posY,
  });

  final String id;
  final String name;
  @JsonKey(name: 'pos_x')
  final int posX;
  @JsonKey(name: 'pos_y')
  final int posY;

  @override
  List<Object?> get props => [id, name, posX, posY];

  factory RoomfinderRoom.fromJson(Map<String, dynamic> json) => _$RoomfinderRoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderRoomToJson(this);
}
