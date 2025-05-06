import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/benefit_category_dto.dart';

class BenefitsStorage {
  final _benefitsCacheKey = 'benefits_cache';
  final _benefitsCacheTimeKey = 'benefits_cache_time';
  final _benefitsCacheTime = const Duration(days: 7);

  Future<void> saveBenefits(List<BenefitCategoryDto> benefits) async {
    final prefs = await SharedPreferences.getInstance();
    final benefitsJson = jsonEncode(benefits.map((e) => e.toJson()).toList());
    await prefs.setString(_benefitsCacheKey, benefitsJson);
    await prefs.setInt(_benefitsCacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<BenefitCategoryDto>?> getBenefits() async {
    final prefs = await SharedPreferences.getInstance();
    final benefitsJson = prefs.getString(_benefitsCacheKey);
    if (benefitsJson == null) return null;
    final cacheTime = prefs.getInt(_benefitsCacheTimeKey);
    final isCacheValid = cacheTime != null && _isCacheValid(cacheTime);
    if (!isCacheValid) {
      prefs.remove(_benefitsCacheKey);
      return null;
    }

    final List<dynamic> decodedList = jsonDecode(benefitsJson);
    return decodedList.map((e) => BenefitCategoryDto.fromJson(e)).toList();
  }

  Future<void> deleteBenefits() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_benefitsCacheKey);
  }

  bool _isCacheValid(int? cacheTime) {
    if (cacheTime == null) return false;
    final cacheDate = DateTime.fromMillisecondsSinceEpoch(cacheTime);
    return cacheDate.add(_benefitsCacheTime).isAfter(DateTime.now());
  }
}
