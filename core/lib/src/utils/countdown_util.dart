import '../../localizations.dart';

class CountdownUtil {
  static String getRemainingTime(
    AppLocalizations appLocals,
    DateTime startDate,
    DateTime endDate,
  ) {
    final duration = endDate.difference(startDate);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (days > 0) {
      return appLocals.remainingDays(days.toString());
    } else if (hours > 0) {
      return appLocals.remainingHours(hours.toString());
    } else if (minutes > 0) {
      return appLocals.remainingMinutes(minutes.toString());
    } else {
      return appLocals.remainingSeconds(seconds.toString());
    }
  }
}
