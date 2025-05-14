import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/mensa/mensa_model.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../widgets.dart';

class MensaOverviewReorderableFavoriteSection extends StatelessWidget {
  const MensaOverviewReorderableFavoriteSection({
    super.key,
    required this.mensaModels,
  });

  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final userPreferencesService = GetIt.I<MensaUserPreferencesService>();

    final canteenLocals = context.locals.canteen;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;
    final starColor = context.colors.neutralColors.textColors.weakColors.base;

    return ValueListenableBuilder(
      valueListenable: userPreferencesService.favoriteMensaIdsNotifier,
      builder: (context, value, _) {
        return LmuReorderableFavoriteList(
          favoriteIds: value,
          placeholder: Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_4),
            child: PlaceholderTile(
              key: const ValueKey('placeholderTile'),
              minHeight: 80,
              content: [
                LmuText.bodySmall(
                  canteenLocals.emptyFavoritesBefore,
                  color: placeholderTextColor,
                ),
                StarIcon(
                  isActive: false,
                  disabledColor: starColor,
                  size: LmuSizes.size_16,
                ),
                LmuText.bodySmall(
                  canteenLocals.emptyFavoritesAfter,
                  color: placeholderTextColor,
                ),
              ],
            ),
          ),
          onReorder: (oldIndex, newIndex) {
            final order = List.of(value);
            final item = order.removeAt(oldIndex);
            order.insert(newIndex, item);
            userPreferencesService.updateFavoriteMensaOrder(order);
          },
          itemBuilder: (context, index) {
            final mensaModel = mensaModels.where((element) => element.canteenId == value[index]).first;
            return Padding(
              key: ValueKey(mensaModel.canteenId),
              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_6),
              child: MensaOverviewTile(
                mensaModel: mensaModel,
                isFavorite: true,
              ),
            );
          },
        );
      },
    );
  }
}
