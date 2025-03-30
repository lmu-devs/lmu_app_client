import 'package:json_annotation/json_annotation.dart';

import 'timeline_event.dart';
import 'timeline_semester.dart';

part 'timeline_data.g.dart';

@JsonSerializable()
class TimelineData {
  const TimelineData({required this.semesters, required this.events});

  final List<TimelineSemester> semesters;
  final List<TimelineEvent> events;

  factory TimelineData.fromJson(Map<String, dynamic> json) => _$TimelineDataFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineDataToJson(this);
}
