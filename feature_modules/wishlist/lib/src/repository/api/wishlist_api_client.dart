import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/wishlist_model.dart';
import 'wishlist_api_endpoints.dart';

class WishlistApiClient {
  Future<List<WishlistModel>> getWishlistModels() async {
    try {
      final response = await http.get(
        Uri.parse(WishlistApiEndpoints.getWishlistModels()),
      );

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => WishlistModel.fromJson(json as Map<String, dynamic>)).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load wishlist data');
      }
    } catch (e) {
      throw Exception('Failed to parse wishlist data: $e');
    }
  }
}
