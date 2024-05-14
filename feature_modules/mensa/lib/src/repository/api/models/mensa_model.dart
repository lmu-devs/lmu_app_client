import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'mensa_location.dart';
import 'mensa_opening_hours.dart';

part 'mensa_model.g.dart';

@JsonSerializable()
class MensaModel extends Equatable {
  final String name;
  final MensaLocation location;
  @JsonKey(name: 'canteen_id')
  final String canteenId;
  @JsonKey(name: 'open_hours')
  final MensaOpeningHours openingHours;

  const MensaModel({
    required this.name,
    required this.location,
    required this.canteenId,
    required this.openingHours,
  });

  factory MensaModel.fromJson(Map<String, dynamic> json) => _$MensaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MensaModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        location,
        canteenId,
        openingHours,
      ];
}
