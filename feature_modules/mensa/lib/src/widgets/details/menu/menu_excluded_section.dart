import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../pages/taste_profile_page.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../repository/api/models/taste_profile/taste_profile_label_item.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../common/mensa_placeholder_tile.dart';
import 'menu_item_tile.dart';

class MenuExcludedSection extends StatelessWidget {
  const MenuExcludedSection({
    super.key,
    required this.excludedMenuItems,
    required this.excludedLabelItems,
    required this.isActive,
  });

  final List<MenuItemModel> excludedMenuItems;
  final List<TasteProfileLabelItem> excludedLabelItems;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final favoriteDishIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;
    final canteenLocalizations = context.locals.canteen;
    return Column(
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
                isActive
                    ? canteenLocalizations.tasteProfilePlaceholderActive
                    : canteenLocalizations.tasteProfilePlaceholderNotActive,
                color: context.colors.neutralColors.textColors.mediumColors.base,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        Column(
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
                    excludedLabelItemsName: labelText.map((e) => e.text).toList(),
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
