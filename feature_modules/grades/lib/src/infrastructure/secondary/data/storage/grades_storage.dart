import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/grade_dto.dart';

class GradesStorage {
  final _gradesKey = 'grades_data_key';

  Future<void> saveGrades(List<GradeDto> grades) async {
    final prefs = await SharedPreferences.getInstance();
    final gradesJson = jsonEncode(grades.map((g) => g.toJson()).toList());
    prefs.setString(_gradesKey, gradesJson);
  }

  Future<List<GradeDto>?> getGrades() async {
    final prefs = await SharedPreferences.getInstance();
    final gradesJson = prefs.getString(_gradesKey);
    if (gradesJson == null) return null;
    final List<dynamic> decoded = jsonDecode(gradesJson);
    return decoded.map((e) => GradeDto.fromJson(e)).toList();
  }

  Future<void> deleteGrades() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_gradesKey);
  }
}
