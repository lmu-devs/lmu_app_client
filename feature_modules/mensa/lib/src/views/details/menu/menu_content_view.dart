import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../repository/api/models/taste_profile/taste_profile_label_item.dart';

import '../../../pages/pages.dart';
import '../../../repository/api/models/menu/dish_category.dart';
import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../../services/taste_profile_service.dart';
import '../../../widgets/details/menu/menu_item_tile.dart';
import '../../../widgets/mensa_placeholder_tile.dart';

class MenuContentView extends StatelessWidget {
  const MenuContentView({
    Key? key,
    required this.mensaMenuModel,
  }) : super(key: key);

  final MenuDayModel mensaMenuModel;

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    final tasteProfileActiveNotifier = tasteProfileService.tasteProfileActiveNotifier;
    final excludedLabelItemNotifier = tasteProfileService.excludedLabelItemNotifier;

    final menuItems = mensaMenuModel.menuItems;

    if (menuItems.isEmpty) {
      return const Center(
        // TODO: Add localization
        child: Text("No menu items available"),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: ValueListenableBuilder(
        valueListenable: tasteProfileActiveNotifier,
        builder: (context, isActive, _) {
          return ValueListenableBuilder(
            valueListenable: excludedLabelItemNotifier,
            builder: (context, excludedLabelItems, _) {
              final excludedLabelItemsName =
                  isActive ? excludedLabelItems.map((labelItem) => labelItem.enumName).toSet() : <String>{};

              final filteredMenuitems = List.of(menuItems);
              filteredMenuitems.removeWhere(
                (itemModel) => itemModel.labels.toSet().intersection(excludedLabelItemsName).isNotEmpty,
              );

              final excludedMenuItems =
                  isActive ? menuItems.where((item) => !filteredMenuitems.contains(item)).toList() : <MenuItemModel>[];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: LmuSizes.mediumLarge),
                  MenuFilteredMenuSection(
                    filteredMenuitems: filteredMenuitems,
                  ),
                  MenuExcludedMenuSection(
                    excludedMenuItems: excludedMenuItems,
                    excludedLabelItems: excludedLabelItems,
                  ),
                  const SizedBox(height: LmuSizes.xxlarge),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class MenuExcludedMenuSection extends StatelessWidget {
  const MenuExcludedMenuSection({
    super.key,
    required this.excludedMenuItems,
    required this.excludedLabelItems,
  });

  final List<MenuItemModel> excludedMenuItems;
  final List<TasteProfileLabelItem> excludedLabelItems;

  @override
  Widget build(BuildContext context) {
    final favoriteDishIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;
    final selectedLanguage = Localizations.localeOf(context).languageCode.toUpperCase();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LmuTileHeadline.action(
          title: context.locals.canteen.notYourTaste,
          actionTitle: context.locals.canteen.myTaste,
          onActionTap: () {
            LmuBottomSheet.showExtended(
              context,
              content: const TasteProfilePage(),
            );
          },
        ),
        if (excludedMenuItems.isEmpty)
          MensaPlaceholderTile(
            content: [
              LmuText.body(
                "Activate your taste profile to filter dishes by preferences and allergies.",
                color: context.colors.neutralColors.textColors.mediumColors.base,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: excludedMenuItems.mapIndexed(
            (index, dishModel) {
              final isLastItem = index == excludedMenuItems.length - 1;

              final labelText = excludedLabelItems.where((e) => dishModel.labels.contains(e.enumName)).toList();

              return ValueListenableBuilder(
                valueListenable: favoriteDishIdsNotifier,
                builder: (context, favoriteDishIds, _) {
                  final isFavorite = favoriteDishIdsNotifier.value.contains(dishModel.id.toString());

                  return MenuItemTile(
                    menuItemModel: dishModel,
                    isFavorite: isFavorite,
                    hasDivider: !isLastItem,
                    excludedLabelItemsName: labelText.map((e) => e.text[selectedLanguage]!).toList(),
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
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class MenuFilteredMenuSection extends StatelessWidget {
  const MenuFilteredMenuSection({
    super.key,
    required this.filteredMenuitems,
  });

  final List<MenuItemModel> filteredMenuitems;

  @override
  Widget build(BuildContext context) {
    final favoriteDishIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;

    if (filteredMenuitems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.xxlarge),
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
                        final isFavorite = favoriteDishIds.contains(dishModel.id.toString());

                        return MenuItemTile(
                          menuItemModel: dishModel,
                          isFavorite: isFavorite,
                          hasDivider: !isLastItem,
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
