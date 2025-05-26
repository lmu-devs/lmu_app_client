import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/people_dto.dart';

class PeopleStorage {
  final _peopleKey = 'people_data_key';

  Future<void> savePeople(PeopleDto people) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_peopleKey, jsonEncode(people.toJson()));
  }

  Future<PeopleDto?> getPeople() async {
    final prefs = await SharedPreferences.getInstance();
    final peopleJson = prefs.getString(_peopleKey);
    if (peopleJson == null) return null;
    final peopleMap = jsonDecode(peopleJson);
    return PeopleDto.fromJson(peopleMap);
  }

  Future<void> deletePeople() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_peopleKey);
  }
}
