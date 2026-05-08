import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/course_dto.dart';

class CoursesStorage {
  final _coursesKey = 'courses_data_key';

  Future<void> saveCourses(CourseDto courses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_coursesKey, jsonEncode(courses.toJson()));
  }

  Future<CourseDto?> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final coursesJson = prefs.getString(_coursesKey);
    if (coursesJson == null) return null;
    final coursesMap = jsonDecode(coursesJson);
    return CourseDto.fromJson(coursesMap);
  }

  Future<void> deleteCourses() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_coursesKey);
  }
}
