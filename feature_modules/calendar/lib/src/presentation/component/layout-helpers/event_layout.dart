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
}
