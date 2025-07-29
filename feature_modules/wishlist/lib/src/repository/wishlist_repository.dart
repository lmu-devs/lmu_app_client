import 'dart:convert';
import 'dart:io';

import 'package:core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/models/wishlist_model.dart';
import 'api/wishlist_api_client.dart';
import 'error/wishlist_generic_exception.dart';

abstract class WishlistRepository {
  Future<List<WishlistModel>> getWishlistEntries();

  Future<List<WishlistModel>?> getCachedWishlistEntries({String? id});

  Future<List<String>?> getLikedWishlistIds();

  Future<bool> toggleWishlistLike(String id);

  Future<void> saveLikedWishlistIds(List<String> ids);

  Future<void> deleteAllLocalData();
}

class ConnectedWishlistRepository implements WishlistRepository {
  ConnectedWishlistRepository({
    required this.wishlistApiClient,
  });

  final WishlistApiClient wishlistApiClient;

  final String _cachedWishlistEntriesKey = 'cached_wishlist_entries_key';
  final _cachedWihshlistEntriesTimestampKey = 'cached_wishlist_entries_timestamp_key';

  final _maxCacheTime = const Duration(days: 7);

  static const String _likedWishlistIdsKey = 'liked_wishlist_ids_key';

  @override
  Future<List<WishlistModel>> getWishlistEntries() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final wishlistEntries = await wishlistApiClient.getWishlistModels(id: null);
      await prefs.setString(_cachedWishlistEntriesKey, jsonEncode(wishlistEntries.map((e) => e.toJson()).toList()));
      await prefs.setInt(_cachedWihshlistEntriesTimestampKey, DateTime.now().millisecondsSinceEpoch);
      return wishlistEntries;
    } catch (e) {
      if (e is SocketException) {
        throw NoNetworkException();
      } else {
        throw WishlistGenericException();
      }
    }
  }

  @override
  Future<List<WishlistModel>?> getCachedWishlistEntries({String? id}) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cachedWishlistEntriesKey);
    final cachedTimeStamp = prefs.getInt(_cachedWihshlistEntriesTimestampKey);
    final isCacheValid = cachedTimeStamp != null &&
        DateTime.fromMillisecondsSinceEpoch(cachedTimeStamp).add(_maxCacheTime).isAfter(DateTime.now());

    if (cachedData != null && isCacheValid) {
      try {
        final List<dynamic> jsonList = jsonDecode(cachedData);
        return jsonList.map((e) => WishlistModel.fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        prefs.remove(_cachedWishlistEntriesKey);
        return null;
      }
    }
    return null;
  }

  @override
  Future<List<String>?> getLikedWishlistIds() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteWishlistIds = prefs.getStringList(_likedWishlistIdsKey);
    return favoriteWishlistIds;
  }

  @override
  Future<bool> toggleWishlistLike(String id) async {
    return await wishlistApiClient.toggleWishlistLike(id: id);
  }

  @override
  Future<void> saveLikedWishlistIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_likedWishlistIdsKey, ids);
  }

  @override
  Future<void> deleteAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_likedWishlistIdsKey);
  }
}
