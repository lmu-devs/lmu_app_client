import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/home_model.dart';

class HomeApiClient {
  Future<HomeModel> getHomeData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8001/v1/home/'));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return HomeModel.fromJson(json);
      } else {
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      rethrow;
    }
  }
}