import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_building_part.dart';
import 'roomfinder_location.dart';

part 'roomfinder_building.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderBuilding extends Equatable {
  const RoomfinderBuilding({
    required this.id,
    required this.title,
    required this.location,
    required this.buildingParts,
  });

  final String id;
  final String title;
  final RoomfinderLocation location;
  @JsonKey(name: 'building_parts')
  final List<RoomfinderBuildingPart> buildingParts;

  @override
  List<Object?> get props => [id, title, location, buildingParts];

  factory RoomfinderBuilding.fromJson(Map<String, dynamic> json) => _$RoomfinderBuildingFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderBuildingToJson(this);
}
