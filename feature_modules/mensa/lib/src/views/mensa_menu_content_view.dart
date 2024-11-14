import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/mensa_menu_week_model.dart';
import '../widgets/dish_tile.dart';
import '../repository/api/models/dish_model.dart';
import '../services/mensa_user_preferences_service.dart';

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
    final favoriteDishIdsNotifier =
        GetIt.I.get<MensaUserPreferencesService>().favoriteDishIdsNotifier;
    return ValueListenableBuilder(
        valueListenable: favoriteDishIdsNotifier,
        builder: (context, favoriteDishIds, _) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(LmuSizes.mediumLarge),
              itemCount: mensaMenuModels.first
                  .mensaMenuDayModels[currentDayOfWeek - 1].dishModels.length,
              itemBuilder: (context, index) {
                final isFavorite = favoriteDishIds.contains(
                  mensaMenuModels.first.mensaMenuDayModels[currentDayOfWeek - 1]
                      .dishModels[index].id
                      .toString(),
                );

                final DishModel dishModel = mensaMenuModels.first
                    .mensaMenuDayModels[currentDayOfWeek - 1].dishModels[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
                  child: DishTile(
                    dishModel: dishModel,
                    onTap: () {
                      print("Du geiler Hund");
                    },
                    isFavorite: isFavorite,
                    onFavoriteTap: () {},
                  ),
                );
              });
        });
  }
}
