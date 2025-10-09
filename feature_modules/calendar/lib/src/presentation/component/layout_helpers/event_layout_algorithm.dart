// --- Overlap Layout Algorithm ---
import '../../../domain/model/calendar_entry.dart';
import 'event_layout.dart';
import 'event_layout_grid_position.dart';

extension SortedCalendarEntries on List<CalendarEntry> {
  /// Returns a new list of CalendarEntry sorted by start time, then end time.
  List<CalendarEntry> sortedByStartAndEndTime() {
    return List<CalendarEntry>.from(this)
      ..sort((a, b) {
        final c = a.startTime.compareTo(b.startTime);
        return c == 0 ? a.endTime.compareTo(b.endTime) : c;
      });
  }
}

// Helper class to pass arguments to the isolate.
class EventLayoutParams {
  EventLayoutParams({required this.entries, required this.fixedHeightPerHour});
  final List<CalendarEntry> entries;
  final double fixedHeightPerHour;
}

List<EventLayout> calculateLayoutsInBackground(EventLayoutParams params) {
  // Sort events by start time
  final List<CalendarEntry> sortedEvents = params.entries.sortedByStartAndEndTime();
  // Grouping overlapping events (collision groups)
  final List<List<CalendarEntry>> collisionGroups = groupOverlappingEvents(sortedEvents);

  // Processing each collision group in a recursive manner
  final layouts = <EventLayout>[];
  for (final group in collisionGroups) {
    layouts.addAll(processCollisionGroup(group, params.fixedHeightPerHour));
  }

  return layouts;
}

/// Groups overlapping calendar events into collision groups.
/// Each group contains events that overlap in time.
List<List<CalendarEntry>> groupOverlappingEvents(List<CalendarEntry> sortedEvents) {
  final collisionGroups = <List<CalendarEntry>>[];

  if (sortedEvents.isNotEmpty) {
    var currentGroup = [sortedEvents.first];
    var groupEnd = sortedEvents.first.endTime;

    for (int i = 1; i < sortedEvents.length; i++) {
      final event = sortedEvents[i];
      if (event.startTime.isBefore(groupEnd)) {
        currentGroup.add(event);
        if (event.endTime.isAfter(groupEnd)) {
          groupEnd = event.endTime;
        }
      } else {
        collisionGroups.add(currentGroup);
        currentGroup = [event];
        groupEnd = event.endTime;
      }
    }
    collisionGroups.add(currentGroup);
  }

  return collisionGroups;
}

/// Recursive function for laying out a single group of overlapping events.
/// Decides whether to apply a "flow" layout (one main/parent event, others "inside" it as child events)
/// or a "pack" layout (all events placed next to each other in columns taking as much horizontal space as they can).
/// If it chooses "flow", it gives the child elements the remaining space to again decide if they should be laid out in a "flow" or "pack" manner.
List<EventLayout> processCollisionGroup(List<CalendarEntry> group, double fixedHeightPerHour) {
  if (group.isEmpty) return [];
  // If there's only one event (or none), it takes up the full width -> avoids long calculations
  if (group.length <= 1) {
    return group
        .map((event) => EventLayout(
              entry: event,
              top: _calculatePixelPosition(event.startTime, fixedHeightPerHour),
              height: (event.duration.inMinutes / 60) * fixedHeightPerHour,
              left: 0.0,
              width: 1.0,
            ))
        .toList();
  }

  // --- The Flow vs. Pack  ---
  final mainEvent = group.first; // earliest event.
  const int flowRuleStartTimeBuffer = 30; // in minutes

  // The condition for using the "flow" layout: all other events must start
  // at least 30 minutes after the main event begins.
  bool useFlowLayout = true;
  for (int i = 1; i < group.length; i++) {
    if (group[i].startTime.difference(mainEvent.startTime).inMinutes <= flowRuleStartTimeBuffer) {
      useFlowLayout = false;
      break;
    }
  }

  if (useFlowLayout) {
    // --- Apply "Flow" Layout ---
    final List<EventLayout> layouts = [];

    // The main-main event get full available width (1.0).
    layouts.add(EventLayout(
      entry: mainEvent,
      top: _calculatePixelPosition(mainEvent.startTime, fixedHeightPerHour),
      height: (mainEvent.duration.inMinutes / 60) * fixedHeightPerHour,
      left: 0.0,
      width: 1.0,
    ));

    // Child events form a subgroup
    final remainingEvents = group.sublist(1);

    // recursion lays out the nested subgroup
    final indentedRawLayouts = processCollisionGroup(remainingEvents, fixedHeightPerHour);

    const double indent = 0.15;
    const double availableWidth = 1.0 - indent;
    for (final layout in indentedRawLayouts) {
      layouts.add(layout.copyWith(
        left: indent + (layout.left * availableWidth),
        width: layout.width * availableWidth,
      ));
    }

    return layouts;
  } else {
    // --- "Pack" Layout  ---
    // If it is not a "Flow", the entire (sub)group is uses the column-packing algorithm.
    return _packEventsIntoColumns(group, fixedHeightPerHour);
  }
}

/// Column-packing algorithm.
List<EventLayout> _packEventsIntoColumns(List<CalendarEntry> events, double fixedHeightPerHour) {
  if (events.isEmpty) return [];

  final Map<CalendarEntry, EventLayoutGridPosition> eventLayoutGridPosition = {};
  final List<List<CalendarEntry>> columns = [];

  // Events are initially placed one by one into the first available column
  for (final event in events) {
    bool placed = false;
    for (int i = 0; i < columns.length; i++) {
      if (!event.isOverlapping(columns[i].last)) {
        columns[i].add(event);
        eventLayoutGridPosition[event] = EventLayoutGridPosition(column: i);
        placed = true;
        break;
      }
    }
    if (!placed) {
      columns.add([event]);
      eventLayoutGridPosition[event] = EventLayoutGridPosition(column: columns.length - 1);
    }
  }

  final int numColumns = columns.length;

  // After initial placing, if events can expand into column space to the right, they get more space.
  for (int i = 0; i < columns.length; i++) {
    for (final CalendarEntry event in columns[i]) {
      final info = eventLayoutGridPosition[event]!;
      int colSpan = 1;
      for (int j = i + 1; j < numColumns; j++) {
        bool canExpand = true;
        for (final otherEvent in columns[j]) {
          if (event.isOverlapping(otherEvent)) {
            canExpand = false;
            break; // overlap found, no more checking here
          }
        }

        if (canExpand) {
          colSpan++;
        } else {
          break; // Blocked by the column, cannot expand further
        }
      }
      info.colSpan = colSpan;
    }
  }

  // EventLayout objects for this group
  final double widthPerColumn = 1.0 / numColumns;
  return List.generate(events.length, (index) {
    final event = events[index];
    final info = eventLayoutGridPosition[event]!;
    return EventLayout(
      entry: event,
      top: _calculatePixelPosition(event.startTime, fixedHeightPerHour),
      height: (event.duration.inMinutes / 60) * fixedHeightPerHour,
      left: info.column * widthPerColumn,
      width: info.colSpan * widthPerColumn,
    );
  }, growable: false);
}

/// Calculates the vertical pixel position of an event based on its start time.
double _calculatePixelPosition(DateTime time, double fixedHeightPerHour) {
  final double hoursIntoDay = time.hour + (time.minute / 60.0);
  return hoursIntoDay * fixedHeightPerHour;
}
