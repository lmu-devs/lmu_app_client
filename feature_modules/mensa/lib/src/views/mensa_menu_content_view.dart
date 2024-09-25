import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';
import 'package:mensa/src/widgets/dish_tile.dart';

class MensaMenuContentView extends StatelessWidget {
  const MensaMenuContentView({
    Key? key,
    required this.mensaMenuModels,
  }) : super(key: key);

  final List<MensaMenuWeekModel> mensaMenuModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: mensaMenuModels.first.mensaMenuDayModels.first.dishModels.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
        child: DishTile(
          dishType: mensaMenuModels.first.mensaMenuDayModels.first.dishModels[index].dishType,
          title: mensaMenuModels.first.mensaMenuDayModels.first.dishModels[index].name,
          priceSimple: mensaMenuModels.first.mensaMenuDayModels.first.dishModels[index].priceSimple,
          isFavorite: false,
          onFavoriteTap: () {},
        ),
      ),
    );
  }
}
