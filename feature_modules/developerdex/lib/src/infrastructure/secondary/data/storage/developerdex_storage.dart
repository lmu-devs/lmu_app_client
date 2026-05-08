import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DeveloperdexStorage {
  final _developerdexKey = 'developerdex_data_key';

  Future<void> saveSeenEntries(List<String> developerdexIds) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(developerdexIds);
    await prefs.setString(_developerdexKey, jsonString);
  }

  Future<List<String>?> getSeenEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_developerdexKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<String>();
    }
    return null;
  }

  Future<void> deleteSeenEntries() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_developerdexKey);
  }
}
