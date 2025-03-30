import 'package:json_annotation/json_annotation.dart';

import 'timeline_timeframe.dart';

part 'timeline_semester.g.dart';

enum SemesterType {
  @JsonValue('WINTER')
  winter,
  @JsonValue('SUMMER')
  summer,
}

@JsonSerializable()
class TimelineSemester {
  const TimelineSemester({required this.timeframe, required this.type});

  final TimelineTimeframe timeframe;
  final SemesterType type;

  factory TimelineSemester.fromJson(Map<String, dynamic> json) => _$TimelineSemesterFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineSemesterToJson(this);
}
