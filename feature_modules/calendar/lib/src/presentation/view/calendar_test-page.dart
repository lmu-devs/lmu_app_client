import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import '../../domain/model/mock_events.dart';
import '../component/calendar_entry_card-dynamic-test.dart' show CalendarCard;

// class CalendarTestRoute extends DrivableWidget<CalendarPageDriver> {
class CalendarTest extends StatelessWidget {
  const CalendarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return DayTimelinePage(events: mockCalendarEntries);
  }

  // @override
  // WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}

class PositionedEvent {
  final CalendarEntry entry;
  final int column;

  PositionedEvent(this.entry, this.column);
}

// --- TimeGridPainter ---
class TimeGridPainter extends CustomPainter {
  final double heightPerHour;
  final Color lineColor;
  final TextStyle textStyle;
  final double hourLabelWidth;

  TimeGridPainter({
    required this.heightPerHour,
    required this.lineColor,
    required this.textStyle,
    this.hourLabelWidth = 50.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = lineColor.withOpacity(0.3)
      ..strokeWidth = 0.5;

    final Paint hourLinePaint = Paint()
      ..color = lineColor.withOpacity(0.6)
      ..strokeWidth = 1.0;

    for (int hour = 0; hour < 24; hour++) {
      final double y = hour * heightPerHour;

      // Draw hour line
      canvas.drawLine(Offset(hourLabelWidth, y), Offset(size.width, y), hourLinePaint);

      // Draw hour label
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: DateTimeFormatter.formatTimeForLocale(DateTime(0, 1, 1, hour)),
          style: textStyle, // This is already TextStyle
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(hourLabelWidth - tp.width - 5, y - tp.height / 2));

      // Draw quarter hour lines
      for (int minute = 15; minute < 60; minute += 15) {
        final double minuteY = y + (minute / 60.0 * heightPerHour);
        canvas.drawLine(Offset(hourLabelWidth, minuteY), Offset(size.width, minuteY), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant TimeGridPainter oldDelegate) {
    return oldDelegate.heightPerHour != heightPerHour ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.hourLabelWidth != hourLabelWidth;
  }
}

// --- Event Layout Model ---
class EventLayout {
  final CalendarEntry entry;
  final double top;
  final double height;
  final double left;
  final double width;

  EventLayout({
    required this.entry,
    required this.top,
    required this.height,
    required this.left,
    required this.width,
  });
}

// --- DayTimelinePage (Main View) ---

class DayTimelinePage extends StatefulWidget {
  final List<CalendarEntry> events; // Events for the specific day

  const DayTimelinePage({
    super.key,
    required this.events,
  });

  @override
  State<DayTimelinePage> createState() => _DayTimelinePageState();
}

class _DayTimelinePageState extends State<DayTimelinePage> {
  static const double _fixedHeightPerHour = 80.0; // A reasonable default, e.g., 80 pixels per hour

  List<EventLayout> _eventLayouts = [];
  static const double _eventSpacing = 4.0; // Horizontal space between overlapping events

  static const double _hourLabelColumnWidth = 50.0;

  @override
  void initState() {
    super.initState();
    _calculateEventLayouts(); // Initial layout calculation
  }

  @override
  void didUpdateWidget(DayTimelinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.events != oldWidget.events) {
      _calculateEventLayouts();
    }
  }

  // --- The Overlap Layout Algorithm ---
  void _calculateEventLayouts() {
    if (widget.events.isEmpty) {
      if (_eventLayouts.isNotEmpty) {
        setState(() {
          _eventLayouts = [];
        });
      }
      return;
    }

    final List<CalendarEntry> sortedEvents = List<CalendarEntry>.from(widget.events)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    final List<EventLayout> newLayouts = [];
    // This will store a list of active "tracks", where each track is represented
    // by the endTime of the last event placed in it.
    List<DateTime> trackEndTimes = [];
    // This map helps us assign a track index to each event for layout
    Map<CalendarEntry, int> eventTrackMap = {};
    // This list will track the actual events assigned to each track,
    // so we can determine the maximum number of simultaneous tracks.
    List<List<CalendarEntry>> tracks = [];

    for (var currentEvent in sortedEvents) {
      int assignedTrackIndex = -1;

      // Find an existing track where this event can fit
      for (int i = 0; i < trackEndTimes.length; i++) {
        // If the current event starts at or after the end time of the last event in this track,
        // it can be placed in this track.
        if (currentEvent.startTime.isAtSameMomentAs(trackEndTimes[i]) ||
            currentEvent.startTime.isAfter(trackEndTimes[i])) {
          assignedTrackIndex = i;
          break;
        }
      }

      if (assignedTrackIndex == -1) {
        // No suitable track found, create a new one
        assignedTrackIndex = trackEndTimes.length;
        trackEndTimes.add(currentEvent.endTime);
        tracks.add([currentEvent]);
      } else {
        // Update the end time for the assigned track
        trackEndTimes[assignedTrackIndex] = currentEvent.endTime;
        tracks[assignedTrackIndex].add(currentEvent);
      }
      eventTrackMap[currentEvent] = assignedTrackIndex;
    }

    // Now, determine the maximum number of tracks that were used simultaneously
    // within the whole day, not just within one overlap group.
    // This is crucial for correctly calculating the width of each event.
    int maxConcurrentTracks = 0;
    // Let's re-evaluate tracks based on the actual event positions throughout the day
    // This is a common method for calculating column width in calendar views
    // based on maximum simultaneous overlaps.
    // Create "intervals" from all event start and end times
    List<DateTime> timePoints = [];
    for (var event in sortedEvents) {
      timePoints.add(event.startTime);
      timePoints.add(event.endTime);
    }
    timePoints.sort();
    timePoints = timePoints.toSet().toList()..sort(); // Get unique sorted time points

    for (int i = 0; i < timePoints.length - 1; i++) {
      DateTime intervalStart = timePoints[i];
      DateTime intervalEnd = timePoints[i + 1];
      if (intervalStart == intervalEnd) continue;

      int currentConcurrentCount = 0;
      List<CalendarEntry> eventsInThisInterval = [];
      for (var event in sortedEvents) {
        // An event is "active" in this interval if it starts before or at the interval end
        // and ends after or at the interval start.
        if (event.startTime.isBefore(intervalEnd) && event.endTime.isAfter(intervalStart)) {
          currentConcurrentCount++;
          eventsInThisInterval.add(event);
        }
      }
      maxConcurrentTracks = math.max(maxConcurrentTracks, currentConcurrentCount);
    }

    // If no overlaps, ensure at least one track for width calculation
    if (maxConcurrentTracks == 0 && sortedEvents.isNotEmpty) {
      maxConcurrentTracks = 1;
    } else if (sortedEvents.isEmpty) {
      maxConcurrentTracks = 0;
    }

    // A more robust way for column assignment:
    // Create a list to store active columns, each column stores the end time of the event
    // that currently occupies it.
    List<DateTime?> columnsEndTime = List.generate(maxConcurrentTracks, (_) => null);
    // List<Map<CalendarEntry, int>> positionedEvents = []; // To store event and its assigned column index
    List<PositionedEvent> positionedEvents = [];

    for (var event in sortedEvents) {
      int assignedColumn = -1;
      // Try to find an empty column, or a column where this event starts after the previous one ended
      for (int c = 0; c < maxConcurrentTracks; c++) {
        if (columnsEndTime[c] == null ||
            event.startTime.isAtSameMomentAs(columnsEndTime[c]!) ||
            event.startTime.isAfter(columnsEndTime[c]!)) {
          assignedColumn = c;
          break;
        }
      }

      if (assignedColumn == -1) {
        // If all columns are occupied and overlapping, it implies the `maxConcurrentTracks` was underestimated
        // for some complex overlap patterns. For now, try to find the earliest ending column and force fit.
        // This is a fallback and might not be ideal for all scenarios.
        assignedColumn = 0; // Default to first column
        DateTime? earliestEndTime = columnsEndTime[0];
        for (int c = 1; c < maxConcurrentTracks; c++) {
          if (columnsEndTime[c] != null && (earliestEndTime == null || columnsEndTime[c]!.isBefore(earliestEndTime))) {
            earliestEndTime = columnsEndTime[c];
            assignedColumn = c;
          }
        }
        // print('Warning: Could not find ideal column for ${event.title}, forcing into column $assignedColumn');
      }

      columnsEndTime[assignedColumn] = event.endTime;
      positionedEvents.add(PositionedEvent(event, assignedColumn));

      // positionedEvents.add({'event': event, 'column': assignedColumn});
    }

    // Now, generate EventLayouts using the assigned columns
    final double columnWidthFraction = maxConcurrentTracks > 0 ? (1.0 / maxConcurrentTracks) : 1.0;

    for (var positionedEvent in positionedEvents) {
      final event = positionedEvent.entry;
      final column = positionedEvent.column;

      final double top = _calculatePixelPosition(event.startTime);
      final double height = (event.duration.inMinutes / 60) * _fixedHeightPerHour;
      final double finalHeight = math.max(10.0, height);
      final double leftFraction = column * columnWidthFraction;

      newLayouts.add(EventLayout(
        entry: event,
        top: top,
        height: finalHeight,
        left: leftFraction,
        width: columnWidthFraction,
      ));
    }

    setState(() {
      _eventLayouts = newLayouts;
    });
  }

  // Helper to convert DateTime to pixel position from the start of the day
  double _calculatePixelPosition(DateTime time) {
    final double hoursIntoDay = time.hour + (time.minute / 60.0);
    return hoursIntoDay * _fixedHeightPerHour;
  }

  @override
  Widget build(BuildContext context) {
    final double totalTimelineHeight = 24 * _fixedHeightPerHour;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Test Page'),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            // hasScrollBody: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double actualTimelineWidth = constraints.maxWidth;
                final double eventAreaWidth = actualTimelineWidth - _hourLabelColumnWidth;

                return SizedBox(
                  height: totalTimelineHeight,
                  width: actualTimelineWidth,
                  child: Stack(
                    children: [
                      // --- Background Time Grid ---
                      CustomPaint(
                        size: Size.infinite,
                        painter: TimeGridPainter(
                          heightPerHour: _fixedHeightPerHour,
                          lineColor: Theme.of(context).dividerColor,

                          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    // Null-safe access
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ) ??
                              const TextStyle(fontSize: 10, color: Colors.black), // Fallback
                          hourLabelWidth: _hourLabelColumnWidth,
                        ),
                      ),
                      // --- Event Cards ---
                      ..._eventLayouts.map((layout) {
                        double finalEventCardWidth = math.max(eventAreaWidth, 20.0);
                        for (var _e in _eventLayouts) {
                          if (_e.entry.isOverlapping(layout.entry) && layout.entry.id != _e.entry.id) {
                            finalEventCardWidth = math.max(layout.width * eventAreaWidth, 20.0);
                          }
                        }
                        final double eventCardLeft = _hourLabelColumnWidth + (layout.left * eventAreaWidth);

                        return Positioned(
                          top: layout.top,
                          left: eventCardLeft,
                          width: finalEventCardWidth,
                          height: layout.height,
                          child: CalendarCard(
                            entry: layout.entry,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
