import 'package:shared_preferences/shared_preferences.dart';

class SafariStorage {
  final _safariAnimalKey = 'safari_animal_seen';
  Future<void> saveAnimalsSeen(List<String> animalIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_safariAnimalKey, animalIds);
  }

  Future<List<String>> getAnimalsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_safariAnimalKey) ?? [];
  }
}
