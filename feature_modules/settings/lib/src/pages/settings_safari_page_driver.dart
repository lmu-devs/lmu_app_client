import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';
import 'package:widget_driver/widget_driver.dart';

import '../usecase/safari_usecase.dart';

part 'settings_safari_page_driver.g.dart';

@GenerateTestDriver()
class SettingsSafariPageDriver extends WidgetDriver {
  final _safariUsecase = GetIt.I.get<SafariUsecase>();

  List<SafariAnimal> _seenAnimals = [];

  String get safariTitle => "LMU Safari";

  int get stampCount => SafariAnimal.values.length;

  bool isAnimalSeen(SafariAnimal animal) => _seenAnimals.contains(animal);

  void restartSafari() => _safariUsecase.reset();

  void _onAnimalSeenChange() {
    _seenAnimals = _safariUsecase.animalsSeen;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();

    _seenAnimals = _safariUsecase.animalsSeen;
    _safariUsecase.addListener(_onAnimalSeenChange);
  }
}
