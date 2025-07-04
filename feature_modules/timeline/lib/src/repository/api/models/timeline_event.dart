import 'package:json_annotation/json_annotation.dart';

import 'timeline_timeframe.dart';

part 'timeline_event.g.dart';

@JsonSerializable()
class TimelineEvent {
  const TimelineEvent({
    required this.title,
    required this.type,
    required this.timeframe,
    this.description,
    this.location,
    this.url,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) => _$TimelineEventFromJson(json);

  final String title;
  final String type;
  final TimelineTimeframe timeframe;
  final String? description;
  final String? location;
  final String? url;

  Map<String, dynamic> toJson() => _$TimelineEventToJson(this);
}
