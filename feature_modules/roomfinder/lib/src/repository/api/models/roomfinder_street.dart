import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_building.dart';

part 'roomfinder_street.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderStreet extends Equatable {
  const RoomfinderStreet({
    required this.id,
    required this.name,
    required this.buildings,
  });

  factory RoomfinderStreet.fromJson(Map<String, dynamic> json) => _$RoomfinderStreetFromJson(json);

  final String id;
  final String name;
  final List<RoomfinderBuilding> buildings;

  @override
  List<Object?> get props => [id, name, buildings];

  Map<String, dynamic> toJson() => _$RoomfinderStreetToJson(this);
}
