import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../repository.dart';

part 'area_model.g.dart';

@JsonSerializable()
class AreaModel extends Equatable {
  const AreaModel({
    required this.id,
    required this.name,
    required this.openingHours,
  });

  final int id;
  final String name;
  @JsonKey(name: 'opening_hours')
  final List<OpeningHoursModel>? openingHours;

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);

  @override
  List<Object?> get props => [id, name, openingHours];
}
