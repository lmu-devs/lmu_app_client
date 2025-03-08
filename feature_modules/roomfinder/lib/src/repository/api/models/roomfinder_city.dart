import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'roomfinder_street.dart';

part 'roomfinder_city.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomfinderCity extends Equatable {
  const RoomfinderCity({
    required this.id,
    required this.name,
    required this.streets,
  });

  final String id;
  final String name;
  final List<RoomfinderStreet> streets;

  @override
  List<Object?> get props => [id, name, streets];

  factory RoomfinderCity.fromJson(Map<String, dynamic> json) => _$RoomfinderCityFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderCityToJson(this);
}
