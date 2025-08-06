import 'dart:async';
import 'dart:math' as math;

import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../component/calendar_entry_card_dynamic.dart';
import '../component/current_time_indicator.dart';
import '../component/layout-helpers/event_layout.dart';
import '../component/layout-helpers/positioned_event.dart';
import '../component/time_grid.dart';
import '../constants.dart';
import 'calendar_event_contentsheet.dart';

// class CalendarTestRoute extends DrivableWidget<CalendarPageDriver> {
class CalendarEntriesDayView extends StatelessWidget {
  const CalendarEntriesDayView({super.key, required this.entries});

  final List<CalendarEntry> entries;

  @override
  Widget build(BuildContext context) {
    return DayTimelinePage(events: entries);
  }

  // @override
  // WidgetDriverProvider<CalendarPageDriver> get driverProvider => $CalendarPageDriverProvider();
}
// --- DayTimelinePage (Main View) ---

class DayTimelinePage extends StatefulWidget {
  final List<CalendarEntry> events;

  const DayTimelinePage({
    super.key,
    required this.events,
  });

  @override
  State<DayTimelinePage> createState() => _DayTimelinePageState();
}

class _DayTimelinePageState extends State<DayTimelinePage> {
  static const double _fixedHeightPerHour = fixedHeightPerHour;

  List<EventLayout> _eventLayouts = [];

  static const double _hourLabelColumnWidth = 50.0;

  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calculateEventLayouts();

    // Auto-scroll to current hour
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentHourMinusOne();
      _startCurrentTimeUpdater();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _scrollToCurrentHourMinusOne() {
    final now = DateTime.now();
    final targetHour = now.hour;
    final double scrollPosition = math.max(0.0, targetHour * _fixedHeightPerHour);

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(scrollPosition);
    }
  }

  void _startCurrentTimeUpdater() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
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
    List<DateTime> trackEndTimes = [];
    Map<CalendarEntry, int> eventTrackMap = {};
    List<List<CalendarEntry>> tracks = [];

    for (var currentEvent in sortedEvents) {
      int assignedTrackIndex = -1;

      for (int i = 0; i < trackEndTimes.length; i++) {
        if (currentEvent.startTime.isAtSameMomentAs(trackEndTimes[i]) ||
            currentEvent.startTime.isAfter(trackEndTimes[i])) {
          assignedTrackIndex = i;
          break;
        }
      }

      if (assignedTrackIndex == -1) {
        assignedTrackIndex = trackEndTimes.length;
        trackEndTimes.add(currentEvent.endTime);
        tracks.add([currentEvent]);
      } else {
        trackEndTimes[assignedTrackIndex] = currentEvent.endTime;
        tracks[assignedTrackIndex].add(currentEvent);
      }
      eventTrackMap[currentEvent] = assignedTrackIndex;
    }

    int maxConcurrentTracks = 0;
    List<DateTime> timePoints = [];
    for (var event in sortedEvents) {
      timePoints.add(event.startTime);
      timePoints.add(event.endTime);
    }
    timePoints.sort();
    timePoints = timePoints.toSet().toList()..sort();

    for (int i = 0; i < timePoints.length - 1; i++) {
      DateTime intervalStart = timePoints[i];
      DateTime intervalEnd = timePoints[i + 1];
      if (intervalStart == intervalEnd) continue;

      int currentConcurrentCount = 0;
      List<CalendarEntry> eventsInThisInterval = [];
      for (var event in sortedEvents) {
        if (event.startTime.isBefore(intervalEnd) && event.endTime.isAfter(intervalStart)) {
          currentConcurrentCount++;
          eventsInThisInterval.add(event);
        }
      }
      maxConcurrentTracks = math.max(maxConcurrentTracks, currentConcurrentCount);
    }

    if (maxConcurrentTracks == 0 && sortedEvents.isNotEmpty) {
      maxConcurrentTracks = 1;
    } else if (sortedEvents.isEmpty) {
      maxConcurrentTracks = 0;
    }

    List<DateTime?> columnsEndTime = List.generate(maxConcurrentTracks, (_) => null);
    List<PositionedEvent> positionedEvents = [];

    for (var event in sortedEvents) {
      int assignedColumn = -1;
      for (int c = 0; c < maxConcurrentTracks; c++) {
        if (columnsEndTime[c] == null ||
            event.startTime.isAtSameMomentAs(columnsEndTime[c]!) ||
            event.startTime.isAfter(columnsEndTime[c]!)) {
          assignedColumn = c;
          break;
        }
      }

      if (assignedColumn == -1) {
        assignedColumn = 0;
        DateTime? earliestEndTime = columnsEndTime[0];
        for (int c = 1; c < maxConcurrentTracks; c++) {
          if (columnsEndTime[c] != null && (earliestEndTime == null || columnsEndTime[c]!.isBefore(earliestEndTime))) {
            earliestEndTime = columnsEndTime[c];
            assignedColumn = c;
          }
        }
      }

      columnsEndTime[assignedColumn] = event.endTime;
      positionedEvents.add(PositionedEvent(event, assignedColumn));

      // positionedEvents.add({'event': event, 'column': assignedColumn});
    }

    final double columnWidthFraction = maxConcurrentTracks > 0 ? (1.0 / maxConcurrentTracks) : 1.0;

    for (var positionedEvent in positionedEvents) {
      final event = positionedEvent.entry;
      final column = positionedEvent.column;

      final double top = _calculatePixelPosition(event.startTime);
      final double finalHeight = (event.duration.inMinutes / 60) * _fixedHeightPerHour;
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

  double _calculatePixelPosition(DateTime time) {
    final double hoursIntoDay = time.hour + (time.minute / 60.0);
    return hoursIntoDay * _fixedHeightPerHour;
  }

  @override
  Widget build(BuildContext context) {
    const double totalTimelineHeight = 24 * _fixedHeightPerHour;

    return CustomScrollView(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double actualTimelineWidth = constraints.maxWidth;
              final double eventAreaWidth = actualTimelineWidth - _hourLabelColumnWidth;

              return SizedBox(
                height: totalTimelineHeight,
                width: actualTimelineWidth,
                child: Stack(
                  children: [
                    // --- Time Grid ---
                    CustomPaint(
                      size: Size.infinite,
                      painter: TimeGridPainter(
                        heightPerHour: _fixedHeightPerHour,
                        lineColor: Theme.of(context).dividerColor,
                        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ) ??
                            const TextStyle(fontSize: 10, color: Colors.black),
                        hourLabelWidth: _hourLabelColumnWidth,
                        currentTime: _currentTime,
                      ),
                    ),
                    // --- Event Cards ---
                    ..._eventLayouts.map((layout) {
                      double finalEventCardWidth = math.max(eventAreaWidth, 20.0);
                      for (var e in _eventLayouts) {
                        if (e.entry.isOverlapping(layout.entry) && layout.entry.id != e.entry.id) {
                          finalEventCardWidth = math.max(layout.width * eventAreaWidth, 20.0);
                        }
                      }
                      final double eventCardLeft = _hourLabelColumnWidth + (layout.left * eventAreaWidth);

                      return Positioned(
                        top: layout.top,
                        left: eventCardLeft,
                        width: finalEventCardWidth,
                        height: layout.height,
                        child: Padding(
                          padding: const EdgeInsets.only(left: LmuSizes.size_4, right: LmuSizes.size_4),
                          child: CalendarCard(
                            entry: layout.entry,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => CalendarEventBottomSheet(event: layout.entry),
                              );
                            },
                          ),
                        ),
                      );
                    }),

                    // --- Current Time Indicator Line (at the bottom, so it lays over the events cards) ---
                    CustomPaint(
                      size: Size.infinite,
                      painter: CurrentTimeIndicatorPainter(
                        heightPerHour: _fixedHeightPerHour,
                        hourLabelWidth: _hourLabelColumnWidth,
                        textStyle: Theme.of(context).textTheme.bodySmall!,
                        currentTime: _currentTime,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
