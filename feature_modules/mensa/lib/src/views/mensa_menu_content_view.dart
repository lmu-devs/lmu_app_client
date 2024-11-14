import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';
import 'package:mensa/src/widgets/dish_tile.dart';

import '../repository/api/models/dish_model.dart';

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
    final int amountMensaDays = mensaMenuModels.first.mensaMenuDayModels.length; 
    // TODO: Some canteens only have a menu for 4 days, so we need to check if the current day is within the range of the available days
    // important: we need to map the food to the right day of the week
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        itemCount: mensaMenuModels
            .first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels.length,
        itemBuilder: (context, index) {
          final DishModel dishModel = mensaMenuModels
              .first.mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index];

          print(mensaMenuModels.first.mensaMenuDayModels.length);
          print(currentDayOfWeek);
          return Padding(
            padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
            child: DishTile(
              dishModel: dishModel,
              onTap: () {
                print("Du geiler Hund");
              },
              onFavoriteTap: () {},
            ),
          );
        });
  }
}
