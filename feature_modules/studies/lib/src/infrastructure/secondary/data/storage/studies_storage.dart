import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/faculty_dto.dart';

class StudiesStorage {
  final _facultiesKey = 'faculties';
  final _selectedFacultiesKey = 'selectedFaculties';

  Future<void> saveFaculites(List<FacultyDto> faculties) async {
    final prefs = await SharedPreferences.getInstance();
    final facultyStrings = faculties.map((f) => jsonEncode(f.toJson())).toList();
    await prefs.setStringList(_facultiesKey, facultyStrings);
  }

  Future<List<FacultyDto>> getFaculties() async {
    final prefs = await SharedPreferences.getInstance();
    final facultyStrings = prefs.getStringList(_facultiesKey) ?? [];
    return facultyStrings.map((str) => FacultyDto.fromJson(jsonDecode(str))).toList();
  }

  Future<void> saveSelectedFaculties(List<int> facultyIds) async {
    final prefs = await SharedPreferences.getInstance();
    final idStrings = facultyIds.map((id) => id.toString()).toList();
    await prefs.setStringList(_selectedFacultiesKey, idStrings);
  }

  Future<List<int>> getSelectedFaculties() async {
    final prefs = await SharedPreferences.getInstance();
    final idStrings = prefs.getStringList(_selectedFacultiesKey) ?? [];
    return idStrings.map(int.parse).toList();
  }

  Future<void> clearSelectedFaculties() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedFacultiesKey);
  }
}
