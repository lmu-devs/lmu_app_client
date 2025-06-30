import 'dart:ui';

import 'package:core/api.dart';
import 'package:equatable/equatable.dart';

import 'calendar_rule.dart';
import 'event_type.dart';

class CalendarEntry extends Equatable {
  const CalendarEntry({
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
  final Color color;
  final LocationModel location;

  final String? description;
  final String? address;
  final CalendarRule? rule;
  final int? recurrenceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  // Domain-specific methods (like occursOn) belong here
  bool occursOn(DateTime date) {
    // This logic might need refinement depending on how allDay and timezones are handled
    return startDate.year == date.year && startDate.month == date.month && startDate.day == date.day;
  }

  /// Returns the duration of the event.
  Duration get duration => endDate.difference(startDate);

  /// Checks if this entry overlaps with another entry.
  bool isOverlapping(CalendarEntry other) {
    // Two events overlap if their time intervals intersect.
    return startDate.isBefore(other.endDate) && endDate.isAfter(other.startDate);
  }

  /// Checks if the event is in the past.
  bool get isPast => endDate.isBefore(DateTime.now());

  /// Checks if the event is currently ongoing.
  bool get isOngoing {
    final now = DateTime.now();
    return startDate.isBefore(now) && endDate.isAfter(now);
  }

  /// Checks if the event is an all-day event.
  bool get isAllDay => allDay;

  /// Returns a copy of this entry with updated fields.
  CalendarEntry copyWith({
    String? id,
    String? title,
    EventType? type,
    DateTime? startDate,
    DateTime? endDate,
    bool? allDay,
    Color? color,
    LocationModel? location,
    String? description,
    String? address,
    CalendarRule? rule,
    int? recurrenceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      allDay: allDay ?? this.allDay,
      color: color ?? this.color,
      location: location ?? this.location,
      description: description ?? this.description,
      address: address ?? this.address,
      rule: rule ?? this.rule,
      recurrenceId: recurrenceId ?? this.recurrenceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
