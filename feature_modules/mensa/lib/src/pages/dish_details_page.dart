import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/menu/menu_item_model.dart';
import '../repository/api/models/menu/price_category.dart';
import '../repository/api/models/menu/price_model.dart';
import '../repository/api/models/taste_profile/taste_profile_label_item.dart';
import '../services/mensa_user_preferences_service.dart';
import '../services/taste_profile_service.dart';

class DishDetailsPage extends StatefulWidget {
  const DishDetailsPage({
    super.key,
    required this.menuItemModel,
  });

  final MenuItemModel menuItemModel;

  @override
  State<DishDetailsPage> createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  late ValueNotifier<PriceCategory> _selectedPriceCategoryNotifier;

  final _tasteProfileService = GetIt.I<TasteProfileService>();
  final _userPreferenceService = GetIt.I<MensaUserPreferencesService>();

  @override
  void initState() {
    super.initState();
    _selectedPriceCategoryNotifier = ValueNotifier(_userPreferenceService.initialPriceCategory);
  }

  MenuItemModel get _menuItemModel => widget.menuItemModel;

  List<TasteProfileLabelItem> get labelItems => _menuItemModel.labels
      .map((e) => _tasteProfileService.getLabelItemFromId(e))
      .where((element) => element != null)
      .cast<TasteProfileLabelItem>()
      .toList()
      .sortedBy((element) => element.enumName);

  @override
  Widget build(BuildContext context) {
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
                    valueListenable: _userPreferenceService.favoriteDishIdsNotifier,
                    builder: (context, favoriteDishIds, _) {
                      final isFavorite = favoriteDishIds.contains(_menuItemModel.id);
                      return LmuButton(
                        leadingWidget: StarIcon(isActive: isFavorite),
                        title:
                            "${_menuItemModel.ratingModel.calculateLikeCount(isFavorite)} ${context.locals.app.likes}",
                        emphasis: ButtonEmphasis.secondary,
                        onTap: () => _userPreferenceService.toggleFavoriteDishId(_menuItemModel.id),
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
              ValueListenableBuilder(
                  valueListenable: _selectedPriceCategoryNotifier,
                  builder: (context, selectedPriceCategory, _) {
                    final price = _menuItemModel.prices.firstWhere(
                      (element) => element.category == selectedPriceCategory,
                    );

                    final priceString = context.locals.canteen.pricePerUnit(
                      price.pricePerUnit.toStringAsFixed(2),
                      price.unit,
                    );

                    return LmuContentTile(
                      content: [
                        if (price.basePrice > 0.0)
                          LmuListItem.base(
                            title: context.locals.canteen.basePrice,
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
                                priceModels: _menuItemModel.prices,
                                priceCategoryNotifier: _selectedPriceCategoryNotifier,
                              ),
                            );
                          },
                        ),
                        LmuListItem.base(
                          title: context.locals.canteen.simplePrice,
                          trailingTitle: _menuItemModel.priceSimple,
                        ),
                      ],
                    );
                  }),
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
                        trailingTitle: priceModel.priceString(context.locals.canteen),
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
                      if (priceModel != priceModels.last) const SizedBox(height: LmuSizes.size_8),
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
