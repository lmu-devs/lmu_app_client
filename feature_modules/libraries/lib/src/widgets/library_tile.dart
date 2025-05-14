import 'package:core/components.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core_routes/libraries.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../services/libraries_user_preference_service.dart';

class LibraryTile extends StatelessWidget {
  const LibraryTile({
    super.key,
    required this.library,
    required this.isFavorite,
    this.hasDivider = false,
    this.hasLargeImage = false,
  });

  final LibraryModel library;
  final bool isFavorite;
  final bool hasDivider;
  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    final distanceService = GetIt.I.get<LocationService>();

    return ListenableBuilder(
      listenable: distanceService,
      builder: (context, _) {
        final mensaLocation = library.location;
        final distance = distanceService.getDistance(lat: mensaLocation.latitude, long: mensaLocation.longitude);

        return LmuCard(
          title: library.name,
          customSubtitle: LibraryStatusRow(distance: distance),
          imageUrl: (hasLargeImage && library.images.isNotEmpty) ? library.images.first.url : null,
          hasLargeImage: hasLargeImage,
          hasDivider: hasDivider,
          hasFavoriteStar: true,
          isFavorite: isFavorite,
          favoriteCount: library.rating.calculateLikeCount(isFavorite),
          onFavoriteTap: () {
            final userPreferencesService = GetIt.I.get<LibrariesUserPreferenceService>();
            final id = library.id;
            final favoriteIndex = userPreferencesService.favoriteLibraryIdsNotifier.value.indexOf(id);

            LmuVibrations.secondary();

            if (isFavorite) {
              LmuToast.show(
                context: context,
                type: ToastType.success,
                message: context.locals.app.favoriteRemoved,
                actionText: context.locals.app.undo,
                onActionPressed: () {
                  userPreferencesService.toggleFavoriteLibraryId(id, insertIndex: favoriteIndex);
                },
              );
            } else {
              LmuToast.show(
                context: context,
                type: ToastType.success,
                message: context.locals.app.favoriteAdded,
              );
            }

            userPreferencesService.toggleFavoriteLibraryId(id);
          },
          onTap: () => LibraryDetailsRoute(library).go(context),
        );
      },
    );
  }
}

class LibraryStatusRow extends StatelessWidget {
  const LibraryStatusRow({
    super.key,
    this.distance,
  });

  final double? distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (distance != null)
          LmuText.body(
            distance!.formatDistance(),
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
      ],
    );
  }
}
