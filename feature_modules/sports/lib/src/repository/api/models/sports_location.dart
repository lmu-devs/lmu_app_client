import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sports_location.g.dart';

@JsonSerializable()
class SportsLocation extends Equatable {
  const SportsLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory SportsLocation.fromJson(Map<String, dynamic> json) => _$SportsLocationFromJson(json);

  final String address;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$SportsLocationToJson(this);

  @override
  List<Object?> get props => [address, latitude, longitude];
}
