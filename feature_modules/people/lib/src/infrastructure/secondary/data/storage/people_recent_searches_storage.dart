import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/model/people.dart';

class PeopleRecentSearchesStorage {
  static const String _recentSearchesKey = 'people_recent_searches';
  static const int _maxRecentSearches = 10;

  Future<List<People>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearchesJson = prefs.getStringList(_recentSearchesKey) ?? [];
    
    final List<People> recentSearches = [];
    for (final jsonString in recentSearchesJson) {
      try {
        final Map<String, dynamic> personMap = jsonDecode(jsonString);
        recentSearches.add(_mapFromJson(personMap));
      } catch (e) {
        continue;
      }
    }
    
    return recentSearches;
  }

  Future<void> saveRecentSearches(List<People> recentSearches) async {
    final prefs = await SharedPreferences.getInstance();
    
    final limitedSearches = recentSearches.take(_maxRecentSearches).toList();
    
    final List<String> recentSearchesJson = limitedSearches
        .map((person) => jsonEncode(_mapToJson(person)))
        .toList();
    
    await prefs.setStringList(_recentSearchesKey, recentSearchesJson);
  }

  Future<void> addRecentSearch(People person) async {
    final currentSearches = await getRecentSearches();
    
    currentSearches.removeWhere((p) => p.id == person.id);
    
    currentSearches.insert(0, person);
    
    await saveRecentSearches(currentSearches);
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }

  Map<String, dynamic> _mapToJson(People person) {
    return {
      'id': person.id,
      'name': person.name,
      'surname': person.surname,
      'title': person.title,
      'academicDegree': person.academicDegree,
      'facultyId': person.facultyId,
      'faculty': person.faculty,
      'role': person.role,
      'email': person.email,
      'phone': person.phone,
      'website': person.website,
      'room': person.room,
      'consultation': person.consultation,
    };
  }

  People _mapFromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      title: json['title'] as String,
      academicDegree: json['academicDegree'] as String?,
      facultyId: json['facultyId'] as int,
      faculty: json['faculty'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      room: json['room'] as String,
      consultation: json['consultation'] as String,
    );
  }
} 