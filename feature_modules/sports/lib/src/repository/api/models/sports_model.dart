import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sports_type.dart';

part 'sports_model.g.dart';

@JsonSerializable()
class SportsModel extends Equatable {
  const SportsModel({required this.sportTypes});

  factory SportsModel.fromJson(Map<String, dynamic> json) => _$SportsModelFromJson(json);

  @JsonKey(name: 'sport_types')
  final List<SportsType> sportTypes;

  Map<String, dynamic> toJson() => _$SportsModelToJson(this);

  @override
  List<Object?> get props => [sportTypes];
}
