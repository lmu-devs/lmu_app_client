import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/api.dart';
import '../../routes/mensa_routes.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../common/mensa_tag.dart';
import '../common/star_icon.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.mensaModel,
    required this.isFavorite,
    this.distance,
    this.hasDivider = false,
    this.hasLargeImage = false,
    this.hasButton = false,
    this.buttonText,
    this.buttonAction,
  });

  final MensaModel mensaModel;
  final bool isFavorite;
  final double? distance;
  final bool hasDivider;
  final bool hasLargeImage;
  final bool hasButton;
  final String? buttonText;
  final VoidCallback? buttonAction;

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
    final colors = context.colors;

    final name = mensaModel.name;
    final type = mensaModel.type;

    final openingStatus = mensaModel.currentOpeningStatus;
    final openingStatusStyling =
        openingStatus.openingStatus(context, openingDetails: mensaModel.openingHours.openingHours);
    final imageUrl = mensaModel.images.isNotEmpty ? mensaModel.images.first.url : null;

    return Padding(
      padding: EdgeInsets.only(bottom: hasDivider ? LmuSizes.none : LmuSizes.size_12),
      child: GestureDetector(
        onTap: () => MensaDetailsRoute(mensaModel).go(context),
        child: Container(
          decoration: BoxDecoration(
            color: colors.neutralColors.backgroundColors.tile,
            borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
          ),
          child: Column(
            children: [
              if (hasLargeImage)
                Container(
                  height: LmuSizes.size_16 * 10,
                  decoration: BoxDecoration(
                    color: colors.neutralColors.backgroundColors.tile,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(LmuSizes.size_8),
                      topRight: Radius.circular(LmuSizes.size_8),
                    ),
                    image: imageUrl != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: LmuCachedNetworkImageProvider(
                              imageUrl,
                            ),
                          )
                        : null,
                  ),
                ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(LmuSizes.size_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: LmuText.body(
                                      name,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: LmuSizes.size_8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: MensaTag(type: type),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: LmuSizes.size_8),
                                  LmuText.bodyXSmall(
                                    mensaModel.ratingModel.calculateLikeCount(isFavorite),
                                    weight: FontWeight.w400,
                                    color: colors.neutralColors.textColors.weakColors.base,
                                  ),
                                  const SizedBox(width: LmuSizes.size_4),
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
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LmuText.body(
                              openingStatusStyling.text,
                              color: openingStatusStyling.color,
                            ),
                            if (distance != null)
                              LmuText.body(
                                " • $distance",
                                color: colors.neutralColors.textColors.mediumColors.base,
                              ),
                          ],
                        ),
                        hasButton
                            ? Padding(
                                padding: const EdgeInsets.only(top: LmuSizes.size_12),
                                child: LmuButton(
                                  emphasis: ButtonEmphasis.secondary,
                                  showFullWidth: true,
                                  title: buttonText ?? '',
                                  onTap: buttonAction,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  // touch target for favorite toggle
                  Positioned(
                    right: 0,
                    bottom: LmuSizes.size_16,
                    top: LmuSizes.size_8,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();
                        final id = mensaModel.canteenId;

                        LmuVibrations.secondary();

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
}
