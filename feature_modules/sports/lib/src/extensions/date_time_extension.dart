import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get formattedDate => DateFormat('dd.MM').format(this);
  String get formattedTime => DateFormat('HH:mm').format(this);
}
