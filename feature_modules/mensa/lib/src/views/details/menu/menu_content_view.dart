import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../services/mensa_user_preferences_service.dart';
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

    return ValueListenableBuilder(
      valueListenable: favoriteDishIdsNotifier,
      builder: (context, favoriteDishIds, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(LmuSizes.mediumLarge),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final isFavorite = favoriteDishIds.contains(
              menuItems[index].id.toString(),
            );
            final dishModel = menuItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
              child: MenuItemTile(
                menuItemModel: dishModel,
                onTap: () {
                  print("Du geiler Hund");
                },
                isFavorite: isFavorite,
                onFavoriteTap: () {},
              ),
            );
          },
        );
      },
    );
  }
}
