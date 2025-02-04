import 'package:json_annotation/json_annotation.dart';

part 'mensa_location.g.dart';

@JsonSerializable()
class MensaLocation {
  const MensaLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  factory MensaLocation.placeholder() => const MensaLocation(
        address: '',
        latitude: 0,
        longitude: 0,
      );

  factory MensaLocation.fromJson(Map<String, dynamic> json) => _$MensaLocationFromJson(json);

  Map<String, dynamic> toJson() => _$MensaLocationToJson(this);
}
