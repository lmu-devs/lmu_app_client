import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_floor.dart';

part 'roomfinder_building_part.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderBuildingPart extends Equatable {
  const RoomfinderBuildingPart({
    required this.id,
    required this.address,
    required this.floors,
  });

  final String id;
  final String address;
  final List<RoomfinderFloor> floors;

  @override
  List<Object?> get props => [id, address, floors];

  factory RoomfinderBuildingPart.fromJson(Map<String, dynamic> json) => _$RoomfinderBuildingPartFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderBuildingPartToJson(this);
}
