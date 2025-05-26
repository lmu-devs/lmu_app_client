import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/benefits_dto.dart';

class BenefitsStorage {
  final _benefitsCacheKey = 'benefits_cache';
  final _benefitsCacheTimeKey = 'benefits_cache_time';
  final _benefitsCacheTime = const Duration(days: 14);

  Future<void> saveBenefits(BenefitsDto benefits) async {
    final prefs = await SharedPreferences.getInstance();
    final benefitsJson = jsonEncode(benefits.toJson());
    await prefs.setString(_benefitsCacheKey, benefitsJson);
    await prefs.setInt(_benefitsCacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<BenefitsDto?> getBenefits() async {
    final prefs = await SharedPreferences.getInstance();
    final benefitsJson = prefs.getString(_benefitsCacheKey);
    if (benefitsJson == null) return null;
    final cacheTime = prefs.getInt(_benefitsCacheTimeKey);
    final isCacheValid = cacheTime != null && _isCacheValid(cacheTime);
    if (!isCacheValid) {
      prefs.remove(_benefitsCacheKey);
      return null;
    }

    try {
      final benefitsMap = jsonDecode(benefitsJson) as Map<String, dynamic>;
      return BenefitsDto.fromJson(benefitsMap);
    } catch (_) {
      return null;
    }
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
