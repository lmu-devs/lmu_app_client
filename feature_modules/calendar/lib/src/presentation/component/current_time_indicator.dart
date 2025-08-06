import 'package:flutter/material.dart';

import '../../domain/model/helper/date_time_formatter.dart';

class CurrentTimeIndicatorPainter extends CustomPainter {
  CurrentTimeIndicatorPainter({
    required this.heightPerHour,
    required this.hourLabelWidth,
    required this.textStyle,
    required this.currentTime,
    this.lineColor = Colors.red,
  });
  final double heightPerHour;
  final double hourLabelWidth;
  final TextStyle textStyle;
  final DateTime currentTime;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double currentMinuteIntoDay = currentTime.hour * 60 + currentTime.minute + currentTime.second / 60.0;
    final double y = (currentMinuteIntoDay / 60.0) * heightPerHour;

    // Draw the red line
    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0; // Thicker for emphasis
    canvas.drawLine(Offset(hourLabelWidth, y), Offset(size.width, y), linePaint);

    // Draw the red dot
    final Paint dotPaint = Paint()..color = lineColor;
    canvas.drawCircle(Offset(hourLabelWidth, y), 5.0, dotPaint); // Dot radius 5.0

    // Draw the current time label
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: DateTimeFormatter.formatTimeForLocale(currentTime),
        style: textStyle.copyWith(
          color: lineColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(hourLabelWidth - tp.width - 10, y - tp.height / 2)); // 10 units padding
  }

  @override
  bool shouldRepaint(covariant CurrentTimeIndicatorPainter oldDelegate) {
    // Repaint if time changes significantly (e.g., every minute)
    return oldDelegate.currentTime.minute != currentTime.minute || oldDelegate.currentTime.hour != currentTime.hour;
  }
}
