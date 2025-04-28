import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'time_range_model.dart';

part 'opening_day_model.g.dart';

@JsonSerializable()
class OpeningDayModel extends Equatable {
  const OpeningDayModel({
    required this.day,
    required this.timeRanges,
  });

  final String day;

  @JsonKey(name: 'time_ranges')
  final List<TimeRangeModel> timeRanges;

  factory OpeningDayModel.fromJson(Map<String, dynamic> json) => _$OpeningDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningDayModelToJson(this);

  @override
  List<Object?> get props => [day, timeRanges];
}
