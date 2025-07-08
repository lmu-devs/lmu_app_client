import 'package:shared_api/settings.dart';

import '../usecase/safari_usecase.dart';

class SafariApiImpl implements SafariApi {
  SafariApiImpl(this._safariUsecase);
  final SafariUsecase _safariUsecase;

  @override
  void animalSeen(SafariAnimal animal) => _safariUsecase.animalSeen(animal);
}
