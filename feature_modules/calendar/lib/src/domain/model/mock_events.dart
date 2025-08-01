import 'package:core/api.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/secondary/data/dto/calendar_entry_dto.dart';
import '../../infrastructure/secondary/data/dto/calendar_entry_mapper.dart';
import 'calendar_entry.dart';
import 'event_type.dart';

final mockCalendarEntries = [
  CalendarEntry(
    id: 'event_456',
    title: 'ZukunftsGeschenk',
    type: EventType.exam,
    color: Colors.purple,
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
    location: const LocationModel(address: 'Die zUkuNfT 1', latitude: 48.1500, longitude: 11.5800),
    description: 'Ein Event, dass immer in der zukunft liegt egal was!',
    allDay: false,
  ),
  CalendarEntry(
    id: 'event_456',
    title: 'Flutter Workshop 4',
    type: EventType.movie,
    color: Colors.green,
    startDate: DateTime.now().add(const Duration(hours: 1)),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'A  comprehensive workshop on Flutter development.',
    allDay: false,
  ),
  CalendarEntry(
    id: 'event_456',
    title: 'Flutter Workshop 3',
    type: EventType.movie,
    color: Colors.red,
    startDate: DateTime.now().subtract(const Duration(minutes: 60)),
    endDate: DateTime.now().subtract(const Duration(minutes: 30)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'A  comprehensive workshop on Flutter development.',
    allDay: false,
  ),
  CalendarEntry(
    id: 'event_789',
    title: 'Design Sprint',
    type: EventType.lecture,
    color: Colors.red,
    startDate: DateTime.now().subtract(const Duration(minutes: 120)),
    endDate: DateTime.now().subtract(const Duration(minutes: 60)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'A design sprint to solve user problems.',
    allDay: true,
  ),
  CalendarEntry(
    id: 'event_101',
    title: 'Team Meeting',
    type: EventType.lecture,
    color: Colors.orange,
    startDate: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'Weekly team sync-up meeting.',
    allDay: false,
  ),
  CalendarEntry(
    id: 'event_102',
    title: 'Project Kickoff II',
    type: EventType.movie,
    color: Colors.blue,
    startDate: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    endDate: DateTime.now().add(const Duration(days: 3, hours: 2)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'Kickoff meeting for the new project.',
    allDay: true,
  ),
  CalendarEntry(
    id: 'event_101',
    title: 'Team Meeting',
    type: EventType.lecture,
    color: Colors.orange,
    startDate: DateTime.now().subtract(const Duration(days: 4, hours: 2)),
    endDate: DateTime.now().add(const Duration(days: 4, hours: 2)),
    location: const LocationModel(address: 'Ludwigstraße 1, München', latitude: 48.1500, longitude: 11.5800),
    description: 'Weekly team sync-up meeting.',
    allDay: false,
  ),
];

// Function to create mock CalendarEntryDto list
List<CalendarEntryDto> createMockCalendarEntryDtos() {
  return mockCalendarEntries.map((entry) {
    // return CalendarEntryDto.fromDomain(entry);

    // Creating a new DTO instance, to show that the data was modified from a mocked DTO object
    final CalendarEntryDto dto = CalendarEntryMapper.toDto(entry);

    return CalendarEntryDto(
      id: dto.id,
      title: '${dto.title} (from DTO)', // Modify the title here
      type: dto.type,
      startDate: dto.startDate,
      endDate: dto.endDate,
      color: dto.color,
      location: dto.location, // Assuming LocationModelDto is correctly derived
      allDay: dto.allDay,
      description: dto.description,
      address: dto.address,
      rule: dto.rule,
      recurrenceId: dto.recurrenceId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }).toList();
}
