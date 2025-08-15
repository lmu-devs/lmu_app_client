import 'package:flutter/widgets.dart';

import '../../domain/model/helper/date_time_formatter.dart';

class TimeGridPainter extends CustomPainter {
  TimeGridPainter({
    required this.heightPerHour,
    required this.lineColor,
    required this.textStyle,
    this.hourLabelWidth = 50.0,
    this.currentTime,
    required this.isToday,
  });

  final double heightPerHour;
  final Color lineColor;
  final TextStyle textStyle;
  final double hourLabelWidth;
  final DateTime? currentTime;
  final bool isToday;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = lineColor.withAlpha(75)
      ..strokeWidth = 0.5;

    final Paint hourLinePaint = Paint()
      ..color = lineColor.withAlpha(75)
      ..strokeWidth = 1.0;

    // Calculate the Y-position for the current time line
    double? currentTimeY;
    if (currentTime != null) {
      final double currentMinuteIntoDay = currentTime!.hour.toDouble() * 60 + currentTime!.minute.toDouble();
      currentTimeY = (currentMinuteIntoDay / 60.0) * heightPerHour;
    }
    const double exclusionMinutes = 5.0;
    final double exclusionPixels = (exclusionMinutes / 60.0) * heightPerHour;

    for (int hour = 0; hour < 24; hour++) {
      final double y = hour * heightPerHour;

      // Check if this hour line is within the exclusion zone of currentTimeY to know if to raw it or not
      bool skipHourLine = false;
      bool skipHourText = false;
      bool isCurrentTimeIsSetAndIsToday = currentTimeY != null && isToday;

      if (isCurrentTimeIsSetAndIsToday) {
        if ((y >= currentTimeY - exclusionPixels) && (y <= currentTimeY + exclusionPixels)) {
          skipHourLine = true;
        }
        if ((y >= currentTimeY - exclusionPixels * 2) && (y <= currentTimeY + exclusionPixels * 2)) {
          skipHourText = true;
        }
      }

      if (!skipHourLine) {
        canvas.drawLine(Offset(hourLabelWidth, y), Offset(size.width, y), hourLinePaint);
      }
      if (!skipHourText) {
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: DateTimeFormatter.formatTimeForLocale(DateTime(0, 1, 1, hour)),
            style: textStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(hourLabelWidth - tp.width - 5, y - tp.height / 2));
      }

      // Quarter hour lines
      for (int minute = 15; minute < 60; minute += 15) {
        final double minuteY = y + (minute / 60.0 * heightPerHour);

        // Check if this quarter-hour line is within the exclusion zone of currentTimeY
        bool skipMinuteLine = false;
        if (isCurrentTimeIsSetAndIsToday) {
          if ((minuteY >= currentTimeY - exclusionPixels) && (minuteY <= currentTimeY + exclusionPixels)) {
            skipMinuteLine = true;
          }
        }

        // Quarter hour line if not skipped
        if (!skipMinuteLine) {
          canvas.drawLine(Offset(hourLabelWidth, minuteY), Offset(size.width, minuteY), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant TimeGridPainter oldDelegate) {
    // repainting if data changes
    return oldDelegate.heightPerHour != heightPerHour ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.hourLabelWidth != hourLabelWidth ||
        oldDelegate.currentTime != currentTime;
  }
}
