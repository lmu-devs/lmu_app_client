import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'timeframe_model.dart';

part 'opening_hours_model.g.dart';

@JsonSerializable()
class OpeningHoursModel extends Equatable {
  const OpeningHoursModel({
    required this.day,
    required this.timeframes,
  });

  final Weekday day;
  final List<TimeframeModel> timeframes;

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) => _$OpeningHoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursModelToJson(this);

  @override
  List<Object?> get props => [day, timeframes];
}
