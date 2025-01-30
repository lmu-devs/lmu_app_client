import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/menu/menu_item_model.dart';
import '../repository/api/models/menu/price_category.dart';
import '../repository/api/models/menu/price_model.dart';
import '../repository/api/models/taste_profile/taste_profile_label_item.dart';
import '../services/mensa_user_preferences_service.dart';
import '../services/taste_profile_service.dart';

class DishDetailsPage extends StatelessWidget {
  const DishDetailsPage({
    super.key,
    required this.menuItemModel,
  });

  final MenuItemModel menuItemModel;

  MenuItemModel get _menuItemModel => menuItemModel;

  List<PriceModel> get _prices => _menuItemModel.prices;

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I<TasteProfileService>();
    final userPreferenceService = GetIt.I<MensaUserPreferencesService>();

    final labelItems = _menuItemModel.labels
        .map((e) => tasteProfileService.getLabelItemFromId(e))
        .where((element) => element != null)
        .cast<TasteProfileLabelItem>()
        .toList()
        .sortedBy((element) => element.enumName);

    return LmuMasterAppBar.bottomSheet(
      largeTitle: _menuItemModel.title,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_16),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: userPreferenceService.favoriteDishIdsNotifier,
                    builder: (context, favoriteDishIds, _) {
                      final isFavorite = favoriteDishIds.contains(_menuItemModel.id);
                      return LmuButton(
                        leadingWidget: StarIcon(
                          isActive: isFavorite,
                          disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                        ),
                        title:
                            "${_menuItemModel.ratingModel.calculateLikeCount(isFavorite)} ${context.locals.app.likes}",
                        emphasis: ButtonEmphasis.secondary,
                        onTap: () => userPreferenceService.toggleFavoriteDishId(_menuItemModel.id),
                      );
                    },
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  // const LmuButton(
                  //   title: "Erinnere mich",
                  //   trailingIcon: LucideIcons.bell,
                  //   emphasis: ButtonEmphasis.secondary,
                  // ),
                  // const SizedBox(width: LmuSizes.size_8),
                  // const LmuButton(
                  //   title: "Teilen",
                  //   emphasis: ButtonEmphasis.secondary,
                  // ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_32),
              if (labelItems.isNotEmpty)
                Column(
                  children: [
                    LmuTileHeadline.base(title: context.locals.canteen.ingredients),
                    LmuContentTile(
                      content: labelItems.map(
                        (labelItem) {
                          return LmuListItem.base(
                            leadingArea: LmuText.h1(
                                labelItem.emojiAbbreviation?.isEmpty ?? false ? "🫙" : labelItem.emojiAbbreviation),
                            title: labelItem.text,
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: LmuSizes.size_32),
                  ],
                ),
              LmuTileHeadline.base(title: context.locals.canteen.prices),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: context.locals.canteen.simplePrice,
                    trailingTitle: _menuItemModel.priceSimple,
                  ),
                  if (_prices.first.basePrice > 0.0)
                    LmuListItem.base(
                      title: context.locals.canteen.basePrice,
                      trailingTitle: '${_prices.first.basePrice.toStringAsFixed(2)} €',
                    ),
                  ..._prices.map(
                    (e) {
                      return LmuListItem.base(
                        title: e.category.name(context.locals.canteen),
                        trailingTitle: context.locals.canteen.pricePerUnit(
                          e.pricePerUnit.toStringAsFixed(2),
                          e.unit,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}

extension PriceCategoryName on PriceCategory {
  String name(CanteenLocalizations localizations) {
    switch (this) {
      case PriceCategory.students:
        return localizations.students;
      case PriceCategory.staff:
        return localizations.staff;
      case PriceCategory.guests:
        return localizations.guests;
    }
  }
}

extension PriceFormatter on PriceModel {
  String priceString(CanteenLocalizations localizations) => localizations.pricePerUnit(
        pricePerUnit.toStringAsFixed(2),
        unit,
      );
}

extension PriceCategoryVisualizerExtension on PriceCategory {
  Color textColor(LmuColors colors, {required bool isActive}) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}
