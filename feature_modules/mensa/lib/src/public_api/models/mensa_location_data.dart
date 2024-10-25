import 'package:equatable/equatable.dart';

abstract class MensaLocationData extends Equatable {
  const MensaLocationData({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [address, latitude, longitude];
}
