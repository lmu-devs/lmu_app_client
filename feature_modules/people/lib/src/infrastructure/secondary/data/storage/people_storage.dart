import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/people_category_dto.dart';

class PeopleStorage {
  final _peopleKey = 'people_data_key';
  final _peopleCacheTimeKey = 'benefits_cache_time';
  final _peopleCacheTime = const Duration(days: 14);

  Future<void> savePeople(List<PeopleCategoryDto> people) async {
    final prefs = await SharedPreferences.getInstance();
    final peopleJson = jsonEncode(people.map((e) => e.toJson()).toList());
    await prefs.setString(_peopleKey, peopleJson);
    await prefs.setInt(_peopleCacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<PeopleCategoryDto>?> getPeople() async {
    final prefs = await SharedPreferences.getInstance();
    final peopleJson = prefs.getString(_peopleKey);
    if (peopleJson == null) return null;
    final cacheTime = prefs.getInt(_peopleCacheTimeKey);
    final isCacheValid = cacheTime != null && _isCacheValid(cacheTime);
    if (!isCacheValid) {
      prefs.remove(_peopleKey);
      return null;
    }

    try {
      final peopleList = jsonDecode(peopleJson) as List;
      return peopleList
          .map((e) => PeopleCategoryDto.fromJsonEntry(MapEntry((e as Map<String, dynamic>)['name'], e['people'])))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> deletePeople() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_peopleKey);
  }

  bool _isCacheValid(int? cacheTime) {
    if (cacheTime == null) return false;
    final cacheDate = DateTime.fromMillisecondsSinceEpoch(cacheTime);
    return cacheDate.add(_peopleCacheTime).isAfter(DateTime.now());
  }
}
