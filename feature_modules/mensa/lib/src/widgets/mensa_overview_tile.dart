import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/mensa_favorite_cubit/mensa_favorite_cubit.dart';
import '../extensions/opening_hours_extensions.dart';
import '../repository/api/api.dart';
import '../routes/mensa_routes.dart';
import 'mensa_tag.dart';
import 'star_icon.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.mensaModel,
    required this.isFavorite,
    this.distance,
    this.hasDivider = false,
    this.hasLargeImage = false,
  });

  final MensaModel mensaModel;
  final bool isFavorite;
  final double? distance;
  final bool hasDivider;
  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    final name = mensaModel.name;
    final type = mensaModel.type;
    final openingHours = mensaModel.openingHours;
    final status = openingHours.mensaStatus;
    final likeCount = mensaModel.ratingModel.likeCount;
    final imageUrl = mensaModel.images.isNotEmpty ? mensaModel.images.first.url : null;

    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.none : LmuSizes.medium),
      child: GestureDetector(
        onTap: () {
          MensaDetailsRoute(mensaModel).go(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuSizes.medium),
          ),
          child: Column(
            children: [
              if (hasLargeImage)
                Padding(
                  padding: const EdgeInsets.only(
                    top: LmuSizes.small,
                    left: LmuSizes.small,
                    right: LmuSizes.small,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.tile,
                      borderRadius: BorderRadius.circular(LmuSizes.mediumSmall),
                      image: imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    height: LmuSizes.mediumLarge * 10,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(
                  LmuSizes.mediumLarge,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: LmuText.body(
                                  name,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: LmuSizes.mediumSmall,
                              ),
                              MensaTag(
                                type: type,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: LmuSizes.mediumSmall,
                        ),
                        LmuText.bodyXSmall(
                          likeCount.formattedLikes,
                          weight: FontWeight.w400,
                          color: context.colors.neutralColors.textColors.weakColors.base,
                        ),
                        const SizedBox(
                          width: LmuSizes.small,
                        ),
                        GestureDetector(
                          onTap: () {
                            GetIt.I.get<MensaFavoriteCubit>().toggleFavoriteMensa(
                                  mensaId: mensaModel.canteenId,
                                );
                          },
                          child: isFavorite ? const StarIcon.active() : const StarIcon.inActive(),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LmuText.body(
                          status.text(context.localizations, openingHours: openingHours),
                          color: status.textColor(context.colors),
                        ),
                        if (distance != null)
                          LmuText.body(
                            " • $distance",
                            color: context.colors.neutralColors.textColors.mediumColors.base,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get distanceString {
    final randomDistance = _getRandomDoubleInRange(0.1, 15.0);
    return '$randomDistance km';
  }

  double _getRandomDoubleInRange(double min, double max) {
    Random random = Random();
    double randomDouble = min + (max - min) * random.nextDouble();
    return double.parse(randomDouble.toStringAsFixed(1));
  }
}

extension LikeFormatter on int {
  String get formattedLikes {
    if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}K";
    }
    return toString();
  }
}

extension MensaStatusExtension on MensaStatus {
  Color textColor(LmuColors colors) {
    switch (this) {
      case MensaStatus.open:
        return colors.successColors.textColors.strongColors.base;
      case MensaStatus.closed:
        return colors.neutralColors.textColors.mediumColors.base;
      case MensaStatus.closingSoon:
        return colors.warningColors.textColors.strongColors.base;
    }
  }

  String text(
    AppLocalizations localizations, {
    required List<MensaOpeningHours> openingHours,
  }) {
    switch (this) {
      case MensaStatus.open:
        return localizations.openNow;
      case MensaStatus.closed:
        return localizations.closed;
      case MensaStatus.closingSoon:
        return localizations.closingSoon(openingHours.closingTime);
    }
  }
}
