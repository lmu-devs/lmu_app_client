import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import '../../../extensions/mensa_type_extension.dart';
import '../../../repository/api/models/menu/menu_day_model.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/taste_profile_service.dart';
import '../../widgets.dart';

class MenuContentView extends StatelessWidget {
  const MenuContentView({
    Key? key,
    required this.mensaMenuModel,
    required this.mensaType,
  }) : super(key: key);

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

      if (mensaMenuModel.isClosed) {
        return LmuIssueType(
          title: "${mensaType.text(mensaLocals)} ${mensaLocals.closed.toLowerCase()}",
          icon: LucideIcons.circle_x,
        );
      }
      return LmuIssueType(title: mensaLocals.menuNotAvailable, icon: LucideIcons.ban);
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
