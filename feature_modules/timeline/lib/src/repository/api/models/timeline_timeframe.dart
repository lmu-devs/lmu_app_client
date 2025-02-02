import 'package:json_annotation/json_annotation.dart';

part 'timeline_timeframe.g.dart';

@JsonSerializable()
class TimelineTimeframe {
  final DateTime start;
  final DateTime end;

  TimelineTimeframe({required this.start, required this.end});

  factory TimelineTimeframe.fromJson(Map<String, dynamic> json) => _$TimelineTimeframeFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineTimeframeToJson(this);
}
