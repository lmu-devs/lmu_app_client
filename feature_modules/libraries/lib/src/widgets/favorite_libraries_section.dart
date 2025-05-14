import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../services/libraries_user_preference_service.dart';
import 'library_tile.dart';

class FavoriteLibrariesSection extends StatelessWidget {
  const FavoriteLibrariesSection({super.key, required this.libraries});

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    final userPreferencesService = GetIt.I.get<LibrariesUserPreferenceService>();

    return ValueListenableBuilder(
      valueListenable: userPreferencesService.favoriteLibraryIdsNotifier,
      builder: (context, favoriteLibraryIds, _) {
        return LmuReorderableFavoriteList(
          favoriteIds: favoriteLibraryIds,
          placeholder: Padding(
            padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_4),
            child: PlaceholderTile(
              key: const ValueKey('placeholderTile'),
              minHeight: 80,
              content: [
                LmuText.bodySmall(
                  context.locals.libraries.emptyFavoritesBefore,
                  color: context.colors.neutralColors.textColors.mediumColors.base,
                ),
                StarIcon(
                  isActive: false,
                  disabledColor: context.colors.neutralColors.textColors.weakColors.base,
                  size: LmuSizes.size_16,
                ),
                LmuText.bodySmall(
                  context.locals.libraries.emptyFavoritesAfter,
                  color: context.colors.neutralColors.textColors.mediumColors.base,
                ),
              ],
            ),
          ),
          onReorder: (oldIndex, newIndex) {
            final order = List.of(favoriteLibraryIds);
            final item = order.removeAt(oldIndex);
            order.insert(newIndex, item);
            userPreferencesService.updateFavoriteLibrariesOrder(order);
          },
          itemBuilder: (context, index) {
            final library = libraries.where((library) => library.id == favoriteLibraryIds[index]).first;
            return Padding(
              key: ValueKey(library.id),
              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_6),
              child: LibraryTile(
                library: library,
                isFavorite: true,
              ),
            );
          },
        );
      },
    );
  }
}
