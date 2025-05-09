import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timeframe_model.g.dart';

@JsonSerializable()
class TimeframeModel extends Equatable {
  const TimeframeModel({
    required this.start,
    required this.end,
  });

  final String start;
  final String end;

  factory TimeframeModel.fromJson(Map<String, dynamic> json) => _$TimeframeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeframeModelToJson(this);

  @override
  List<Object?> get props => [start, end];
}
