import 'package:shared_api/settings.dart';

import 'storage/safari_storage.dart';

class SafariRepository {
  const SafariRepository(this._safariStorage);

  final SafariStorage _safariStorage;

  Future<void> saveAnimalsSeen(List<SafariAnimal> animalIds) async {
    await _safariStorage.saveAnimalsSeen(animalIds.map((e) => e.name).toList());
  }

  Future<List<SafariAnimal>> getAnimalsSeen() async {
    final animalsSeenIds = await _safariStorage.getAnimalsSeen();
    return animalsSeenIds.map((id) => SafariAnimal.values.byName(id)).toList();
  }
}
