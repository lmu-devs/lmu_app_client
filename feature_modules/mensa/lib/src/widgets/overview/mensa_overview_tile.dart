import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/likes_formatter_extension.dart';
import '../../extensions/opening_hours_extensions.dart';
import '../../routes/mensa_routes.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../../repository/api/api.dart';
import '../mensa_tag.dart';
import '../star_icon.dart';

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

  factory MensaOverviewTile.loading({String? name, hasLargeImage = false}) {
    return MensaOverviewTile(
      mensaModel: MensaModel.placeholder(
        name: name,
      ),
      isFavorite: false,
      hasLargeImage: hasLargeImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.app;
    final name = mensaModel.name;
    final type = mensaModel.type;
    final openingHours = mensaModel.openingHours;
    final status = openingHours.mensaStatus;
    final likeCount = mensaModel.ratingModel.likeCount;
    final imageUrl = mensaModel.images.isNotEmpty ? mensaModel.images.first.url : null;

    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.none : LmuSizes.medium),
      child: GestureDetector(
        onTap: () => MensaDetailsRoute(mensaModel).go(context),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
          ),
          child: Column(
            children: [
              if (hasLargeImage)
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.neutralColors.backgroundColors.tile,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(LmuSizes.mediumSmall),
                      topRight: Radius.circular(LmuSizes.mediumSmall),
                    ),
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  height: LmuSizes.mediumLarge * 10,
                ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(LmuSizes.mediumLarge),
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
                                  const SizedBox(width: LmuSizes.mediumSmall),
                                  MensaTag(type: type),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: LmuSizes.mediumSmall),
                                LmuText.bodyXSmall(
                                  likeCount.formattedLikes,
                                  weight: FontWeight.w400,
                                  color: context.colors.neutralColors.textColors.weakColors.base,
                                ),
                                const SizedBox(width: LmuSizes.small),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ScaleTransition(
                                        scale: Tween<double>(begin: 0.5, end: 1).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: isFavorite ? Curves.elasticOut : Curves.easeOutCirc,
                                          ),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: StarIcon(
                                    isActive: isFavorite,
                                    key: ValueKey(isFavorite),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LmuText.body(
                              status.text(context.locals.canteen, openingHours: openingHours),
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
                  // touch target for favorite toggle
                  Positioned(
                    right: 0,
                    bottom: LmuSizes.mediumLarge,
                    top: LmuSizes.mediumSmall,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
                        final id = mensaModel.canteenId;

                        LmuVibrations.vibrate(type: VibrationType.secondary);

                        if (isFavorite) {
                          LmuToast.show(
                            context: context,
                            type: ToastType.success,
                            message: localizations.favoriteRemoved,
                            actionText: localizations.undo,
                            onActionPressed: () {
                              userPreferencesService.toggleFavoriteMensaId(id);
                            },
                          );
                        } else {
                          LmuToast.show(
                            context: context,
                            type: ToastType.success,
                            message: localizations.favoriteAdded,
                          );
                        }

                        userPreferencesService.toggleFavoriteMensaId(id);
                      },
                      child: const SizedBox(width: 64),
                    ),
                  ),
                ],
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
