import 'package:equatable/equatable.dart';

import 'mensa_type.dart';

class MensaLocationData extends Equatable {
  const MensaLocationData({
    required this.id,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final MensaType type;

  @override
  List<Object> get props => [address, latitude, longitude];
}
