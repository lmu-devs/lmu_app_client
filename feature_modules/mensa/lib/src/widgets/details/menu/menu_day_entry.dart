import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import '../../../extensions/mensa_type_extension.dart';
import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/taste_profile_service.dart';
import '../../widgets.dart';

class MenuDayEntry extends StatelessWidget {
  const MenuDayEntry({
    super.key,
    required this.mensaMenuModel,
    required this.mensaType,
  });

  final MenuDayModel mensaMenuModel;
  final MensaType mensaType;

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    final tasteProfileActiveNotifier = tasteProfileService.isActiveNotifier;
    final excludedLabelItemNotifier = tasteProfileService.excludedLabelItemNotifier;

    final menuItems = mensaMenuModel.menuItems;

    if (menuItems.isEmpty) {
      final mensaLocals = context.locals.canteen;
      final allLocals = context.locals.app;

      if (mensaMenuModel.isClosed) {
        final mensaName = mensaType.text(mensaLocals);
        final germanArticle =
            [MensaType.mensa, MensaType.lounge].contains(mensaType) ? allLocals.diese : allLocals.dieses;
        return Padding(
          padding: const EdgeInsets.only(top: LmuSizes.size_24, bottom: LmuSizes.size_96),
          child: LmuEmptyState(
            type: EmptyStateType.closed,
            title: "$mensaName ${mensaLocals.closed.toLowerCase()}",
            description: mensaLocals.closedDescription(
              mensaName,
              germanArticle,
            ),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top: LmuSizes.size_24, bottom: LmuSizes.size_96),
        child: LmuEmptyState(
          type: EmptyStateType.generic,
          title: mensaLocals.menuNotAvailable,
          description: mensaLocals.menuNotAvailableDescription,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: ValueListenableBuilder(
        valueListenable: tasteProfileActiveNotifier,
        builder: (context, isActive, _) {
          return ValueListenableBuilder(
            valueListenable: excludedLabelItemNotifier,
            builder: (context, excludedLabelItems, _) {
              final excludedLabelItemsName =
                  isActive ? excludedLabelItems.map((labelItem) => labelItem.enumName).toSet() : <String>{};

              final filteredMenuItems = List.of(menuItems);
              filteredMenuItems.removeWhere(
                (itemModel) => itemModel.labels.toSet().intersection(excludedLabelItemsName).isNotEmpty,
              );

              final excludedMenuItems =
                  isActive ? menuItems.where((item) => !filteredMenuItems.contains(item)).toList() : <MenuItemModel>[];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: LmuSizes.size_24),
                  MenuFilteredSection(filteredMenuitems: filteredMenuItems),
                  MenuExcludedSection(
                    excludedMenuItems: excludedMenuItems,
                    excludedLabelItems: excludedLabelItems,
                    isActive: isActive,
                  ),
                  const SizedBox(height: LmuSizes.size_96),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
