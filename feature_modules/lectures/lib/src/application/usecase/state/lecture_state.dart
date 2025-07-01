import 'package:flutter/material.dart';

import '../../../domain/model/lectures.dart';

class LectureStateService {
  final ValueNotifier<Map<String, List<Lectures>>> groupedLecturesNotifier = ValueNotifier({});

  void updateLectures(List<Lectures> lectures) {
    final grouped = <String, List<Lectures>>{};
    for (var lecture in lectures) {
      final letter = lecture.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []).add(lecture);
    }
    groupedLecturesNotifier.value = grouped;
  }
}
