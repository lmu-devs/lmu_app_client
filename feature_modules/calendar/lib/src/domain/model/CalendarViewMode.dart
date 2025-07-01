enum CalendarViewMode {
  list,
  day,
}

extension CalendarViewModeExtension on CalendarViewMode {
  String get name {
    switch (this) {
      case CalendarViewMode.list:
        return 'List';
      case CalendarViewMode.day:
        return 'Day';
    }
  }

  String get iconName {
    switch (this) {
      case CalendarViewMode.list:
        return 'list';
      case CalendarViewMode.day:
        return 'day';
    }
  }
}
