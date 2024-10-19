class MensaDay extends DateTime {
  MensaDay(super.year, super.month, super.day);

  factory MensaDay.now() {
    final now = DateTime.now();
    return MensaDay(now.year, now.month, now.day);
  }

  MensaDay addDuration(Duration duration) {
    DateTime dateTime = DateTime(year, month, day);
    DateTime newDateTime = dateTime.add(duration);

    /// Daylight Saving Time Check
    if (newDateTime.year == year && newDateTime.month == month && newDateTime.day == day) {
      newDateTime = newDateTime.add(const Duration(hours: 1));
    }

    return MensaDay(newDateTime.year, newDateTime.month, newDateTime.day);
  }

  MensaDay subtractDuration(Duration duration) {
    DateTime dateTime = DateTime(year, month, day);
    DateTime newDateTime = dateTime.subtract(duration);

    /// Daylight Saving Time Check
    if (newDateTime.year == year && newDateTime.month == month && newDateTime.day == day) {
      newDateTime = newDateTime.subtract(const Duration(hours: 1));
    }

    return MensaDay(newDateTime.year, newDateTime.month, newDateTime.day);
  }

  bool isEqualTo(MensaDay other) {
    return (year == other.year && month == other.month && day == other.day);
  }

  @override
  String toString() {
    MensaDay now = MensaDay.now();

    if (isEqualTo(now)) {
      return 'Today';
    } else {
      return weekday == DateTime.monday
          ? 'Mo. $day'
          : weekday == DateTime.tuesday
              ? 'Di. $day'
              : weekday == DateTime.wednesday
                  ? 'Mi. $day'
                  : weekday == DateTime.thursday
                      ? 'Do. $day'
                      : weekday == DateTime.friday
                          ? 'Fr. $day'
                          : weekday == DateTime.saturday
                              ? 'Sa. $day'
                              : 'So. $day';
    }
  }
}
