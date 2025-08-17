import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CalendarViewType {
  const CalendarViewType({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.disabled = false, // Add this new property, defaulting to false
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final bool disabled; // The new property to check if the item is disabled

  static const CalendarViewType list = CalendarViewType(
      id: 'list', name: 'List', description: 'View events in a list format.', icon: LucideIcons.rows_3);

  static const CalendarViewType day = CalendarViewType(
      id: 'day', name: 'Day', description: 'View events for a single day.', icon: LucideIcons.gallery_vertical);

  static const CalendarViewType week = CalendarViewType(
      id: 'week',
      name: 'Week',
      description: 'View events across a full week.',
      icon: LucideIcons.columns_3,
      disabled: true); // Disabled

  static const CalendarViewType month = CalendarViewType(
      id: 'month',
      name: 'Month',
      description: 'View events for the entire month.',
      icon: LucideIcons.calendar_days,
      disabled: true); // Disabled

  static const List<CalendarViewType> types = [
    list,
    day,
    week,
    month,
  ];

  static CalendarViewType? fromId(String id) {
    for (var viewType in types) {
      if (viewType.id == id) {
        return viewType;
      }
    }
    return null;
  }
}
