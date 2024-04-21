import 'package:equatable/equatable.dart';

import 'mensa_opening_hours.dart';

enum MensaType {
  mensa,
  bistro,
  cafe,
}

class MensaEntry extends Equatable {
  const MensaEntry({
    required this.name,
    required this.type,
    required this.isFavorite,
    this.distance,
    required this.openingHours,
  });

  final String name;
  final MensaType type;
  final bool isFavorite;
  final double? distance;
  final MensaOpeningHours? openingHours;

  MensaEntry copyWith({
    String? name,
    MensaType? type,
    bool? isFavorite,
    double? distance,
    MensaOpeningHours? openingHours,
  }) {
    return MensaEntry(
      name: name ?? this.name,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
      distance: distance ?? this.distance,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  @override
  String toString() {
    return 'MensaEntry(name: $name, type: $type, isFavorite: $isFavorite, distance: $distance, openingHours: $openingHours)';
  }

  @override
  List<Object?> get props => [
        name,
        type,
        isFavorite,
        distance,
        openingHours,
      ];
}
