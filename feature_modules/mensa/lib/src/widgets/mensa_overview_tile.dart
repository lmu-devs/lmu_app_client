import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';
import 'mensa_tag.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.title,
    required this.type,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.distance,
    this.onTap,
  });

  final String title;
  final double? distance;
  final MensaType type;
  final MensaStatus status;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.medium),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(
          LmuSizes.mediumLarge,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: LmuText.body(
                          title,
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
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: isFavorite
                      ? LmuIcon(
                          icon: Icons.star,
                          size: LmuIconSizes.medium,
                          color: context.colors.warningColors.textColors.strongColors.base,
                        )
                      : LmuIcon(
                          icon: Icons.star_border_outlined,
                          size: LmuIconSizes.medium,
                          color: context.colors.neutralColors.backgroundColors.flippedColors.base,
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LmuText.body(
                  status.name,
                  color: status.textColor(context),
                ),
                LmuText.body(
                  " • ",
                  color: context.colors.neutralColors.textColors.mediumColors.base,
                ),
                LmuText.body(
                  distanceString,
                  color: context.colors.neutralColors.textColors.mediumColors.base,
                ),
              ],
            )
          ],
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

extension MensaStatusExtension on MensaStatus {
  Color textColor(BuildContext context) {
    final colors = context.colors;

    switch (this) {
      case MensaStatus.open:
        return colors.successColors.textColors.strongColors.base;
      case MensaStatus.closed:
        return colors.neutralColors.textColors.mediumColors.base;
      case MensaStatus.closingSoon:
        return colors.warningColors.textColors.strongColors.base;
      default:
        return colors.neutralColors.textColors.mediumColors.base;
    }
  }
}
