enum Animal { aperolCat, spaceCapybara, smokingApe }

extension AnimalAssetExtension on Animal {
  String get asset => switch (this) {
        Animal.aperolCat => "assets/aperol_lukas.webp",
        Animal.spaceCapybara => "assets/capybara_paul.webp",
        Animal.smokingApe => "assets/ape_raffi.webp",
      };
}
