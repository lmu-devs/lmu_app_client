import 'dart:async';
import 'dart:math' as math;

import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_entry.dart';
import '../constants.dart';
import '../view/calendar_event_contentsheet.dart';
import 'calendar_entry_card.dart';
import 'current_time_indicator.dart';
import 'layout_helpers/event_layout.dart';
import 'layout_helpers/event_layout_algorithm.dart';
import 'time_grid.dart';

class CalendarEntriesDayView extends StatefulWidget {
  const CalendarEntriesDayView({super.key, required this.entries, required this.isToday});

  final List<CalendarEntry> entries;
  final bool isToday;

  @override
  State<CalendarEntriesDayView> createState() => _CalendarEntriesDayViewState();
}

class _CalendarEntriesDayViewState extends State<CalendarEntriesDayView> {
  static const double _fixedHeightPerHour = fixedHeightPerHour;

  static const double _hourLabelColumnWidth = 50.0;

  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  DateTime _currentTime = DateTime.now();
  double opacityValue = 0;

  late Future<List<EventLayout>> _layoutCalculation;

  @override
  void initState() {
    super.initState();
    _calculateEventsLayouts();

    // Auto-scroll to current hour regardless of the day
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToCurrentHour();
      _startCurrentTimeUpdater();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    _layoutCalculation = Future.value([]);
    _opacityLoopActive = false;
    super.dispose();
  }

  void _jumpToCurrentHour() {
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
  void didUpdateWidget(CalendarEntriesDayView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entries != oldWidget.entries) {
      _calculateEventsLayouts();
    }
  }

  // Background calculation for laying out the events
  // As an isolate, because this 'could' be a CPU-intensive task (on large datasets or old phones),
  // and the rest of the ui can already be responsive!
  void _calculateEventsLayouts() {
    final params = EventLayoutParams(
      entries: widget.entries,
      fixedHeightPerHour: _fixedHeightPerHour,
    );
    _layoutCalculation = compute(calculateLayoutsInBackground, params);

    _opacityLoopActive = true;
    animateLoadingOpacity();

    // When the layout calculation is done the animatedLoadingOpacity will stop
    _layoutCalculation.then((_) {
      _opacityLoopActive = false;
    });
  }

  bool _opacityLoopActive = false;

  void animateLoadingOpacity() {
    if (!_opacityLoopActive) return;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _opacityLoopActive) {
        setState(() {
          opacityValue = (opacityValue == 1.0) ? 0.0 : 1.0;
        });
        animateLoadingOpacity();
      }
    });
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
                        isToday: widget.isToday,
                      ),
                    ),

                    // --- Event Cards  ---
                    FutureBuilder<List<EventLayout>>(
                      future: _layoutCalculation,
                      builder: (context, snapshot) {
                        // If calculation the events takes some time, there is a subtle pulsing animation over the whole timeline
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: opacityValue,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: Container(
                                color: context.colors.neutralColors.backgroundColors.base.withAlpha(180),
                              ),
                            ),
                          );
                        }
                        // If there's an error (highly unlikely)
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        // Build the cards
                        if (snapshot.hasData) {
                          final eventLayouts = snapshot.data!;
                          return Stack(
                            children: eventLayouts.map((layout) {
                              final double eventCardLeft = _hourLabelColumnWidth + (layout.left * eventAreaWidth);
                              return Positioned(
                                top: layout.top,
                                left: eventCardLeft,
                                width: layout.width * eventAreaWidth,
                                height: layout.height,
                                child: CalendarCard.bounded(
                                  entry: layout.entry,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => CalendarEventBottomSheet(event: layout.entry),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        }
                        // No Calendar Entries on that day
                        return const SizedBox.shrink();
                      },
                    ),

                    // --- Current Time Indicator Line (drawn on top of events) ---
                    if (widget.isToday)
                      IgnorePointer(
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: CurrentTimeIndicatorPainter(
                            heightPerHour: _fixedHeightPerHour,
                            hourLabelWidth: _hourLabelColumnWidth,
                            textStyle: Theme.of(context).textTheme.bodySmall!,
                            currentTime: _currentTime,
                          ),
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
