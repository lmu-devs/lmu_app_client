import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_floor.dart';

part 'roomfinder_building.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderBuilding extends Equatable {
  const RoomfinderBuilding({
    required this.id,
    required this.title,
    required this.location,
    required this.buildingPartId,
    required this.aliases,
    required this.floors,
  });

  factory RoomfinderBuilding.fromJson(Map<String, dynamic> json) => _$RoomfinderBuildingFromJson(json);

  @JsonKey(name: 'building_id')
  final String id;
  @JsonKey(name: 'building_part_id')
  final String buildingPartId;
  final String title;
  final List<String> aliases;
  final LocationModel location;
  final List<RoomfinderFloor> floors;

  @override
  List<Object?> get props => [id, title, location, buildingPartId, aliases, floors];

  Map<String, dynamic> toJson() => _$RoomfinderBuildingToJson(this);
}
