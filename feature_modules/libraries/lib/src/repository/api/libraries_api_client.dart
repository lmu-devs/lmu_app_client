import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';
import 'libraries_api_endpoints.dart';

class LibrariesApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<List<LibraryModel>> getLibraries({String? id}) async {
    final response = await _baseApiClient.get(LibrariesApiEndpoints.getLibraries(id: id));

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => LibraryModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load library data - ${response.statusCode}');
    }
  }

  Future<bool> toggleFavoriteLibraryId(String id) async {
    final response = await _baseApiClient.post(LibrariesApiEndpoints.toggleFavoriteLibraryId(id));

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle favorite library - ${response.statusCode}');
    }

    return response.body == 'true';
  }
}
