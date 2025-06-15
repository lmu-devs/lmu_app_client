import 'dart:ui';

import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../presentation/component/calendar_card.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.location,
    this.description,
  });

  final String id;
  final String title;
  final CalendarType type;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  final LocationModel location;
  final String? description;

  @override
  List<Object?> get props => [id, title, startDate, endDate, location, description];

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);
}
