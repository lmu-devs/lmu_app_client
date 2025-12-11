enum Animal {
  aperolCat,
  spaceCapybara,
  smokingApe,
  spaceCat,
  duck,
  hedgehog,
  fireHorse,
  leopard,
  otter,
  platypus,
}

extension AnimalAssetExtension on Animal {
  String get asset => switch (this) {
        Animal.aperolCat => "assets/aperol_lukas.webp",
        Animal.spaceCapybara => "assets/capybara_paul.webp",
        Animal.smokingApe => "assets/ape_raffi.webp",
        Animal.spaceCat => "assets/cat_philipp.webp",
        Animal.duck => "assets/duck_ruben.webp",
        Animal.hedgehog => "assets/hedgehog_ralf.webp",
        Animal.fireHorse => "assets/horse_mehyar.webp",
        Animal.leopard => "assets/leopard_leonie.webp",
        Animal.otter => "assets/otter_leonie.webp",
        Animal.platypus => "assets/platypus_anton.webp",
      };
}
