import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'mensa_location.dart';
import 'mensa_opening_hours.dart';

part 'mensa_model.g.dart';

@JsonSerializable()
class MensaModel extends Equatable {
  @JsonKey(name: 'canteen_id')
  final String canteenId;
  final String name;
  final MensaLocation location;
  @JsonKey(name: 'opening_hours')
  final List<MensaOpeningHours> openingHours;

  const MensaModel({
    required this.canteenId,
    required this.name,
    required this.location,
    required this.openingHours,
  });

  factory MensaModel.fromJson(Map<String, dynamic> json) => _$MensaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MensaModelToJson(this);

  @override
  List<Object?> get props => [
        canteenId,
        name,
        location,
        openingHours,
      ];
}
