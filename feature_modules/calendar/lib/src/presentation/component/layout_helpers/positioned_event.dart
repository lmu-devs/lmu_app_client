import '../../../domain/model/calendar_entry.dart';

class PositionedEvent {
  PositionedEvent(this.entry, this.column);
  final CalendarEntry entry;
  final int column;
}
