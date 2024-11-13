import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';
import 'package:mensa/src/widgets/dish_tile.dart';

class MensaMenuContentView extends StatelessWidget {
  const MensaMenuContentView({
    Key? key,
    required this.mensaMenuModels,
    required this.currentDayOfWeek,
  }) : super(key: key);

  final List<MensaMenuWeekModel> mensaMenuModels;
  final int currentDayOfWeek;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(LmuSizes.mediumLarge),
      itemCount: mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
        child: DishTile(
          dishType: mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index].dishType,
          title: mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index].name,
          priceSimple: mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index].priceSimple,
          isLiked: false,
          likeCount:
              mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index].ratingModel.likeCount,
          onFavoriteTap: () {},
        ),
      ),
    );
  }
}
