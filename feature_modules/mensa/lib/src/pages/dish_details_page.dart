import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
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

  List<PriceModel> get _prices => menuItemModel.prices.sorted((a, b) => a.category.index.compareTo(b.category.index));

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I<TasteProfileService>();
    final userPreferenceService = GetIt.I<MensaUserPreferencesService>();

    final labelItems = menuItemModel.labels
        .map((e) => tasteProfileService.getLabelItemFromId(e))
        .where((element) => element != null)
        .cast<TasteProfileLabelItem>()
        .toList()
        .sortedBy((element) => element.enumName);

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: menuItemModel.title,
        leadingAction: LeadingAction.close,
      ),
      isBottomSheet: true,
      customScrollController: context.modalScrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const SizedBox(height: LmuSizes.size_16),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: userPreferenceService.favoriteDishIdsNotifier,
                      builder: (context, favoriteDishIds, _) {
                        final isFavorite = favoriteDishIds.contains(menuItemModel.id);
                        return LmuButton(
                          leadingWidget: StarIcon(
                            isActive: isFavorite,
                            disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                          ),
                          title:
                              "${menuItemModel.ratingModel.calculateLikeCount(isFavorite)} ${context.locals.app.likes}",
                          emphasis: ButtonEmphasis.secondary,
                          onTap: () => userPreferenceService.toggleFavoriteDishId(menuItemModel.id),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: LmuSizes.size_32),
                if (labelItems.isNotEmpty)
                  Column(
                    children: [
                      LmuTileHeadline.base(title: context.locals.canteen.ingredients),
                      LmuContentTile(
                        contentList: labelItems.map(
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
                  contentList: [
                    LmuListItem.base(
                      subtitle: context.locals.canteen.simplePrice,
                      trailingTitle: menuItemModel.priceSimple,
                    ),
                    if (_prices.first.basePrice > 0.0)
                      LmuListItem.base(
                        subtitle: context.locals.canteen.basePrice,
                        trailingTitle: '${_prices.first.basePrice.toStringAsFixed(2)} €',
                      ),
                    ..._prices.where((e) => e.pricePerUnit > 0.0).map(
                      (e) {
                        return LmuListItem.base(
                          subtitle: e.category.name(context.locals.canteen),
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
      ],
    );
  }
}

extension on PriceCategory {
  String name(CanteenLocalizations localizations) {
    return switch (this) {
      PriceCategory.students => localizations.students,
      PriceCategory.staff => localizations.staff,
      PriceCategory.guests => localizations.guests,
    };
  }
}
