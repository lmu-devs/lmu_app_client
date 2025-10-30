import 'dart:ui';

import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/converter/color_converter.dart';
import '../../../../domain/model/event_type.dart';
import 'calendar_rule_dto.dart';

part 'calendar_entry_dto.g.dart';

@JsonSerializable()
class CalendarEntryDto extends Equatable {
  factory CalendarEntryDto.fromJson(Map<String, dynamic> json) => _$CalendarEntryDtoFromJson(json);

  const CalendarEntryDto({
    required this.id,
    required this.title,
    required this.eventType,
    required this.startTime,
    required this.endTime,
    this.color,
    required this.allDay,
    this.location,
    this.onlineLink,
    this.accessScope,
    this.description,
    this.rule,
    this.recurrenceId,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  @JsonKey(name: 'event_type')
  final EventType eventType;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @JsonKey(name: 'all_day')
  final bool allDay;

  @ColorConverter()
  final Color? color;

  final LocationModel? location;
  @JsonKey(name: 'online_link')
  final String? onlineLink;

  @JsonKey(name: 'access_scope')
  final int? accessScope;

  final String? description;
  final CalendarRuleDto? rule;
  @JsonKey(name: 'recurrence_id')
  final int? recurrenceId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$CalendarEntryDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        eventType,
        startTime,
        endTime,
        allDay,
        color,
        location,
        onlineLink,
        accessScope,
        description,
        rule,
        recurrenceId,
        createdAt,
        updatedAt,
      ];
}
