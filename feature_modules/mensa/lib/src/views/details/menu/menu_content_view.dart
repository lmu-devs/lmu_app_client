import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/taste_profile_service.dart';
import '../../../widgets/widgets.dart';

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
                  const SizedBox(height: LmuSizes.xlarge),
                  MenuFilteredSection(filteredMenuitems: filteredMenuitems),
                  MenuExcludedSection(
                    excludedMenuItems: excludedMenuItems,
                    excludedLabelItems: excludedLabelItems,
                    isActive: isActive,
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
