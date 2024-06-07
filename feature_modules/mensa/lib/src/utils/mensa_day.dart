class MensaDay extends DateTime {
  MensaDay(super.year, super.month, super.day);

  factory MensaDay.now() {
    final now = DateTime.now();
    return MensaDay(now.year, now.month, now.day);
  }

  MensaDay addDuration(Duration duration) {
    DateTime dateTime = DateTime(year, month, day);
    dateTime = dateTime.add(duration);
    return MensaDay(dateTime.year, dateTime.month, dateTime.day);
  }

  MensaDay subtractDuration(Duration duration) {
    DateTime dateTime = DateTime(year, month, day);
    dateTime = dateTime.subtract(duration);
    return MensaDay(dateTime.year, dateTime.month, dateTime.day);
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
      return weekday == 1
          ? 'Mo. $day'
          : weekday == 2
              ? 'Di. $day'
              : weekday == 3
                  ? 'Mi. $day'
                  : weekday == 4
                      ? 'Do. $day'
                      : weekday == 5
                          ? 'Fr. $day'
                          : weekday == 6
                              ? 'Sa. $day'
                              : 'So. $day';
    }
  }
}
