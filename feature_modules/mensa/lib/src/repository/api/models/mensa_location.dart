import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensa_location.g.dart';

@JsonSerializable()
class MensaLocation extends Equatable {
  const MensaLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  factory MensaLocation.fromJson(Map<String, dynamic> json) => _$MensaLocationFromJson(json);

  Map<String, dynamic> toJson() => _$MensaLocationToJson(this);

  @override
  List<Object?> get props => [
        address,
        latitude,
        longitude,
      ];
}
