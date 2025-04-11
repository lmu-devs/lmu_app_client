import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class TimelineRepository {
  Future<TimelineData?> getTimeline();

  Future<TimelineData?> getCachedTimeline();
}

class ConnectedTimelineRepository implements TimelineRepository {
  final _apiClient = GetIt.I.get<TimelineApiClient>();

  final _timelineCacheKey = 'timeline_cache_key';
  final _timelineCacheTimeStampKey = 'timeline_cache_timestamp_key';
  final _cacheDuration = const Duration(days: 7);

  @override
  Future<TimelineData?> getTimeline() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final data = await _apiClient.getTimeline();
      await prefs.setString(_timelineCacheKey, jsonEncode(data.toJson()));
      await prefs.setInt(_timelineCacheTimeStampKey, DateTime.now().millisecondsSinceEpoch);
      return data;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TimelineData?> getCachedTimeline() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_timelineCacheKey);
    final cachedTimeStamp = prefs.getInt(_timelineCacheTimeStampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(_cacheDuration).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      try {
        return TimelineData.fromJson(jsonDecode(cachedData));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
