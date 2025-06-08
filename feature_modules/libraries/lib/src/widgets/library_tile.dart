import 'package:core/components.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core_routes/libraries.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/extensions.dart';
import '../repository/api/api.dart';
import '../services/libraries_status_update_service.dart';
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
    final statusUpdateService = GetIt.I.get<LibrariesStatusUpdateService>();
    final distanceService = GetIt.I.get<LocationService>();

    return ListenableBuilder(
      listenable: statusUpdateService,
      builder: (context, child) {
        final libraryStatusStyle = library.getDominantStyledStatus(context);

        return ListenableBuilder(
          listenable: distanceService,
          builder: (context, _) {
            final libraryLocation = library.location;
            final distance = distanceService.getDistance(lat: libraryLocation.latitude, long: libraryLocation.longitude);

            return LmuCard(
              title: library.name,
              customSubtitle: LibraryStatusRow(
                openingStatusText: libraryStatusStyle.text,
                openingStatusColor: libraryStatusStyle.color,
                distance: distance,
              ),
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
      },
    );
  }
}

class LibraryStatusRow extends StatelessWidget {
  const LibraryStatusRow({
    super.key,
    this.openingStatusText,
    this.openingStatusColor,
    this.distance,
  });

  final String? openingStatusText;
  final Color? openingStatusColor;
  final double? distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (openingStatusText != null && openingStatusColor != null)
          LmuText.body(
            openingStatusText,
            color: openingStatusColor,
          ),
        if (openingStatusText != null && openingStatusColor != null && distance != null)
          LmuText.body(
            " • ",
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
        if (distance != null)
          LmuText.body(
            distance!.formatDistance(),
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
      ],
    );
  }
}
