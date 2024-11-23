import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/menu/menu_item_model.dart';
import '../repository/api/models/menu/price_category.dart';
import '../repository/api/models/menu/price_model.dart';
import '../services/mensa_user_preferences_service.dart';

class MenuDetailsPage extends StatelessWidget {
  MenuDetailsPage({
    super.key,
    required this.menuItemModel,
    required PriceCategory initialPriceCategory,
  }) : _selectedPriceCategoryNotifier = ValueNotifier(initialPriceCategory);

  final MenuItemModel menuItemModel;

  final ValueNotifier<PriceCategory> _selectedPriceCategoryNotifier;

  @override
  Widget build(BuildContext context) {
    return LmuScaffoldWithAppBar(
      collapsedTitleHeight: 54,
      largeTitle: menuItemModel.title,
      stretch: false,
      leadingAction: LeadingAction.close,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.mediumLarge),
              Row(
                children: [
                  LmuButton(
                    leadingIcon: LucideIcons.heart,
                    title: "${menuItemModel.ratingModel.likeCount} Likes",
                    emphasis: ButtonEmphasis.secondary,
                  ),
                  const SizedBox(width: LmuSizes.mediumSmall),
                  const LmuButton(
                    title: "Erinnere mich",
                    trailingIcon: LucideIcons.bell,
                    emphasis: ButtonEmphasis.secondary,
                  ),
                  const SizedBox(width: LmuSizes.mediumSmall),
                  const LmuButton(
                    title: "Teilen",
                    emphasis: ButtonEmphasis.secondary,
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.xxlarge),
              LmuTileHeadline.base(title: "Inhalte"),
              LmuContentTile(
                content: menuItemModel.labels
                    .map(
                      (e) => LmuListItem.base(
                        title: e,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: LmuSizes.xxlarge),
              LmuTileHeadline.base(title: "Price"),
              ValueListenableBuilder(
                  valueListenable: _selectedPriceCategoryNotifier,
                  builder: (context, selectedPriceCategory, _) {
                    final price = menuItemModel.prices.firstWhere(
                      (element) => element.category == selectedPriceCategory,
                    );

                    final priceString = "${price.pricePerUnit} € je ${price.unit}";

                    return LmuContentTile(
                      content: [
                        if (price.basePrice > 0.0)
                          LmuListItem.base(
                            title: "Base Price",
                            trailingTitle: '${price.basePrice} €',
                          ),
                        LmuListItem.base(
                          title: selectedPriceCategory.name(context.locals.canteen),
                          trailingTitle: priceString,
                          trailingTitleInTextVisuals: [
                            LmuInTextVisual.iconBox(
                              icon: LucideIcons.chevrons_up_down,
                            )
                          ],
                          onTap: () {
                            LmuBottomSheet.show(
                              context,
                              content: _PriceCategoryActionSheetContent(
                                priceModels: menuItemModel.prices,
                                priceCategoryNotifier: _selectedPriceCategoryNotifier,
                              ),
                            );
                          },
                        ),
                        LmuListItem.base(
                          title: "Simple Price",
                          trailingTitle: menuItemModel.priceSimple,
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: LmuSizes.xhuge),
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
  String get priceString => "$pricePerUnit € je $unit";
}

class _PriceCategoryActionSheetContent extends StatelessWidget {
  const _PriceCategoryActionSheetContent({
    required this.priceModels,
    required this.priceCategoryNotifier,
  });

  final List<PriceModel> priceModels;
  final ValueNotifier<PriceCategory> priceCategoryNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: priceCategoryNotifier,
        builder: (context, selectedPriceCategory, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...priceModels.map(
                (priceModel) {
                  final category = priceModel.category;
                  final isActive = category == selectedPriceCategory;

                  final textColor = category.textColor(
                    context.colors,
                    isActive: isActive,
                  );

                  return Column(
                    children: [
                      LmuListItem.base(
                        title: priceModel.category.name(context.locals.canteen),
                        trailingTitle: priceModel.priceString,
                        trailingTitleColor: textColor,
                        titleColor: textColor,
                        mainContentAlignment: MainContentAlignment.center,
                        onTap: () async {
                          priceCategoryNotifier.value = category;
                          await GetIt.I.get<MensaUserPreferencesService>().updatePriceCategory(category);
                          Future.delayed(
                            const Duration(milliseconds: 100),
                            () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          );
                        },
                      ),
                      if (priceModel != priceModels.last) const SizedBox(height: LmuSizes.mediumSmall),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

extension PriceCategoryVisualizerExtension on PriceCategory {
  Color textColor(LmuColors colors, {required bool isActive}) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}
