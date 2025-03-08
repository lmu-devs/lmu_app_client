import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roomfinder_location.g.dart';

@JsonSerializable()
class RoomfinderLocation extends Equatable {
  const RoomfinderLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [address, latitude, longitude];

  factory RoomfinderLocation.fromJson(Map<String, dynamic> json) => _$RoomfinderLocationFromJson(json);
  Map<String, dynamic> toJson() => _$RoomfinderLocationToJson(this);
}
