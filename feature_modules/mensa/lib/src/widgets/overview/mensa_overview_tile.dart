import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/api.dart';
import '../../routes/mensa_routes.dart';
import '../../services/services.dart';
import '../common/mensa_tag.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.mensaModel,
    required this.isFavorite,
    this.hasDivider = false,
    this.hasLargeImage = false,
  });

  final MensaModel mensaModel;
  final bool isFavorite;
  final bool hasDivider;
  final bool hasLargeImage;

  factory MensaOverviewTile.loading({String? name, hasLargeImage = false, bool hasDivider = true}) {
    return MensaOverviewTile(
      mensaModel: MensaModel.placeholder(
        name: name,
      ),
      isFavorite: false,
      hasLargeImage: hasLargeImage,
      hasDivider: hasDivider,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    final colors = context.colors;

    final tagData = mensaModel.type.getTagData(colors, localizations);

    final distanceService = GetIt.I.get<LocationService>();
    final statusUpdateService = GetIt.I.get<MensaStatusUpdateService>();

    return ListenableBuilder(
      listenable: statusUpdateService,
      builder: (context, child) {
        final openingStatus = mensaModel.currentOpeningStatus;
        final openingStatusStyling =
            openingStatus.openingStatusShort(context, openingDetails: mensaModel.openingHours.openingHours);

        return ListenableBuilder(
          listenable: distanceService,
          builder: (context, _) {
            final mensaLocation = mensaModel.location;
            final distance = distanceService.getDistance(lat: mensaLocation.latitude, long: mensaLocation.longitude);

            return LmuCard(
              title: mensaModel.name,
              tag: tagData.text,
              customTagColor: tagData.backgroundColor,
              customTagTextColor: tagData.textColor,
              customSubtitle: MensaStatusRow(
                openingStatusText: openingStatusStyling.text,
                openingStatusColor: openingStatusStyling.color,
                distance: distance,
              ),
              imageUrl: (hasLargeImage && mensaModel.images.isNotEmpty) ? mensaModel.images.first.url : null,
              hasLargeImage: hasLargeImage,
              hasDivider: hasDivider,
              hasFavoriteStar: true,
              isFavorite: isFavorite,
              favoriteCount: mensaModel.ratingModel.calculateLikeCount(isFavorite),
              onFavoriteTap: () {
                final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
                final id = mensaModel.canteenId;
                final favoriteIndex = userPreferencesService.favoriteMensaIdsNotifier.value.indexOf(id);

                LmuVibrations.secondary();

                if (isFavorite) {
                  LmuToast.show(
                    context: context,
                    type: ToastType.success,
                    message: context.locals.app.favoriteRemoved,
                    actionText: context.locals.app.undo,
                    onActionPressed: () {
                      userPreferencesService.toggleFavoriteMensaId(id, insertIndex: favoriteIndex);
                    },
                  );
                } else {
                  LmuToast.show(
                    context: context,
                    type: ToastType.success,
                    message: context.locals.app.favoriteAdded,
                  );
                }

                userPreferencesService.toggleFavoriteMensaId(id);
              },
              onTap: () => MensaDetailsRoute(mensaModel).go(context),
            );
          },
        );
      },
    );
  }
}

class MensaStatusRow extends StatelessWidget {
  const MensaStatusRow({
    super.key,
    required this.openingStatusText,
    required this.openingStatusColor,
    this.distance,
  });

  final String openingStatusText;
  final Color openingStatusColor;
  final double? distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LmuText.body(
          openingStatusText,
          color: openingStatusColor,
        ),
        if (distance != null)
          Padding(
            padding: const EdgeInsets.only(left: LmuSizes.size_6),
            child: LmuText.body(
              "• ${distance!.formatDistance()}",
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
          ),
      ],
    );
  }
}
