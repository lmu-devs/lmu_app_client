import 'package:widget_driver/widget_driver.dart';

class LectureDetailPageDriver extends WidgetDriver {
  LectureDetailPageDriver({
    required this.lectureId,
    required this.lectureTitle,
  });

  final String lectureId;
  final String lectureTitle;

  // Getters for UI
  String get displayLectureTitle => lectureTitle;
  String get displayLectureId => lectureId;
}
