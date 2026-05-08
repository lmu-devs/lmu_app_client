import '../../../domain/model/calendar_entry.dart';

class EventLayout {
  EventLayout({
    required this.entry,
    required this.top,
    required this.height,
    required this.left,
    required this.width,
  });

  final CalendarEntry entry;
  final double top;
  final double height;
  final double left;
  final double width;

  EventLayout copyWith({
    CalendarEntry? entry,
    double? top,
    double? height,
    double? left,
    double? width,
  }) {
    return EventLayout(
      entry: entry ?? this.entry,
      top: top ?? this.top,
      height: height ?? this.height,
      left: left ?? this.left,
      width: width ?? this.width,
    );
  }
}
