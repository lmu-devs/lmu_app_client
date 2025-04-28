import 'package:equatable/equatable.dart';

import 'explore_marker_type.dart';

class ExploreLocation extends Equatable {
  const ExploreLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.name,
    required this.type,
  });

  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final String address;
  final ExploreMarkerType type;

  @override
  List<Object?> get props => [latitude, longitude, address, id, name, type];
}
