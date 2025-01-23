import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../pages/dish_details_page.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/mensa_user_preferences_service.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    super.key,
    required this.menuItemModel,
    required this.isFavorite,
    this.hasDivider = false,
    this.excludedLabelItemsName,
  });

  final MenuItemModel menuItemModel;
  final bool hasDivider;
  final bool isFavorite;
  final List<String>? excludedLabelItemsName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.size_12 : LmuSizes.none),
      child: GestureDetector(
        onTap: () {
          LmuBottomSheet.showExtended(
            context,
            content: DishDetailsPage(menuItemModel: menuItemModel),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuSizes.size_12),
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(LmuSizes.size_16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            getAssetPathForDishType(menuItemModel.dishType),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: LmuSizes.size_12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: LmuText.body(
                                  menuItemModel.title,
                                ),
                              ),
                            ],
                          ),
                          if (excludedLabelItemsName != null && excludedLabelItemsName!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: LmuSizes.size_8),
                              child: Wrap(
                                spacing: LmuSizes.size_4,
                                runSpacing: LmuSizes.size_4,
                                children: excludedLabelItemsName!.mapIndexed(
                                  (index, name) {
                                    return LmuInTextVisual.text(
                                      title: name,
                                      destructive: true,
                                    );
                                  },
                                ).toList(),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(width: LmuSizes.size_12),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _toggleDishFavorite(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LmuText.bodyXSmall(
                                  menuItemModel.ratingModel.calculateLikeCount(isFavorite),
                                  color: context.colors.neutralColors.textColors.weakColors.base,
                                ),
                                const SizedBox(width: LmuSizes.size_4),
                                StarIcon(isActive: isFavorite),
                              ],
                            ),
                          ),
                          const SizedBox(height: LmuSizes.size_4),
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: LmuSizes.size_20),
                            child: Center(
                              child: LmuText.bodyXSmall(
                                menuItemModel.priceSimple,
                                color: context.colors.neutralColors.textColors.weakColors.base,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getAssetPathForDishType(String dishType) {
    switch (dishType) {
      case 'Pizza':
        return 'feature_modules/mensa/assets/category_pizza.png';
      case 'Pasta':
        return 'feature_modules/mensa/assets/category_pasta.png';
      case 'Wok':
        return 'feature_modules/mensa/assets/category_wok.png';
      case 'Dessert (Glas)':
        return 'feature_modules/mensa/assets/category_dessert.png';
      case 'Tagessupe, Brot, Obst':
        return 'feature_modules/mensa/assets/category_soup.png';
      case 'Fleisch':
        return 'feature_modules/mensa/assets/category_meat.png';
      case 'Fisch':
        return 'feature_modules/mensa/assets/category_fish.png';
      case 'Vegan':
        return 'feature_modules/mensa/assets/category_vegan.png';
      case 'Süßspeise':
        return 'feature_modules/mensa/assets/category_sweets.png';
      case 'Vegetarisch/fleischlos':
        return 'feature_modules/mensa/assets/category_vegetarian.png';
      case 'Studitopf':
        return 'feature_modules/mensa/assets/category_studitopf.png';
      case 'Grill':
        return 'feature_modules/mensa/assets/category_bbq.png';
      default:
        return 'feature_modules/mensa/assets/category_default.png';
    }
  }

  void _toggleDishFavorite(BuildContext context) {
    final localizations = context.locals.app;
    final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
    final id = menuItemModel.id;

    LmuVibrations.secondary();

    if (isFavorite) {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteRemoved,
        actionText: localizations.undo,
        onActionPressed: () {
          userPreferencesService.toggleFavoriteDishId(id.toString());
        },
      );
    } else {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteAdded,
      );
    }

    userPreferencesService.toggleFavoriteDishId(id.toString());
  }
}
