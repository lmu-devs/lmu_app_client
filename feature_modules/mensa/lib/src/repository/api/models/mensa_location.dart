import 'package:json_annotation/json_annotation.dart';

import '../../../public_api/models/mensa_location_data.dart';

part 'mensa_location.g.dart';

@JsonSerializable()
class MensaLocation extends MensaLocationData {
  const MensaLocation({
    required String address,
    required double latitude,
    required double longitude,
  }) : super(address: address, latitude: latitude, longitude: longitude);

  factory MensaLocation.placeholder() => const MensaLocation(
        address: '',
        latitude: 0,
        longitude: 0,
      );

  factory MensaLocation.fromJson(Map<String, dynamic> json) => _$MensaLocationFromJson(json);

  Map<String, dynamic> toJson() => _$MensaLocationToJson(this);
}
