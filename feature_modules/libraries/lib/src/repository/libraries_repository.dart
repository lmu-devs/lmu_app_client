import 'dart:convert';
import 'dart:io';

import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'api/enums/sort_options.dart';
import 'error/libraries_generic_exception.dart';

abstract class LibrariesRepository {
  Future<List<LibraryModel>> getLibraries();

  Future<List<LibraryModel>?> getCachedLibraries();

  Future<bool> toggleFavoriteLibraryId(String id);

  Future<List<String>?> getFavoriteLibraryIds();

  Future<void> saveFavoriteLibraryIds(List<String> favoriteIds);

  Future<SortOption?> getSortOption();

  Future<void> setSortOption(SortOption sortOption);

  Future<void> deleteAllLocalData();

  Future<void> deleteAllLocalizedData();

  Future<void> saveRecentSearches(List<String> values);

  Future<List<String>> getRecentSearches();
}

class ConnectedLibrariesRepository implements LibrariesRepository {
  ConnectedLibrariesRepository({required this.librariesApiClient});

  final LibrariesApiClient librariesApiClient;
  final _appLogger = AppLogger();

  static const String _librariesKey = 'libraries_cache_key';
  static const String _librariesCacheTimeStampKey = 'libraries_cache_time_stamp_key';

  static const String _favoriteLibraryIdsKey = 'favorite_library_ids_key';

  static const String _librariesSortOptionKey = 'libraries_sort_option';

  static const String _recentSearchesKey = 'libraries_recentSearches';

  @override
  Future<List<LibraryModel>> getLibraries({String? id}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final libraries = await librariesApiClient.getLibraries(id: id);
      await prefs.setString(_librariesKey, jsonEncode(libraries.map((e) => e.toJson()).toList()));
      await prefs.setInt(_librariesCacheTimeStampKey, DateTime.now().millisecondsSinceEpoch);
      return libraries;
    } catch (e) {
      if (e is SocketException) {
        throw NoNetworkException();
      } else {
        _appLogger.logError('[LibrariesRepository]: Error fetching libraries: $e');
        throw LibrariesGenericException();
      }
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

  @override
  Future<List<String>?> getFavoriteLibraryIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteLibraryIds = prefs.getStringList(_favoriteLibraryIdsKey);
    return favoriteLibraryIds;
  }

  @override
  Future<bool> toggleFavoriteLibraryId(String id) async {
    return await librariesApiClient.toggleFavoriteLibraryId(id);
  }

  @override
  Future<void> saveFavoriteLibraryIds(List<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_favoriteLibraryIdsKey, favoriteIds);
    _appLogger.logMessage('[LibrariesRepository]: Saved local favorite library ids: $favoriteIds');
  }

  @override
  Future<SortOption?> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedSortOption = prefs.getString(_librariesSortOptionKey);

    if (cachedSortOption == null) {
      return null;
    }

    for (var element in SortOption.values) {
      if (element.name == cachedSortOption) {
        return element;
      }
    }
    return null;
  }

  @override
  Future<void> setSortOption(SortOption sortOption) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_librariesSortOptionKey, sortOption.name);
    _appLogger.logMessage('[LibrariesRepository]: Saved sort option: $sortOption');
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_librariesKey);
    await prefs.remove(_librariesCacheTimeStampKey);
    await prefs.remove(_favoriteLibraryIdsKey);
    await prefs.remove(_librariesSortOptionKey);
    await prefs.remove(_recentSearchesKey);

    _appLogger.logMessage('[LibrariesRepository]: Deleted all local data');
  }

  @override
  Future<void> deleteAllLocalizedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_librariesKey);

    _appLogger.logMessage('[LibrariesRepository]: Deleted all localized data');
  }

  @override
  Future<void> saveRecentSearches(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentSearchesKey, values);
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    return recentSearches;
  }
}
