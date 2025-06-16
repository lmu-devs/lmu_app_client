import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../dto/people_category_dto.dart';
import '../dto/people_dto.dart';

class PeopleApiClient {
  final http.Client _client;
  final String _baseUrl;

  PeopleApiClient({
    required http.Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  Future<List<PeopleCategoryDto>> getPeople() async {
    try {
      print('🌐 Attempting to fetch people data from API...');
      final response = await _client.get(Uri.parse('$_baseUrl/people'));

      if (response.statusCode == 200) {
        print('✅ Successfully fetched data from API');
        final jsonData = jsonDecode(response.body) as List;
        return [
          PeopleCategoryDto(
            name: 'Faculty',
            people: jsonData.map((e) => PeopleDto.fromJson(e as Map<String, dynamic>)).toList(),
          )
        ];
      } else {
        print('⚠️ API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to load people data');
      }
    } catch (e) {
      print('⚠️ Fallback auf Mock-Daten wegen Fehler: $e');
      try {
        print('📂 Attempting to load mock data from assets...');
        final jsonString = await rootBundle.loadString('feature_modules/people/assets/people_results.json');
        print('📄 Successfully loaded JSON string from assets');

        final jsonData = jsonDecode(jsonString) as List;
        print('🔍 JSON data structure: ${jsonData.length} items');

        final categories = [
          PeopleCategoryDto(
            name: 'Faculty',
            people: jsonData.map((e) => PeopleDto.fromJson(e as Map<String, dynamic>)).toList(),
          )
        ];

        print('✅ Successfully created mock data');
        print('📊 Categories count: ${categories.length}');
        print('👥 Total people count: ${categories.fold(0, (sum, cat) => sum + cat.people.length)}');

        return categories;
      } catch (e, stackTrace) {
        print('❌ Error loading mock data: $e');
        print('Stack trace: $stackTrace');
        rethrow;
      }
    }
  }
}
