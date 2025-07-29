import 'frequency.dart';

class CalendarRule {
  CalendarRule({
    required this.frequency,
    required this.interval,
    this.untilTime,
  });

  final Frequency frequency;
  final int interval;
  final DateTime? untilTime;

  /// Checks if the rule is still active at the given [date].
  bool isActiveOn(DateTime date) {
    if (untilTime != null && date.isAfter(untilTime!)) {
      return false;
    }
    return true;
  }

  /// Checks if the rule has an end date.
  bool get hasEndDate => untilTime != null;

  /// Checks if the rule is recurring (interval > 1 or has an end date).
  bool get isRecurring => interval > 1 || hasEndDate;

  /// Checks if the rule matches a specific frequency.
  bool isOfFrequency(Frequency freq) => frequency == freq;
}
