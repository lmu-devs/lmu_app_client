import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../repository.dart';

part 'mensa_opening_hours.g.dart';

@JsonSerializable()
class MensaOpeningHours extends Equatable {
  const MensaOpeningHours({
    required this.openingHours,
    required this.servingHours,
  });

  factory MensaOpeningHours.empty() => const MensaOpeningHours(
        openingHours: [],
        servingHours: [],
      );

  factory MensaOpeningHours.fromJson(Map<String, dynamic> json) => _$MensaOpeningHoursFromJson(json);

  @JsonKey(name: 'opening_hours')
  final List<MensaOpeningDetails> openingHours;
  @JsonKey(name: 'serving_hours')
  final List<MensaOpeningDetails>? servingHours;

  Map<String, dynamic> toJson() => _$MensaOpeningHoursToJson(this);

  @override
  List<Object?> get props => [
        openingHours,
        servingHours,
      ];
}
