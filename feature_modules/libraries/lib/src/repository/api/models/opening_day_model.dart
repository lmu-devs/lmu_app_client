import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'timeframe_model.dart';

part 'opening_day_model.g.dart';

@JsonSerializable()
class OpeningDayModel extends Equatable {
  const OpeningDayModel({
    required this.day,
    required this.timeframes,
  });

  final Weekday day;
  final List<TimeframeModel> timeframes;

  factory OpeningDayModel.fromJson(Map<String, dynamic> json) => _$OpeningDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningDayModelToJson(this);

  @override
  List<Object?> get props => [day, timeframes];
}
