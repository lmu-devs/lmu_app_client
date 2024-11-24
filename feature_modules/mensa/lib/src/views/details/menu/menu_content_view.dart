import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../pages/pages.dart';
import '../../../repository/api/models/menu/dish_category.dart';
import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../../services/taste_profile_service.dart';
import '../../../widgets/details/menu/menu_item_tile.dart';

class MenuContentView extends StatelessWidget {
  const MenuContentView({
    Key? key,
    required this.mensaMenuModel,
  }) : super(key: key);

  final MenuDayModel mensaMenuModel;

  @override
  Widget build(BuildContext context) {
    final favoriteDishIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;

    final menuItems = mensaMenuModel.menuItems;

    if (menuItems.isEmpty) {
      return const Center(
        child: Text("No menu items available"),
      );
    }

    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    final excludedLabelItems = tasteProfileService.excludedLabelItems;
    final excludedLabelItemsName = excludedLabelItems.map((e) => e.enumName).toList();

    final filteredMenuItems = menuItems.where((element) {
      final intersection = element.labels.toSet().intersection(excludedLabelItemsName.toSet());
      return intersection.isEmpty;
    }).toList();

    print("Filtered: $filteredMenuItems");

    final exlcudedMenuItems = List.of(menuItems);

    exlcudedMenuItems.removeWhere((element) => filteredMenuItems.contains(element));

    print("Excluded: $exlcudedMenuItems");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: LmuSizes.mediumLarge),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: DishCategory.values.length,
              itemBuilder: (context, index) {
                final dishCategory = DishCategory.values[index];
                final menuItemsForCategory = filteredMenuItems.where((e) => e.dishCategory == dishCategory).toList();
                if (menuItemsForCategory.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    LmuTileHeadline.base(title: dishCategory.name(context.locals.canteen)),
                    Column(
                      children: menuItemsForCategory.mapIndexed(
                        (index, dishModel) {
                          final isLastItem = index == menuItemsForCategory.length - 1;
                          return ValueListenableBuilder(
                            valueListenable: favoriteDishIdsNotifier,
                            builder: (context, favoriteDishIds, _) {
                              final isFavorite = favoriteDishIdsNotifier.value.contains(dishModel.id.toString());

                              return MenuItemTile(
                                menuItemModel: dishModel,
                                isFavorite: isFavorite,
                                hasDivider: isLastItem,
                                onTap: () {
                                  final initialPriceCategory =
                                      GetIt.I.get<MensaUserPreferencesService>().initialPriceCategory;
                                  LmuBottomSheet.showExtended(
                                    context,
                                    content: MenuDetailsPage(
                                      menuItemModel: dishModel,
                                      initialPriceCategory: initialPriceCategory,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: LmuSizes.xxlarge),
                  ],
                );
              },
            ),
          ),
          if (exlcudedMenuItems.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LmuTileHeadline.action(
                  title: context.locals.app.appTitle,
                  actionTitle: context.locals.canteen.myTaste,
                  onActionTap: () async {
                    final tasteProfileService = GetIt.I.get<TasteProfileService>();
                    final saveModel = await tasteProfileService.loadTasteProfileState();
                    if (context.mounted) {
                      LmuBottomSheet.showExtended(
                        context,
                        content: TasteProfilePage(
                          selectedPresets: saveModel.selectedPresets,
                          excludedLabels: saveModel.excludedLabels,
                          isActive: saveModel.isActive,
                        ),
                      );
                    }
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: exlcudedMenuItems.mapIndexed(
                    (index, dishModel) {
                      final isLastItem = index == exlcudedMenuItems.length - 1;

                      final labelsEnumName =
                          excludedLabelItems.where((element) => dishModel.labels.contains(element.enumName)).toList();

                      return MenuItemTile(
                        menuItemModel: dishModel,
                        isFavorite: false,
                        hasDivider: isLastItem,
                        excludedLabelItemsName: labelsEnumName.map((e) => e.enumName!).toList(),
                        onTap: () {
                          final initialPriceCategory = GetIt.I.get<MensaUserPreferencesService>().initialPriceCategory;
                          LmuBottomSheet.showExtended(
                            context,
                            content: MenuDetailsPage(
                              menuItemModel: dishModel,
                              initialPriceCategory: initialPriceCategory,
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: LmuSizes.xxlarge),
              ],
            ),
        ],
      ),
    );
  }
}

extension MenuCategoryName on DishCategory {
  String name(CanteenLocalizations localizations) {
    switch (this) {
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
