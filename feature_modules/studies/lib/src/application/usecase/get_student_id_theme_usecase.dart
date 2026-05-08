import 'package:flutter/foundation.dart';

import '../../infrastructure/secondary/data/storage/student_id_theme_storage.dart';

class GetStudentIdThemeUsecase extends ChangeNotifier {
  GetStudentIdThemeUsecase(this._storage);

  final StudentIdThemeStorage _storage;

  String _selectedThemeId = 'forest';

  String get selectedThemeId => _selectedThemeId;

  Future<void> init() async {
    final savedId = await _storage.getSelectedThemeId();
    if (savedId != null) {
      _selectedThemeId = savedId;
    }
    notifyListeners();
  }

  Future<void> selectTheme(String themeId) async {
    _selectedThemeId = themeId;
    notifyListeners();
    await _storage.saveSelectedThemeId(themeId);
  }
}
