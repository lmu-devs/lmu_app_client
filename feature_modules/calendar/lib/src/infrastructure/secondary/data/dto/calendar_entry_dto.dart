import 'dart:ui'; // For Color

import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/calendar_entry.dart';
import '../../../../domain/model/converter/color_converter.dart';
import '../../../../domain/model/event_type.dart';
import 'calendar_rule_dto.dart';

part 'calendar_entry_dto.g.dart';

@JsonSerializable()
class CalendarEntryDto extends Equatable {
  // Method to convert domain model to DTO for serialization to JSON
  factory CalendarEntryDto.fromDomain(CalendarEntry domain) {
    return CalendarEntryDto(
      id: domain.id,
      title: domain.title,
      type: domain.type,
      startDate: domain.startDate,
      endDate: domain.endDate,
      color: domain.color,
      location: domain.location,
      allDay: domain.allDay,
      description: domain.description,
      address: domain.address,
      rule: domain.rule != null ? CalendarRuleDto.fromDomain(domain.rule!) : null,
      recurrenceId: domain.recurrenceId,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
    );
  }
  // Factory constructor for deserialization from JSON
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
  final LocationModel location; // TODO: LocationModel is currently not a DTO

  final String? description;
  final String? address;
  final CalendarRuleDto? rule;
  final int? recurrenceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Method to convert DTO to domain model
  CalendarEntry toDomain() {
    return CalendarEntry(
      id: id,
      title: title,
      type: type,
      startDate: startDate,
      endDate: endDate,
      color: color,
      location: location,
      allDay: allDay,
      description: description,
      address: address,
      rule: rule?.toDomain(), // Convert nested DTO to domain model, if not null
      recurrenceId: recurrenceId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Method for serialization to JSON
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
