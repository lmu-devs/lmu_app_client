import 'package:json_annotation/json_annotation.dart';

import 'timeline_timeframe.dart';

part 'timeline_semester.g.dart';

@JsonSerializable()
class TimelineSemester {
  final TimelineTimeframe timeframe;
  final String type;

  TimelineSemester({required this.timeframe, required this.type});

  factory TimelineSemester.fromJson(Map<String, dynamic> json) => _$TimelineSemesterFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineSemesterToJson(this);
}
