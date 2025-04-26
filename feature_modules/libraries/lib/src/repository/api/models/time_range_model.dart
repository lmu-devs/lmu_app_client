import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_range_model.g.dart';

@JsonSerializable()
class TimeRangeModel extends Equatable {
  const TimeRangeModel({
    required this.startTime,
    required this.endTime,
  });

  @JsonKey(name: 'start_time')
  final String startTime;

  @JsonKey(name: 'end_time')
  final String endTime;

  factory TimeRangeModel.fromJson(Map<String, dynamic> json) => _$TimeRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeRangeModelToJson(this);

  @override
  List<Object?> get props => [startTime, endTime];
}
