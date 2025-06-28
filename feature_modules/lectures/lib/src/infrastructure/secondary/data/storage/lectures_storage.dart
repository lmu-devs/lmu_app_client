import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/lectures_dto.dart';

class LecturesStorage {
  final _lecturesKey = 'lectures_data_key';

  Future<void> saveLectures(LecturesDto lectures) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lecturesKey, jsonEncode(lectures.toJson()));
  }

  Future<LecturesDto?> getLectures() async {
    final prefs = await SharedPreferences.getInstance();
    final lecturesJson = prefs.getString(_lecturesKey);
    if (lecturesJson == null) return null;
    final lecturesMap = jsonDecode(lecturesJson);
    return LecturesDto.fromJson(lecturesMap);
  }

  Future<void> deleteLectures() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_lecturesKey);
  }
}
