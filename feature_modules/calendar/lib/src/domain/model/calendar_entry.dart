import 'package:core/api.dart';
import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'calendar_rule.dart';
import 'event_type.dart';

class CalendarEntry extends Equatable {
  const CalendarEntry({
    required this.id,
    required this.title,
    required this.eventType,
    required this.startTime,
    required this.endTime,
    this.color,
    required this.allDay,
    this.location,
    this.onlineLink,
    this.description,
    this.address,
    this.rule,
    this.recurrenceId,
    this.createdAt,
    this.updatedAt,
    this.accessScope,
  });

  // All nested values with custom types need to extend Equatable for some operations to work efficiently!
  final String id;
  final String title;
  final EventType eventType;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final Color? color;

  final LocationModel? location;
  final String? onlineLink;
  final String? description;
  final String? address;
  final CalendarRule? rule;
  final int? recurrenceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? accessScope;

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
        description,
        address,
        rule,
        recurrenceId,
        createdAt,
        updatedAt,
        accessScope,
      ];

  /// Checks if the event occurs on the given date
  bool occursOn(DateTime date) {
    // This logic might need refinement depending on how allDay and timezones are handled
    return startTime.year == date.year && startTime.month == date.month && startTime.day == date.day;
  }

  /// Checks if the event overlaps with the given DateTimeRange.
  /// An event overlaps with a range if its start or end date falls within the range.
  bool overlapsWithRange(DateTimeRange range) {
    return endTime.isBetween(range.start, range.end) || startTime.isBetween(range.start, range.end);
  }

  /// Checks if the event occurs within the given DateTimeRange.
  bool isWithinRange(DateTimeRange range) {
    return startTime.isBeforeOrEqualTo(range.end) && endTime.isAfterOrEqualTo(range.start);
  }

  /// Returns the duration of the event.
  Duration get duration => endTime.difference(startTime);

  /// Checks if this entry overlaps with another entry.
  bool isOverlapping(CalendarEntry other) {
    // Two events overlap if their time intervals intersect.
    return startTime.isBefore(other.endTime) && endTime.isAfter(other.startTime);
  }

  /// Checks if the event is in the past.
  bool get isPast => endTime.isBefore(DateTime.now());

  /// Checks if the event is currently ongoing.
  bool get isOngoing {
    final now = DateTime.now();
    return startTime.isBefore(now) && endTime.isAfter(now);
  }

  /// Checks if the event is an all-day event.
  bool get isAllDay => allDay;

  /// Returns a copy of this entry with updated fields.
  CalendarEntry copyWith({
    String? id,
    String? title,
    EventType? type,
    DateTime? startTime,
    DateTime? endTime,
    bool? allDay,
    Color? color,
    LocationModel? location,
    String? onlineLink,
    String? description,
    String? address,
    CalendarRule? rule,
    int? recurrenceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? accessScope,
  }) {
    return CalendarEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      eventType: type ?? eventType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      allDay: allDay ?? this.allDay,
      color: color ?? this.color,
      location: location ?? this.location,
      onlineLink: onlineLink ?? onlineLink,
      description: description ?? this.description,
      address: address ?? this.address,
      rule: rule ?? this.rule,
      recurrenceId: recurrenceId ?? this.recurrenceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accessScope: accessScope ?? this.accessScope,
    );
  }
}
