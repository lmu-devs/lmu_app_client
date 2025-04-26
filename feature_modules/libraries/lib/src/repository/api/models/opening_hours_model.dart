import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'opening_day_model.dart';

part 'opening_hours_model.g.dart';

@JsonSerializable()
class OpeningHoursModel extends Equatable {
  const OpeningHoursModel({
    required this.days,
  });

  final List<OpeningDayModel> days;

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) => _$OpeningHoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursModelToJson(this);

  @override
  List<Object?> get props => [days];
}
