import '../repository/api/models/menu/menu_item_model.dart';

extension DishAssetMapperExtension on MenuItemModel {
  String getCategoryIcon() {
    if (_defaultDishCategoryIcons.keys.contains(dishType)) {
      return _buildAssetPath(_defaultDishCategoryIcons[dishType] ?? 'default');
    }

    if (labels.contains("FISH")) return _buildAssetPath('fish');
    if (labels.contains("VEGAN")) return _buildAssetPath('vegan');
    if (labels.contains("VEGETARIAN")) return _buildAssetPath('vegetarian');

    if (labels.contains("MEAT")) {
      const meatTypes = {
        "PORK": "pork",
        "POULTRY": "poultry",
        "BEEF": "beef",
        "LAMB": "lamb",
        "WILD MEAT": "wild",
        "VEAL": "veal",
      };

      final meatIcon = meatTypes.entries.firstWhere(
        (entry) => labels.contains(entry.key),
        orElse: () => const MapEntry("DEFAULT", "default"),
      );

      return _buildAssetPath(meatIcon.value);
    }

    return _buildAssetPath('default');
  }

  String _buildAssetPath(String iconName) {
    return 'feature_modules/mensa/assets/category_$iconName.png';
  }

  String getCategoryName() {
    if (_ignoredCategories.contains(dishType)) return "";

    if (labels.contains("MEAT")) return "🥩 Meat";
    if (labels.contains("FISH")) return "🐟 Fish";
    if (labels.contains("VEGETARIAN")) return "🥕 Vegetarian";
    if (labels.contains("VEGAN")) return "🌱 Vegan";
    else return "";
  }
}

final Map<String, String> _defaultDishCategoryIcons = {
  'Pizza': 'pizza',
  'Dessert (Glas)': 'dessert',
  'Studitopf': 'studitopf',
  'Süßspeise': 'sweets',
  'Tagessupe, Brot, Obst': 'soup',
  'Vegan': 'vegan',
  'Vegetarisch/fleischlos': 'vegetarian',
};

final List<String> _ignoredCategories = [
  'Pizza',
  'Dessert (Glas)',
  'Studitopf',
  'Süßspeise',
  'Tagessupe, Brot, Obst',
  'Vegan',
  'Vegetarisch/fleischlos',
];
