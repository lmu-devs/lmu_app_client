import 'package:shared_api/settings.dart';

class LmuAnimalAssets {
  static const String lion = 'lib/assets/animals/lion.webp';

  static const String capybara = 'lib/assets/animals/capybara.webp';

  static const String mole = 'lib/assets/animals/mole.webp';

  static const String blobfish = 'lib/assets/animals/blobfish.webp';

  static const String sloth = 'lib/assets/animals/sloth.webp';

  static const String kiwi = 'lib/assets/animals/kiwi.webp';

  static const String caterpillar = 'lib/assets/animals/caterpillar.webp';
}

extension AssetToAnimalMapper on String {
  SafariAnimal toSafariAnimal() {
    return switch (this) {
      LmuAnimalAssets.capybara => SafariAnimal.capybara,
      LmuAnimalAssets.mole => SafariAnimal.mole,
      LmuAnimalAssets.blobfish => SafariAnimal.blobfish,
      LmuAnimalAssets.sloth => SafariAnimal.sloth,
      LmuAnimalAssets.kiwi => SafariAnimal.kiwi,
      LmuAnimalAssets.caterpillar => SafariAnimal.caterpillar,
      String() => throw UnimplementedError(),
    };
  }
}

extension SafariAnimalToAssetMapper on SafariAnimal {
  String toAsset() {
    return switch (this) {
      SafariAnimal.capybara => LmuAnimalAssets.capybara,
      SafariAnimal.mole => LmuAnimalAssets.mole,
      SafariAnimal.blobfish => LmuAnimalAssets.blobfish,
      SafariAnimal.sloth => LmuAnimalAssets.sloth,
      SafariAnimal.kiwi => LmuAnimalAssets.kiwi,
      SafariAnimal.caterpillar => LmuAnimalAssets.caterpillar,
    };
  }
}
