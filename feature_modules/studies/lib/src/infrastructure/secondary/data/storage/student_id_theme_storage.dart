import 'package:shared_preferences/shared_preferences.dart';

class StudentIdThemeStorage {
  static const _selectedThemeKey = 'student_id_selected_theme';

  Future<String?> getSelectedThemeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedThemeKey);
  }

  Future<void> saveSelectedThemeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedThemeKey, id);
  }
}
