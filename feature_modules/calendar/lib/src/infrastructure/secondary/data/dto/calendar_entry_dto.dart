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
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.location,
    required this.allDay,
    this.description,
    this.address,
    this.rule,
    this.recurrenceId,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final EventType type;
  final DateTime startDate;
  final DateTime endDate;
  final bool allDay;

  @ColorConverter()
  final Color color;

  final LocationModel location;

  final String? description;
  final String? address;
  final CalendarRuleDto? rule;
  final int? recurrenceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$CalendarEntryDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        startDate,
        endDate,
        allDay,
        color,
        location,
        description,
        address,
        rule,
        recurrenceId,
        createdAt,
        updatedAt,
      ];
}
