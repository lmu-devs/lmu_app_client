import 'package:core/logging.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/settings.dart';

import '../repository/safari_repository.dart';

class SafariUsecase extends ChangeNotifier {
  SafariUsecase(this._safariRepository);

  final SafariRepository _safariRepository;
  List<SafariAnimal> _animalsSeen = [];

  List<SafariAnimal> get animalsSeen => _animalsSeen;

  Future<void> loadAnimalsSeen() async {
    _animalsSeen = await _safariRepository.getAnimalsSeen();
    notifyListeners();
  }

  void animalSeen(SafariAnimal animal) {
    final alreadySeen = _animalsSeen.contains(animal);
    if (alreadySeen) return;

    AppLogger().logMessage("[SafariUsecase]: Animal seen: ${animal.name}");

    _animalsSeen.add(animal);
    _safariRepository.saveAnimalsSeen(_animalsSeen);

    notifyListeners();
  }

  void reset() {
    AppLogger().logMessage("[SafariUsecase]: Resetting safari animals seen");
    _animalsSeen.clear();
    _safariRepository.saveAnimalsSeen(_animalsSeen);
    notifyListeners();
  }
}
