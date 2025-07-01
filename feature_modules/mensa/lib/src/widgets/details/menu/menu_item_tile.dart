import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../extensions/dish_asset_mapper_extension.dart';
import '../../../pages/dish_details_page.dart';
import '../../../repository/api/models/menu/menu_item_model.dart';
import '../../../services/mensa_user_preferences_service.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    super.key,
    required this.menuItemModel,
    required this.isFavorite,
    this.hasDivider = false,
    this.excludedLabelItemsName,
  });

  final MenuItemModel menuItemModel;
  final bool hasDivider;
  final bool isFavorite;
  final List<String>? excludedLabelItemsName;

  @override
  Widget build(BuildContext context) {
    final AnalyticsClient analytics = GetIt.I<AnalyticsClient>();

    return Column(
      children: [
        LmuCard(
          title: menuItemModel.title,
          titleWeight: FontWeight.w400,
          customSubtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LmuSizes.size_8),
              Row(
                children: [
                  if (menuItemModel.getCategoryName().isNotEmpty) ...[
                    LmuTextBadge(
                        title: menuItemModel.getCategoryName()),
                    const SizedBox(width: LmuSizes.size_4),
                  ],
                  LmuTextBadge(title: menuItemModel.priceSimple),
                ],
              ),
              if (excludedLabelItemsName != null &&
                  excludedLabelItemsName!.isNotEmpty) ...[
                const SizedBox(height: LmuSizes.size_8),
                Wrap(
                  spacing: LmuSizes.size_4,
                  runSpacing: LmuSizes.size_4,
                  children: excludedLabelItemsName!.mapIndexed(
                    (index, name) {
                      return LmuTextBadge(
                        title: name,
                        badgeType: BadgeType.destructive,
                      );
                    },
                  ).toList(),
                ),
              ],
            ],
          ),
          hasDivider: hasDivider,
          hasFavoriteStar: true,
          isFavorite: isFavorite,
          favoriteCount:
              menuItemModel.ratingModel.calculateLikeCount(isFavorite),
          onFavoriteTap: () => _toggleDishFavorite(context),
          onTap: () => {
            analytics.logClick(
              eventName: "dish_details_page_opened",
              parameters: {
                "dish_id": menuItemModel.id,
                "dish_name": menuItemModel.title,
                "dish_category": menuItemModel.dishCategory.name,
                "dish_type": menuItemModel.dishType,
                "dish_price_simple": menuItemModel.priceSimple,
                "dish_likes": menuItemModel.ratingModel.likeCount,
              },
            ),
            LmuBottomSheet.showExtended(
              context,
              content: DishDetailsPage(menuItemModel: menuItemModel),
            ),
          },
        ),
        /**Padding(
            padding: EdgeInsets.only(
            bottom: hasDivider ? LmuSizes.size_12 : LmuSizes.none),
            child: GestureDetector(
            onTap: () {
            final AnalyticsClient analytics = GetIt.I<AnalyticsClient>();
            analytics.logClick(
            eventName: "dish_details_page_opened",
            parameters: {
            "dish_id": menuItemModel.id,
            "dish_name": menuItemModel.title,
            "dish_category": menuItemModel.dishCategory.name,
            "dish_type": menuItemModel.dishType,
            "dish_price_simple": menuItemModel.priceSimple,
            "dish_likes": menuItemModel.ratingModel.likeCount,
            },
            );
            LmuBottomSheet.showExtended(
            context,
            content: DishDetailsPage(menuItemModel: menuItemModel),
            );
            },
            child: Container(
            decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuSizes.size_12),
            ),
            width: double.infinity,
            child: Stack(
            children: [
            Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
            padding: const EdgeInsets.only(top: LmuSizes.size_4),
            child: Container(
            width: LmuSizes.size_20,
            height: LmuSizes.size_20,
            decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(LmuSizes.size_6),
            image: DecorationImage(
            image: AssetImage(
            menuItemModel.getCategoryIcon(),
            ),
            fit: BoxFit.cover,
            ),
            ),
            ),
            ),
            const SizedBox(width: LmuSizes.size_12),
            Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            children: [
            Expanded(
            child: LmuText.body(
            menuItemModel.title,
            ),
            ),
            ],
            ),
            if (excludedLabelItemsName != null &&
            excludedLabelItemsName!.isNotEmpty)
            Padding(
            padding: const EdgeInsets.only(
            top: LmuSizes.size_8),
            child: Wrap(
            spacing: LmuSizes.size_4,
            runSpacing: LmuSizes.size_4,
            children:
            excludedLabelItemsName!.mapIndexed(
            (index, name) {
            return LmuInTextVisual.text(
            title: name,
            actionType: ActionType.destructive,
            );
            },
            ).toList(),
            ),
            )
            ],
            ),
            ),
            const SizedBox(width: LmuSizes.size_12),
            Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Padding(
            padding: const EdgeInsets.symmetric(
            vertical: LmuSizes.size_2),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            if (_ratingModel.likeCount >= 0)
            LmuText.bodyXSmall(
            _ratingModel
            .calculateLikeCount(isFavorite),
            color: context.colors.neutralColors
            .textColors.weakColors.base,
            ),
            if (_ratingModel.likeCount >= 0)
            const SizedBox(width: LmuSizes.size_4),
            const SizedBox(width: LmuSizes.size_20),
            // placeholder for star
            ],
            ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(
            vertical: LmuSizes.size_2),
            child: ConstrainedBox(
            constraints: const BoxConstraints(
            minWidth: LmuSizes.size_20),
            child: Center(
            child: LmuText.bodyXSmall(
            menuItemModel.priceSimple,
            color: context.colors.neutralColors
            .textColors.weakColors.base,
            ),
            ),
            ),
            ),
            ],
            ),
            ],
            ),
            ),
            Positioned(
            right: LmuSizes.size_6,
            top: LmuSizes.size_8,
            child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _toggleDishFavorite(context),
            child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
            child: StarIcon(isActive: isFavorite),
            ),
            ),
            ),
            ),
            ],
            ),
            ),
            ),
            ),**/
      ],
    );
  }

  void _toggleDishFavorite(BuildContext context) {
    final localizations = context.locals.app;
    final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
    final id = menuItemModel.id;

    LmuVibrations.secondary();

    if (isFavorite) {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteRemoved,
        actionText: localizations.undo,
        onActionPressed: () {
          userPreferencesService.toggleFavoriteDishId(id.toString());
        },
      );
    } else {
      LmuToast.show(
        context: context,
        type: ToastType.success,
        message: localizations.favoriteAdded,
      );
    }

    userPreferencesService.toggleFavoriteDishId(id.toString());
  }
}
