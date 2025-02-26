import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'models/wishlist_model.dart';
import 'wishlist_api_endpoints.dart';

class WishlistApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<List<WishlistModel>> getWishlistModels({int? id}) async {
    final response = await _baseApiClient.get(WishlistApiEndpoints.getWishlistModels(id: id));

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => WishlistModel.fromJson(json as Map<String, dynamic>)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load wishlist data - ${response.statusCode}');
    }
  }

  Future<bool> toggleWishlistLike({required int id}) async {
    final response = await _baseApiClient.post(WishlistApiEndpoints.toggleWishlistLike(id));

    if (response.statusCode == 200) {
      return response.body == 'true';
    } else {
      throw Exception('Failed to toggle favorite wishlist entry - ${response.statusCode}');
    }
  }
}
