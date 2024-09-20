import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';
import 'package:mensa/src/widgets/dish_tile.dart';

class MensaMenuContentView extends StatelessWidget {
  const MensaMenuContentView({
    Key? key,
    required this.mensaMenuModel,
  }) : super(key: key);

  final MensaMenuWeekModel mensaMenuModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: mensaMenuModel.mensaMenuDayModels.first.dishModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
        child: DishTile(
          dishType: mensaMenuModel.mensaMenuDayModels.first.dishModels[index].dishType,
          title: mensaMenuModel.mensaMenuDayModels.first.dishModels[index].name,
          priceSimple: mensaMenuModel.mensaMenuDayModels.first.dishModels[index].priceSimple,
          isFavorite: false,
          onFavoriteTap: () {},
        ),
      ),
    );
  }
}
