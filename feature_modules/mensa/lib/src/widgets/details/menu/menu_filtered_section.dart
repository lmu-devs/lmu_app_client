import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/api/models/menu/dish_category.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../common/mensa_placeholder_tile.dart';
import 'menu_item_tile.dart';

class MenuFilteredSection extends StatelessWidget {
  const MenuFilteredSection({
    super.key,
    required this.filteredMenuitems,
  });

  final List<MenuItemModel> filteredMenuitems;

  @override
  Widget build(BuildContext context) {
    final favoriteDishIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;

    if (filteredMenuitems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.size_32),
        child: MensaPlaceholderTile(
          content: [
            LmuText.body(
              "Deine Food-Preferences sind literally so main character energy rn...",
              color: context.colors.neutralColors.textColors.mediumColors.base,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: DishCategory.values.length,
        itemBuilder: (context, index) {
          final dishCategory = DishCategory.values[index];
          final menuItemsForCategory = filteredMenuitems.where((e) => e.dishCategory == dishCategory).toList();

          menuItemsForCategory.sort((a, b) {
            // 1. Liked elements first
            if (a.ratingModel.isLiked && !b.ratingModel.isLiked) return -1;
            if (!a.ratingModel.isLiked && b.ratingModel.isLiked) return 1;

            // 2. Sort by like count (descending)
            final likeCountComparison = b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount);
            if (likeCountComparison != 0) return likeCountComparison;

            // 3. Sort alphabetically by title
            return a.title.compareTo(b.title);
          });

          if (menuItemsForCategory.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              LmuTileHeadline.base(title: _getCategoryName(dishCategory, context.locals.canteen)),
              Column(
                children: menuItemsForCategory.mapIndexed(
                  (index, dishModel) {
                    final isLastItem = index == menuItemsForCategory.length - 1;
                    return ValueListenableBuilder(
                      valueListenable: favoriteDishIdsNotifier,
                      builder: (context, favoriteDishIds, _) {
                        final isFavorite = favoriteDishIds.contains(dishModel.id.toString());

                        return MenuItemTile(
                          menuItemModel: dishModel,
                          isFavorite: isFavorite,
                          hasDivider: !isLastItem,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: LmuSizes.size_32),
            ],
          );
        },
      ),
    );
  }

  String _getCategoryName(DishCategory category, CanteenLocalizations localizations) {
    switch (category) {
      case DishCategory.main:
        return localizations.mainDish;

      case DishCategory.sides:
        return localizations.sideDish;

      case DishCategory.soup:
        return localizations.soupDish;

      case DishCategory.dessert:
        return localizations.dessertDish;
    }
  }
}
