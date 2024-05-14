import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'mensa_day_hours.dart';

part 'mensa_opening_hours.g.dart';

@JsonSerializable()
class MensaOpeningHours extends Equatable {
  const MensaOpeningHours({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
  });

  final MensaDayHours mon;
  final MensaDayHours tue;
  final MensaDayHours wed;
  final MensaDayHours thu;
  final MensaDayHours fri;

  factory MensaOpeningHours.fromJson(Map<String, dynamic> json) => _$MensaOpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$MensaOpeningHoursToJson(this);

  @override
  List<Object?> get props => [
        mon,
        tue,
        wed,
        thu,
        fri,
      ];
}
