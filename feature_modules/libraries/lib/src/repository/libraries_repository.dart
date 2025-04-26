import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class LibrariesRepository {
  Future<List<LibraryModel>?> getLibraries();

  Future<List<LibraryModel>?> getCachedLibraries();
}

class ConnectedLibrariesRepository implements LibrariesRepository {
  ConnectedLibrariesRepository({required this.librariesApiClient});

  final LibrariesApiClient librariesApiClient;

  static const String _librariesKey = 'libraries_cache_key';
  static const String _librariesCacheTimeStampKey = 'libraries_cache_time_stamp_key';

  @override
  Future<List<LibraryModel>?> getLibraries({String? id}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final libraries = await librariesApiClient.getLibraries(id: id);
      await prefs.setString(_librariesKey, jsonEncode(libraries.map((e) => e.toJson()).toList()));
      await prefs.setInt(_librariesCacheTimeStampKey, DateTime.now().millisecondsSinceEpoch);
      return libraries;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<LibraryModel>?> getCachedLibraries() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_librariesKey);
    final cachedTimeStamp = prefs.getInt(_librariesCacheTimeStampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(const Duration(days: 14)).isAfter(DateTime.now());
    if (cachedData != null && isCacheValid) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      return decodedData.map((e) => LibraryModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
